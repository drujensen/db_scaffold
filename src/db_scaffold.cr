require "./db_scaffold/*"

if table_name = ARGV[0]?
  DbScaffold::Application.new(table_name)
else
  puts "Error: Table Name required\n".colorize(:red)
  puts "bin/db_scaffold {table_name}".colorize(:cyan)
  puts "or".colorize(:light_gray)
  puts "bin/db_scaffold --all".colorize(:cyan)
end
