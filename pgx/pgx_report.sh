#!/usr/bin/env bash
# PGx star-allele report from a diploid, unphased VCF (GRCh37/hg19).
# Usage: pgx_report.sh [variants.vcf.gz] [output.md]
set -euo pipefail

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
VCF="${1:-variants.vcf.gz}"
OUT="${2:-pgx/report/pgx_report.md}"
DEFS="$DIR/defs/variants.tsv"
DIPLOS="$DIR/defs/diplotypes.tsv"

[ -f "$VCF" ] || { echo "error: $VCF not found" >&2; exit 1; }
command -v bcftools >/dev/null || { echo "error: bcftools required" >&2; exit 1; }

# copies_of <chrom> <pos> <alt>  -> prints 0, 1, or 2 (ALT allele copies)
copies_of() {
  local chrom="$1" pos="$2" alt="$3"
  local rec
  rec=$(bcftools query -r "${chrom}:${pos}-${pos}" -f '%CHROM\t%POS\t%REF\t%ALT\t[%GT]\n' "$VCF" 2>/dev/null || true)
  if [ -z "$rec" ]; then
    echo 0
    return
  fi
  local galt gt idx found i a
  galt=$(echo "$rec" | cut -f4)
  gt=$(echo "$rec" | cut -f5)
  idx=1; found=0
  IFS=',' read -ra alts <<< "$galt"
  i=1
  for a in "${alts[@]}"; do
    if [ "$a" = "$alt" ]; then idx=$i; found=1; break; fi
    i=$((i+1))
  done
  [ "$found" -eq 1 ] || { echo 0; return; }
  echo "$gt" | tr '/|' '\n' | awk -v t="$idx" '$0==t {c++} END {print c+0}'
}

# copies_cache.tsv: one line per defining variant "gene<TAB>star<TAB>copies"
CACHE=$(mktemp "${TMPDIR:-/tmp}/pgx.XXXXXX")
trap 'rm -f "$CACHE"' EXIT
while IFS=$'\t' read -r gene star rsid chrom pos ref alt effect cat; do
  [ -n "$gene" ] && [ "$gene" != "gene" ] || continue
  printf '%s\t%s\t%s\n' "$gene" "$star" "$(copies_of "$chrom" "$pos" "$alt")"
done < "$DEFS" > "$CACHE"

get_copies() {
  awk -F '\t' -v g="$1" -v s="$2" '$1==g && $2==s {print $3}' "$CACHE" | head -1
}

# norm2: sort two star alleles numerically (e.g. *17/*2 -> *2/*17)
norm2() {
  local a="$1" b="$2" na nb
  na=${a#\*}; nb=${b#\*}
  if [ "$na" -gt "$nb" ]; then echo "$b/$a"; else echo "$a/$b"; fi
}

# finish2: if the two markers sum < 2, fill with *1; if sum > 2 report ambig.
finish2() {
  local a="$1" b="$2"
  if [ -n "$a" ] && [ -n "$b" ]; then norm2 "$a" "$b"; return; fi
  if [ -n "$a" ]; then norm2 "$a" '*1'; return; fi
  if [ -n "$b" ]; then norm2 '*1' "$b"; return; fi
  echo "*1/*1"
}

build2() {
  # args: n_a a  n_b b  -> diplotype (2 markers max)
  local n1="$1" al1="$2" n2="$3" al2="$4"
  local h=() i
  for ((i=0; i<n1; i++)); do h+=("$al1"); done
  for ((i=0; i<n2; i++)); do h+=("$al2"); done
  if [ "${#h[@]}" -gt 2 ]; then echo "ambig"; return; fi
  finish2 "${h[0]:-}" "${h[1]:-}"
}

build3() {
  # args: n_a a n_b b n_c c -> diplotype (3 markers; >2 markers -> ambig unless exactly 2)
  local n1="$1" al1="$2" n2="$3" al2="$4" n3="$5" al3="$6"
  local h=() i
  for ((i=0; i<n1; i++)); do h+=("$al1"); done
  for ((i=0; i<n2; i++)); do h+=("$al2"); done
  for ((i=0; i<n3; i++)); do h+=("$al3"); done
  if [ "${#h[@]}" -gt 2 ]; then echo "ambig"; return; fi
  finish2 "${h[0]:-}" "${h[1]:-}"
}

# resolve functions ----------------------------------------------------------
resolve_cyp2c19() {
  local n2 n3 n17
  n2=$(get_copies CYP2C19 '*2'); n3=$(get_copies CYP2C19 '*3'); n17=$(get_copies CYP2C19 '*17')
  build3 "$n2" '*2' "$n3" '*3' "$n17" '*17'
}

resolve_cyp2c9() {
  local n2 n3
  n2=$(get_copies CYP2C9 '*2'); n3=$(get_copies CYP2C9 '*3')
  build2 "$n2" '*2' "$n3" '*3'
}

resolve_vkorc1() {
  # rs9923231 forward C>T; T = -1639A (low-dose). Report in -1639 orientation.
  local n
  n=$(get_copies VKORC1 '-1639')
  case "$n" in
    0) echo "GG";;
    1) echo "GA";;
    2) echo "AA";;
  esac
}

