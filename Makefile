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
	@mkdir -p docs/sessions
	@claude --print --output-file docs/sessions/scrub-$$(date +%Y%m%d-%H%M%S).md "Scan ~/dev/**/docs/sessions for recent session files. Look for interesting learnings, patterns, or solutions that would make good TILs. For each potential TIL found, show: 1) suggested category, 2) suggested filename, 3) a brief summary. Skip anything already covered by existing TILs in this repo. Focus on practical, reusable knowledge."

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
