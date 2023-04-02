# Comandante/SQLite

An add-on for Comandante to simplify working with `sqlite`.

## Installation

1. Add the dependency to your `shard.yml`:

```yaml
dependencies:
  comandante-sqlite:
    github: tghaleb/comandante-sqlite
```

2. Run `shards install`

## Usage

```crystal
require "comandante-sqlite"
```

This is actually a wrapper around [sqlite](https://github.com/crystal-lang/crystal-sqlite3).

To setup a database,

```crystal
db = SQLite.new(path_to_db)
db.create_table(TBL_SQL)
db.close
```

:::Comandante::SQLite

