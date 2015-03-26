classdef push_to_left < handle
    properties
        state = 0;
    end

    methods
        
        function z = is_acting(obj)
            z = obj.state ~= 0;
        end
        
        function y = do_action(obj, odom)
            obj.state = 1 + obj.state;
            if obj.state == 1
                turn_left(1, odom);
            elseif obj.state == 2
                move_forward(2, odom);
            end
            
            % return false on last state
            if obj.state == 2
                obj.state = 0;
            end
        end
        
    end
    
end