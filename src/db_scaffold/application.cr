require "amber"
require "db"
require "mysql"

class DbScaffold::Application
  def initialize(table_name)
    if table_name == "--all"
      table_names.each do |table_name|
        generate table_name
      end
    else
      generate table_name
    end
  end

  private def generate(table_name : String)
    table = Table.new(table_name)
    `./bin/amber g scaffold #{table.name} #{table.fields}`
  end

  private def table_names
    results = [] of String

    if database_url = Amber.settings.database_url
      DB.open database_url do |db|
        db.query schema do |rs|
          rs.each do
            results << rs.read(String)
          end
        end
      end
    else
      raise "database_url not found"
    end

    results
  end

  private def schema
    return "SELECT DISTINCT table_name" \
           " FROM information_schema.columns" \
           " WHERE table_schema = (SELECT DATABASE());"
  end
end
