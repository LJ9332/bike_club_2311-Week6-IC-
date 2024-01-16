class Biker
    class Biker
        attr_reader :name,
                    :max_distance,
                    :rides, 
                    :acceptable_terrain
    
        def initialize(name, max_distance)
            @name = name
            @max_distance = max_distance
            @rides = Hash.new { |hash, key| hash[key] = [] }
            @acceptable_terrain = []
        end
    
        def learn_terrain!(terrain)
            @acceptable_terrain << terrain unless @acceptable_terrain.include?(terrain)
        end
    
        def log_ride(ride, time)
            return unless acceptable_ride?(ride)
    
            ride_info = {
            name: ride.name,
            distance: ride.distance,
            loop: ride.loop,
            terrain: ride.terrain
            }
    
            @rides[ride_info] << time
        end
    
        def personal_record(ride)
            return false unless @rides.key?(ride)
    
            times = @rides[ride]
            min_time = times.min
            min_time
        end
    
    
        #helper_method
        def acceptable_ride?(ride)
            if !@acceptable_terrain.include?(ride.terrain)
                return false
            else 
                return true
            end
          
            if ride.total_distance > @max_distance
                return false
            else 
                return true
            end
        end
    
          
    end
end