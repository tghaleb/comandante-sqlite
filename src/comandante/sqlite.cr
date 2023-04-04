class SQLite3::ResultSet < DB::ResultSet
  {% for n in [8, 16, 32] %}
  # reads Int{{n}} from sqlite
  def read(t : Int{{n}}.class) : Int{{n}}
    read(Int64).to_i{{n}}
  end
  {% end %}
end

module Comandante
  class SQLite
    @db : DB::Database
    @file : String = ""

    getter file
    getter db

    # common code for initialize and reset_db
    private macro init_db
      close
      if file == ""
        @db = DB.open "sqlite3::memory:"
      else
        @db = DB.open "sqlite3://#{File.expand_path(file)}"
        @file = File.expand_path(file)
      end
      Comandante::Cleaner.register(->{ self.close })
    end

    # Will automatically close db on exit or finalize.
    def initialize(file = "")
      # this is here because Crystal doesn't want to accept @db not
      # being initialized before the macro!! A Bug
      @db = DB.open "sqlite3::memory:"
      init_db
    end

    # Will close current db and open a new with given file name
    def reset_db(file = "")
      init_db
    end

    # Creates a table from given SQL
    def create_table(tbl_sql)
      @db.exec "create table IF NOT EXISTS " + tbl_sql
    end

    def close
      @db.close
    end

    def finalize
      close
    end
  end
end
