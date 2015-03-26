classdef odometry < handle
    properties
        pos = [0.0; 0.0];
        dir = [0.0; 1.0];
        time_step;
        wheel_speed;
        wheel_diameter;
        robot_diameter;
    end

    methods
        
        function obj = odometry(time_step, wheel_diameter, robot_diameter)
            obj.time_step = time_step;
            obj.wheel_diameter = wheel_diameter;
            obj.robot_diameter = robot_diameter;
        end
        
        function set_wheel_speed(obj, wheel_speed)
            obj.wheel_speed = wheel_speed;
        end
        
        function move(obj, dist)
            obj.pos(1) = obj.pos(1) + (dist * obj.dir(1));
            obj.pos(2) = obj.pos(2) + (dist * obj.dir(2));
        end
        
        function turn(obj, wheel_speed)
            obj.set_wheel_speed(wheel_speed);
            angle = obj.angle_robot_turns();
            %deg = 180 * angle / pi;
            obj.rotate_direction(angle);
        end
            
        function rotate_direction(obj, angle)
            R = [cos(angle) -sin(angle); sin(angle) cos(angle);];
            obj.dir = R * obj.dir;
        end
        
        function angle = angle_robot_turns(obj)
            dist = obj.dist_robot_turns();
            robot_circ = pi * obj.robot_diameter;
            angle = pi * dist/robot_circ;
        end
        
        function dist = dist_robot_turns(obj)
            angle = obj.angle_wheel_turns();
            wheel_circ = pi * obj.wheel_diameter;
            dist = wheel_circ * angle / (2 * pi);
        end
        
        function angle = angle_wheel_turns(obj)
            angle = obj.time_step * obj.wheel_speed;
        end
    end   
end