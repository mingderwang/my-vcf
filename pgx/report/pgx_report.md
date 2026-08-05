# Pharmacogenomics report

- Source VCF: `variants.vcf.gz`
- Reference: GRCh37/hg19
- Called: 2026-08-05T06:52:54Z
- Disclaimer: educational only; not medical advice.

## Results

| Gene | Diplotype | Phenotype | Drugs | Action |
|---|---|---|---|---|
| CYP2C19 | *1/*2 | Intermediate metabolizer | clopidogrel; omeprazole; citalopram | clopidogrel: standard dose acceptable; consider alternative antiplatelet in high-risk PCI (CPIC). |
| CYP2C9 | *1/*1 | Normal metabolizer | warfarin; phenytoin; celecoxib | standard dosing. |
| VKORC1 | GA | Intermediate warfarin sensitivity | warfarin | lower starting dose. |
| SLCO1B1 | *1/*1 | Normal (low simvastatin risk) | simvastatin | standard dose. |
| TPMT | *1/*1 | Normal thiopurine activity | azathioprine; mercaptopurine; thioguanine | standard dose. |
| UGT1A1 | *1/*1 | Normal UGT1A1 activity | irinotecan | standard dose. |

## Defining variants observed (ALT copy counts)

| Gene | Star | rsID | chr:pos | ref>alt | Copies |
|---|---|---|---|---|---|
| CYP2C19 | *2 | rs4244285 | chr10:96541616 | G>A | 1 |
| CYP2C19 | *3 | rs4986893 | chr10:96540410 | G>A | 0 |
| CYP2C19 | *17 | rs12248560 | chr10:96521657 | C>T | 0 |
| CYP2C9 | *2 | rs1799853 | chr10:96702047 | C>T | 0 |
| CYP2C9 | *3 | rs1057910 | chr10:96741053 | A>C | 0 |
| VKORC1 | -1639 | rs9923231 | chr16:31107689 | C>T | 1 |
| SLCO1B1 | *5 | rs4149056 | chr12:21331549 | T>C | 0 |
| SLCO1B1 | *1B | rs2306283 | chr12:21329738 | A>G | 1 |
| TPMT | *2 | rs1800462 | chr6:18143955 | C>G | 0 |
| TPMT | *3B | rs1800460 | chr6:18139228 | C>T | 0 |
| TPMT | *3C | rs1142345 | chr6:18130918 | T>C | 0 |
| UGT1A1 | *6 | rs4148323 | chr2:234669144 | G>A | 0 |

## Caveats

- VCF is **unphased**: diplotypes are inferred from ALT copy counts and may be ambiguous for alleles defined by two markers (e.g. TPMT\*3A).
- **CYP2D6 and CYP3A4/5 excluded**: copy-number and phasing blind spots in mpileup-derived VCF.
- **UGT1A1\*28** (TA-repeat, rs8175347) is an STR that short-read/mpileup calling cannot genotype reliably and is **not assessed**.
- CYP2D6\* allele calls would be unreliable from this data.
