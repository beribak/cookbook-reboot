class Recipe 
    attr_reader :name, :description, :rating, :prep_time
    attr_accessor :done, :prep_time

    def initialize(name, description, rating, prep_time)
        @name = name
        @prep_time = prep_time
        @rating = rating
        @description = description
        @done = false
    end
end