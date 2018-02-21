require "./db_scaffold/*"

require "option_parser"

recipe = DbScaffold::Recipe.new
parser = OptionParser.parse([] of String) do |parser|
  parser.banner = "Usage: bin/db_scaffold {table_names}"
  parser.on("--type=TYPE", "Specify the generate type (default: scaffold)") {|v| recipe.type = v }
  parser.on("--all", "Process all tables") { recipe.all = true }
end
parser.parse!
recipe.tables = ARGV

if recipe.valid?
  DbScaffold::Application.new(recipe)
else
  puts "Error: Table Name required\n".colorize(:red)
  puts parser.to_s.colorize(:cyan)
end
