# Session: Add Published Feature to TIL Repo

**Date:** 2025-11-24

## Summary

Added a `published` frontmatter field to support draft/publish workflow for GitHub Pages deployment.

## Changes Made

### 1. YAML Frontmatter Added to All TILs
- Added `published: true` to all 20 existing TILs
- New TILs default to `published: false`

### 2. Jekyll Configuration (`_config.yml`)
- Set up for GitHub Pages deployment
- Configured `baseurl: /til` for project page routing
- Excluded non-content files (Makefile, docs/, etc.)
- Default `published: false` for new pages

### 3. Makefile Tasks
- `make new CATEGORY=x NAME=y` - Create unpublished TIL with frontmatter template
- `make scrub` - Call Claude Code to scan `~/dev/**/docs/sessions` for TIL ideas, saves to `docs/scrubs/`
- `make publish` - List unpublished TILs
- `make count` - Show published vs unpublished counts

### 4. Documentation
- Moved usage docs from README to `docs/USAGE.md`
- Kept README clean for GitHub Pages display

## Commits

1. Add published: true frontmatter to all existing TILs
2. Add Jekyll config for GitHub Pages
3. Add Makefile for TIL management
4. Add usage instructions to README
5. Add baseurl for GitHub Pages project site
6. Move usage docs to docs/USAGE.md
7. Remove usage section from README
8. Exclude docs/ from Jekyll build
9. Trigger GitHub Pages rebuild
10. Update scrub task to call Claude Code directly
11. Save scrub output to timestamped session file
12. Change scrub output path to docs/scrubs/

## Workflow

```bash
# Create new TIL (unpublished by default)
make new CATEGORY=elixir NAME=my-learning

# Edit the TIL content
vim elixir/my-learning.md

# When ready to publish, change frontmatter:
# published: false → published: true

# Commit and push - GitHub Pages rebuilds automatically
```
