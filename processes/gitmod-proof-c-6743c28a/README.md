# gitmod\_proof\_c

<!-- Generated from process.yaml. Do not edit: the next export overwrites this file. -->

git\-3\-3 modules live proof fixture

## Contract

- Schema version: `1.1.0`
- Script language: `bash`
- Fidelity: `strict` (generator `contract-lift-1.1.0`)

## Inputs

| id | type | cardinality | required | artifact | file type |
| --- | --- | --- | --- | --- | --- |
| `fixture_result` | string | single | yes | file | txt |

## Outputs

| id | type | cardinality | required | artifact | file type |
| --- | --- | --- | --- | --- | --- |
| `fixture_final` | string | single | yes | file | txt |

## Fidelity notes

These record what the contract could not fully specify. A `loose` port validates only
what is known, and a later revision can tighten it.

- nextflow backend\_version unspecified: legacy processes carry no version
