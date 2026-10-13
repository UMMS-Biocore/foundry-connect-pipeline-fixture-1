# edit\_chromosome\_names

<!-- Generated from process.yaml. Do not edit: the next export overwrites this file. -->

Add a prefix and/or postfix to the chromosome names of a genome \(\.fa\) and/or annotation \(\.gtf\)\.

## Contract

- Schema version: `1.1.0`
- Script language: `sh`
- Fidelity: `strict` (generator `contract-lift-1.1.0`)

## Inputs

| id | type | cardinality | required | artifact | file type |
| --- | --- | --- | --- | --- | --- |
| `fasta` | string | single | no | file | fasta |
| `gtfFile` | string | single | no | file | gtf |

## Outputs

| id | type | cardinality | required | artifact | file type |
| --- | --- | --- | --- | --- | --- |
| `fasta__12574` | string | single | yes | file | fasta |
| `gtfFile__12575` | string | single | yes | file | gtf |

## Fidelity notes

These record what the contract could not fully specify. A `loose` port validates only
what is known, and a later revision can tighten it.

- duplicate port id "fasta" in outputs disambiguated to "fasta\_\_12574"
- duplicate port id "gtfFile" in outputs disambiguated to "gtfFile\_\_12575"
- nextflow backend\_version unspecified: legacy processes carry no version