resolve_slco1b1() {
  local n5
  n5=$(get_copies SLCO1B1 '*5')
  build2 "$n5" '*5' 0 '*1'
}

resolve_tpmt() {
  local n2 nb nc shared nf
  n2=$(get_copies TPMT '*2'); nb=$(get_copies TPMT '*3B'); nc=$(get_copies TPMT '*3C')
  # *3A = *3B + *3C in cis; assume cis (most common) -> shared copies count once.
  shared=$(( nb < nc ? nb : nc ))
  nf=$(( n2 + nb + nc - shared ))
  if [ "$nf" -eq 0 ]; then echo "*1/*1"
  elif [ "$nf" -eq 2 ]; then
    if [ "$n2" -eq 2 ]; then echo "*2/*2"
    elif [ "$n2" -eq 1 ] && [ "$shared" -ge 1 ]; then echo "*2/*3A"
    elif [ "$shared" -ge 1 ] && [ "$nb" -gt 1 ]; then echo "*3A/*3A"
    elif [ "$shared" -ge 1 ] && [ "$nc" -gt 1 ]; then echo "*3A/*3C"
    elif [ "$nb" -eq 1 ] && [ "$nc" -eq 1 ]; then echo "*3B/*3C"
    else echo "*?/*?"; fi
  else
    if [ "$n2" -eq 1 ]; then echo "*1/*2"
    elif [ "$nb" -eq 1 ] && [ "$nc" -eq 1 ]; then echo "*1/*3A"
    elif [ "$nb" -eq 1 ]; then echo "*1/*3B"
    elif [ "$nc" -eq 1 ]; then echo "*1/*3C"
    else echo "*1/*?"; fi
  fi
}

resolve_ugt1a1() {
  local n6
  n6=$(get_copies UGT1A1 '*6')
  build2 "$n6" '*6' 0 '*1'
}

lookup() {
  local gene="$1" dip="$2"
  awk -F '\t' -v g="$gene" -v d="$dip" '$1==g && $2==d {print $3 "\n" $4 "\n" $5}' "$DIPLOS"
}

# report ---------------------------------------------------------------------
mkdir -p "$(dirname "$OUT")"
{
  echo "# Pharmacogenomics report"
  echo
  echo "- Source VCF: \`$VCF\`"
  echo "- Reference: GRCh37/hg19"
  echo "- Called: $(date -u +%Y-%m-%dT%H:%M:%SZ)"
  echo "- Disclaimer: educational only; not medical advice."
  echo
  echo "## Results"
  echo
  echo "| Gene | Diplotype | Phenotype | Drugs | Action |"
  echo "|---|---|---|---|---|"
  for gene in CYP2C19 CYP2C9 VKORC1 SLCO1B1 TPMT UGT1A1; do
    case "$gene" in
      CYP2C19) dip=$(resolve_cyp2c19);;
      CYP2C9)  dip=$(resolve_cyp2c9);;
      VKORC1)  dip=$(resolve_vkorc1);;
      SLCO1B1) dip=$(resolve_slco1b1);;
      TPMT)    dip=$(resolve_tpmt);;
      UGT1A1)  dip=$(resolve_ugt1a1);;
    esac
    read -r pheno <<< "$(lookup "$gene" "$dip" | sed -n 1p)"
    read -r drugs <<< "$(lookup "$gene" "$dip" | sed -n 2p)"
    read -r action <<< "$(lookup "$gene" "$dip" | sed -n 3p)"
    [ -n "$pheno" ] || { pheno="Unresolved"; drugs="-"; action="See defining variants below."; }
    echo "| $gene | $dip | $pheno | $drugs | $action |"
  done
  echo
  echo "## Defining variants observed (ALT copy counts)"
  echo
  echo "| Gene | Star | rsID | chr:pos | ref>alt | Copies |"
  echo "|---|---|---|---|---|---|"
  while IFS=$'\t' read -r gene star rsid chrom pos ref alt effect cat; do
    [ -n "$gene" ] && [ "$gene" != "gene" ] || continue
    copies=$(get_copies "$gene" "$star")
    echo "| $gene | $star | $rsid | $chrom:$pos | $ref>$alt | $copies |"
  done < "$DEFS"
  echo
  echo "## Caveats"
  echo
  echo "- VCF is **unphased**: diplotypes are inferred from ALT copy counts and may be ambiguous for alleles defined by two markers (e.g. TPMT\*3A)."
  echo "- **CYP2D6 and CYP3A4/5 excluded**: copy-number and phasing blind spots in mpileup-derived VCF."
  echo "- **UGT1A1\*28** (TA-repeat, rs8175347) is an STR that short-read/mpileup calling cannot genotype reliably and is **not assessed**."
  echo "- CYP2D6\* allele calls would be unreliable from this data."
} > "$OUT"

echo "wrote $OUT"
