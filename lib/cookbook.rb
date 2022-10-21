require "csv"
require_relative "recipe"

class Cookbook
    def initialize(csv_path)
        @recipes = []
        @filepath = csv_path
        
        CSV.foreach(csv_path) do |row|
            @recipes << Recipe.new(row[0], row[1]) 
        end
    end 

    def all
        return @recipes
    end

    def add_recipe(recipe)
        @recipes << recipe
        save_to_csv
    end

    def remove_recipe(index)
        @recipes.delete_at(index) 
        save_to_csv
    end

    private
    
    def save_to_csv
        CSV.open(@filepath, "wb") do |csv|
            @recipes.each do |recipe|
                csv << [recipe.name, recipe.description]
            end
        end
    end
end