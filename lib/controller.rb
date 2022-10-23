require_relative "view"
require "open-uri"
require "nokogiri"

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
        prep_time = @view.prep_time
        recipe = Recipe.new(name, description, prep_time)
        @cookbook.add_recipe(recipe) 
    end

    def destroy
        recipes = @cookbook.all
        @view.display_list(recipes)

        index = @view.index
        @cookbook.remove_recipe(index - 1)
    end

    def import_recipes 
        # 1 Ask the user for a dish for the recipe
        dish = @view.ask_user_for_dish
        # 2 Scrape the website search page -- https://www.allrecipes.com/search?q=pizza
        recipes = []
        
        url = "https://www.allrecipes.com/search?q=#{dish}"
        
        html_file = File.open("lib/pizza.html").read  # URI.open(url).read
        html_doc = Nokogiri::HTML(html_file)
        
        # 3 Get the top 5 recipes
        html_doc.search(".card").first(10).each do |element|
            if element.search(".icon-star").count > 0
                title = element.search(".card__title").text.strip
                puts title
                # rating = element.search(".icon-star").count
                show_html = URI.open(element.attribute("href")).read
                show_doc = Nokogiri::HTML(show_html)
                description = show_doc.search(".article-subheading").text.strip
                # p description
                prep_time = show_doc.search(".mntl-recipe-details__content").search(".mntl-recipe-details__value").first.text.strip
                # p prep_time
                recipes << Recipe.new(title,description, prep_time)
            end
        end
        # 4 Display the recipes to the user
            @view.display_list(recipes)     
        # 5 Let the user select a recipe
            index = @view.index
        # 6 Add recipe to repository
            @cookbook.add_recipe(recipes[index - 1])
    end
end