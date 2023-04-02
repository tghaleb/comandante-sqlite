.PHONY: shards test docs

shards:
	shards install
test:
	crystal spec -v
docs:
	mkdocs build
serve:
	mkdocs serve
