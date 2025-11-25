.PHONY: scrub new help

# Default target
help:
	@echo "TIL Management Tasks"
	@echo "===================="
	@echo "make scrub    - Scan ~/dev/**/docs/sessions for TIL-worthy content"
	@echo "make new      - Create a new unpublished TIL (usage: make new CATEGORY=elixir NAME=my-til-name)"
	@echo "make publish  - List all unpublished TILs"
	@echo "make count    - Count published vs unpublished TILs"

# Scrub session docs for new TIL content
# Uses Claude Code to analyze session files and suggest TILs
scrub:
	@echo "Scanning ~/dev/**/docs/sessions for TIL-worthy content..."
	@find ~/dev -path "*/docs/sessions/*" -name "*.md" -o -path "*/docs/sessions/*" -name "*.jsonl" 2>/dev/null | \
		head -20 | \
		xargs -I {} echo "Found: {}"
	@echo ""
	@echo "To analyze these sessions, run Claude Code in this directory and ask:"
	@echo "  'Analyze the session files in ~/dev/**/docs/sessions and suggest new TILs'"

# Create a new unpublished TIL
# Usage: make new CATEGORY=elixir NAME=my-til-name
new:
ifndef CATEGORY
	$(error CATEGORY is required. Usage: make new CATEGORY=elixir NAME=my-til-name)
endif
ifndef NAME
	$(error NAME is required. Usage: make new CATEGORY=elixir NAME=my-til-name)
endif
	@mkdir -p $(CATEGORY)
	@if [ -f "$(CATEGORY)/$(NAME).md" ]; then \
		echo "Error: $(CATEGORY)/$(NAME).md already exists"; \
		exit 1; \
	fi
	@echo "---" > $(CATEGORY)/$(NAME).md
	@echo "published: false" >> $(CATEGORY)/$(NAME).md
	@echo "---" >> $(CATEGORY)/$(NAME).md
	@echo "" >> $(CATEGORY)/$(NAME).md
	@echo "# " >> $(CATEGORY)/$(NAME).md
	@echo "" >> $(CATEGORY)/$(NAME).md
	@echo "Created: $(CATEGORY)/$(NAME).md (unpublished)"

# List unpublished TILs
publish:
	@echo "Unpublished TILs:"
	@echo "================"
	@grep -rl "published: false" --include="*.md" . 2>/dev/null | grep -v README.md || echo "None found"

# Count TILs by status
count:
	@echo "TIL Status:"
	@echo "==========="
	@printf "Published:   %d\n" $$(grep -rl "published: true" --include="*.md" . 2>/dev/null | grep -v README.md | wc -l)
	@printf "Unpublished: %d\n" $$(grep -rl "published: false" --include="*.md" . 2>/dev/null | grep -v README.md | wc -l)
