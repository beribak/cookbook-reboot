require "csv"
require_relative "recipe"

class Cookbook
    def initialize(csv_path)
        @recipes = []
        @filepath = csv_path
        
        CSV.foreach(csv_path) do |row|
            recipe = Recipe.new(row[0], row[1], row[2], row[4])
            recipe.done = row[3] == "true"
            @recipes << recipe 
        end
    end 

    def mark(index)
       @recipes[index].done = true
       save_to_csv
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
                csv << [recipe.name, recipe.description, recipe.rating, recipe.done, recipe.prep_time]
            end
        end
    end
end