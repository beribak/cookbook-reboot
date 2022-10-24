class View 

    def display_list(recipes)
        recipes.each_with_index do |recipe, index|
            done = recipe.done ? "[x]" : "[ ]" 
            puts "#{index + 1} #{recipe.name} #{recipe.rating} #{done} #{recipe.prep_time}"
        end
    end

    def name 
        p "Pleate put a name."
        gets.chomp
    end

    def description
        p "Pleate put a description."
        gets.chomp
    end

    def rating
        p "Pleate put a rating."
        gets.chomp
    end

    def get_preptime
        p "Pleate put a preptime."
        gets.chomp
    end

    def index 
        p "Index?"
        gets.chomp.to_i
    end

    def ask_for_food 
        p "Please tell us what ingredient do you want to use?"
        gets.chomp
    end
end