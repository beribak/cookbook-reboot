require_relative "view"

class Controller 
    def initialize(cookbook)
        @cookbook = cookbook
        @view = View.new
    end

    def list
        recipes = @cookbook.all
        @view.display_list(recipes)
    end

    def create
        name = @view.name
        description = @view.description

        recipe = Recipe.new(name, description)
        @cookbook.add_recipe(recipe) 
    end

    def destroy
        recipes = @cookbook.all
        @view.display_list(recipes)

        index = @view.index
        @cookbook.remove_recipe(index - 1)
    end
end