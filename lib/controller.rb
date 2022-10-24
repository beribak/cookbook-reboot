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
        rating = @view.rating
        prep_time = @view.get_preptime
        recipe = Recipe.new(name, description, rating, prep_time)
        @cookbook.add_recipe(recipe) 
    end

    def destroy
        recipes = @cookbook.all
        @view.display_list(recipes)
        index = @view.index - 1
        @cookbook.remove_recipe(index) 
    end

    def mark
        recipes = @cookbook.all
        @view.display_list(recipes)
        index = @view.index
        @cookbook.mark(index - 1)    
    end

    def import
        recipes = []
        # 1 Ask the user for a food
        ingredient = @view.ask_for_food
        # 2 Scrape allrecipes
        url = "https://www.allrecipes.com/search?q=#{ingredient}"
        html = URI.open(url).read
        html_parsed = Nokogiri::HTML(html)

        html_parsed.search(".mntl-card-list-items").each do |element|
            if element.search(".icon-star").count > 0
                name =  element.search(".card__title-text").text
                rating = element.search(".icon-star").count

                url_one = element.attr("href")
                html_one = URI.open(url_one).read
                html_parsed_one = Nokogiri::HTML(html_one)

                prep_time = html_parsed_one.search(".mntl-recipe-details__item")[0].text.strip
                description = html_parsed_one.search(".article-subheading").text.strip
                recipes << Recipe.new(name, description, rating, prep_time) 
            end
        end

        # 3 Display scraped recepies
        @view.display_list(recipes)
        # 4 Ask user to select recipe
        index = @view.index - 1   
        # 5 Store recipe
        @cookbook.add_recipe(recipes[index])         
    end
end