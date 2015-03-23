classdef push_to_left < handle
    properties
        state = 0;
    end

    methods
        
        function z = is_acting(obj)
            z = obj.state ~= 0;
        end
        
        function y = do_action(obj)
            obj.state = 1 + obj.state;
            if obj.state == 1
                wb_differential_wheels_set_speed(-10, 10);
            elseif obj.state == 2
                wb_differential_wheels_set_speed(1, 1);
            elseif obj.state == 3
                wb_differential_wheels_set_speed(10, -10);
            end
            
            
            % return false on last state
            if obj.state == 3
                obj.state = 0;
            end
        end
        
    end
    
end