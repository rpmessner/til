# TIL Usage

## Makefile Commands

```bash
# Create a new unpublished TIL
make new CATEGORY=elixir NAME=my-new-til

# List unpublished TILs
make publish

# Count published vs unpublished
make count

# Scan session docs for TIL ideas
make scrub
```

## Publishing Workflow

New TILs are created with `published: false` in the frontmatter:

```yaml
---
published: false
---

# My TIL Title
```

Change to `published: true` when ready to publish to GitHub Pages.

## Adding a New Category

1. Create the directory: `mkdir my-category`
2. Create a TIL: `make new CATEGORY=my-category NAME=my-til`
3. Update README.md to add the category to the table of contents
