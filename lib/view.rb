class View 

    def display_list(recipes)
        recipes.each_with_index do |recipe, index|
            puts "#{index + 1} #{recipe.name}"
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

    def index 
        p "Index?"
        gets.chomp.to_i
    end
end