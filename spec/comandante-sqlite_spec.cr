require "./spec_helper"

include Comandante

describe Comandante::SQLite do
  it "initialize with a db file should work" do
    Cleaner.tempfile do |file|
      db = SQLite.new(file)
      file.should eq db.file
    end
  end
  it "can create a table" do
    Cleaner.tempfile do |file|
      tbl = "tester ( name TEXT);"
      db = SQLite.new(file)
      db.create_table(tbl)
    end
  end

  it "inserting/selecting works" do
    Cleaner.tempfile do |file|
      tbl = "tester ( name TEXT);"
      db = SQLite.new(file)
      db.create_table(tbl)
      db.db.exec("insert or ignore into tester (name) values (?);",
        "foo")
      db.db.query("select name from tester;") do |rs|
        rs.each do
          rs.read(String).should eq "foo"
        end
      end

      # FIXME: add insert and select
    end
  end
end
