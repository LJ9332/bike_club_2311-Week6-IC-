class Ride
    class Ride
        attr_reader :name, 
                    :distance, 
                    :terrain, 
                    :loop
        
            def initialize(attributes)
                @name = attributes[:name]
                @distance = attributes[:distance]
                @terrain = attributes[:terrain]
                @loop = attributes[:loop]
            end
            
            def loop?
                @loop
            end
        
            def total_distance
                if @loop
                    @distance
                else
                    @distance * 2
                end
            end
        end
end