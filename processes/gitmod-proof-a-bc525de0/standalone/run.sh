#!/usr/bin/env bash
# Generated from process.yaml. Do not edit.
set -euo pipefail
cd "$(dirname "$0")/.."

# No container digest is reserved for this revision yet. Publication regenerates
# this file with the reserved digest as the default.
IMAGE="${VIA_PROCESS_IMAGE:?set VIA_PROCESS_IMAGE to the container image to run}"

# Nextflow accepts -with-docker, -with-podman, -with-apptainer, -with-singularity.
ENGINE="${VIA_CONTAINER_ENGINE:-docker}"

PARAMS="${VIA_PARAMS_FILE:-tests/test-inputs.json}"
if [ ! -f "$PARAMS" ]; then
  echo "No input manifest at $PARAMS." >&2
  echo "Set VIA_PARAMS_FILE to a params file for this process. A relative path is resolved" >&2
  echo "from the repository root, not from your working directory, because this script" >&2
  echo "changes to the repository root before reading it." >&2
  exit 1
fi

nextflow run main.nf \
  "-with-$ENGINE" "$IMAGE" \
  -params-file "$PARAMS" \
  --outdir "${1:-results}"
