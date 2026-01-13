#!/bin/bash
#
# download-docs.sh - Download Red Hat documentation PDFs from YAML manifest
#
# Usage: ./download-docs.sh <yaml_file>
# Requires: yq v4+ (https://github.com/mikefarah/yq), wget
#
set -euo pipefail

YAML_FILE="${1:-}"
[[ -z "$YAML_FILE" ]] && { echo "Usage: $0 <yaml_file>"; exit 1; }

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
YAML_PATH="$SCRIPT_DIR/$YAML_FILE"

# Validate dependencies and input
command -v yq >/dev/null 2>&1 || { echo "Error: 'yq' is required. Install from https://github.com/mikefarah/yq"; exit 1; }
[[ -f "$YAML_PATH" ]] || { echo "Error: File not found: $YAML_PATH"; exit 1; }

# Extract product info for output directory
PRODUCT=$(yq -r '.product // "docs"' "$YAML_PATH")
VERSION=$(yq -r '.version // "latest"' "$YAML_PATH")
OUTPUT_DIR="$SCRIPT_DIR/docs-${PRODUCT}-v${VERSION}"

echo "📚 Downloading documentation for: $PRODUCT v$VERSION"
echo "📁 Output directory: $OUTPUT_DIR"
echo

# Single yq call extracts one category/url per line (tab-separated), then loop processes them
yq -r '.documentation_sections[] | .category as $cat | .guides[].url as $u | [$cat, $u] | @tsv' "$YAML_PATH" | \
while IFS=$'\t' read -r category url; do
    # Sanitize category for filesystem
    category_dir=$(echo "$category" | tr ' ' '_' | tr -cd '[:alnum:]_-')
    target_dir="$OUTPUT_DIR/$category_dir"
    mkdir -p "$target_dir"
    
    filename=$(basename "$url")
    echo "⬇️  [$category] $filename"
    wget -q -N -P "$target_dir" "$url" || echo "   ⚠️  Failed: $url"
done

echo
echo "✅ Done! PDFs saved to: $OUTPUT_DIR"
