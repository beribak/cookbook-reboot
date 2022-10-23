class Recipe 
    attr_reader :name, :description, :prep_time
    def initialize(name, description, prep_time)
        @name = name
        @description = description
        @prep_time = prep_time
    end
end