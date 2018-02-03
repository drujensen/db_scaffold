class DbScaffold::Application
  def initialize(table_name)
    table = Table.new(table_name)
    `./bin/amber g scaffold #{table.name} #{table.fields}`
  end
end
