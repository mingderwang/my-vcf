# Pharmacogenomics report

- Source VCF: `variants.vcf.gz`
- Reference: GRCh37/hg19
- Called: 2026-08-05T07:55:38Z
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
| CYP2D6 | *1/*1 | Normal metabolizer (provisional; CNV unassessed) | SSRI/SNRI; tricyclic antidepressants; tramadol; codeine; antipsychotics | standard dose (CPIC); CYP2D6 copy-number variants not assessed. |

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
| CYP2D6 | *4 | rs3892097 | chr22:42524947 | C>A | 0 |
| CYP2D6 | *10 | rs1065852 | chr22:42526694 | G>A | 0 |
| CYP2D6 | *3 | rs35742686 | chr22:42524244 | T>- | 0 |
| CYP2D6 | *6 | rs5030655 | chr22:42525086 | A>- | 0 |
| CYP2D6 | *17 | rs28371706 | chr22:42525772 | G>A | 0 |
| CYP2D6 | *41 | rs28371725 | chr22:42523805 | C>T | 0 |
| CYP2D6 | *2 | rs1135840 | chr22:42522613 | G>C | 0 |
| CYP2D6 | *1B | rs16947 | chr22:42523943 | A>G | 2 |

## Research markers (NSAID hypersensitivity, NON-CPIC)

Association-study variants for NSAID cross-intolerance (leukotriene/COX pathways). Research-only: replication is inconsistent, they have no validated clinical predictive power, and they do NOT replace allergy work-up.

| Gene | Marker | rsID | chr:pos | ref>alt | Genotype |
|---|---|---|---|---|---|
| LTC4S | -444A>C | rs730012 | chr5:179220638 | A>C | hom-ref |
| PTGS1 | rs5789 | rs5789 | chr9:125143973 | C>A | hom-ref |
| PTGS1 | rs10306135 | rs10306135 | chr9:125137695 | A>T | hom-ref |
| PTGS2 | -765G>C | rs20417 | chr1:186650321 | C>G | hom-ref |
| PTGS2 | -1195G>A | rs689466 | chr1:186650751 | T>A | hom-ref |
| ALOX5 | rs2115819 | rs2115819 | chr10:45901089 | A>G | hom-alt |
| ALOX5 | rs10900213 | rs10900213 | chr10:45904714 | G>A | hom-ref |
| ALOX5 | rs12762303 | rs12762303 | chr10:45869171 | T>C | het |

## Caveats

- VCF is **unphased**: diplotypes are inferred from ALT copy counts and may be ambiguous for alleles defined by two markers (e.g. TPMT\*3A).
- **CYP2D6 is provisional (SNP markers only)**: called \*1/\*1 from 7 canonical variants. Copy-number variants (\*5 deletion, gene duplications) and the \*10/\*41 phasing are NOT assessable from an mpileup VCF; the CYP2D6/CYP2D7P paralog region can also produce spurious calls. Confirm clinically with Stargazer/Aldy/PyPGx on the BAM or a CYP2D6 array.
- **CYP2D6\*1B marker (rs16947)**: hg19 reference carries the minor allele at chr22:42523943, so a hom-ref sample appears A>G. This is a reference-genome quirk, not a \*2/\*41/\*1B call.
- **CYP3A4/5 excluded**: copy-number and phasing blind spots in mpileup-derived VCF.
- **UGT1A1\*28** (TA-repeat, rs8175347) is an STR that short-read/mpileup calling cannot genotype reliably and is **not assessed**.
- **NSAID hypersensitivity markers** are research-only associations (non-CPIC); a hom-ref call does NOT exclude cross-intolerance to ibuprofen/diclofenac/aspirin. Diagnosis is clinical (oral provocation by an allergist).
