module DbScaffold
  class Recipe
    property type   : String        = "scaffold"
    property all    : Bool          = false
    property tables : Array(String) = Array(String).new

    def valid?
      all || tables.any?
    end
  end
end
