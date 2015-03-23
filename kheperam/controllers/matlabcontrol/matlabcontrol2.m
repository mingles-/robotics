
classdef matlabcontrol
    properties
        TIME_STEP = 64;
        N = 8;
        left_speed=1;
        right_speed=1;
    end
    
    methods 
        function obj = matlabcontrol()
        end
    end
    
    methods (Static)
        function turn_left()
            wb_differential_wheels_set_speed(-1, 1);
        end

        function turn_right()
            wb_differential_wheels_set_speed(-1, 1);
        end
        
        function main()
            % get and enable distance sensors
            for i=1:obj.N
                ps(i) = wb_robot_get_device(['ds' int2str(i-1)]);
                wb_distance_sensor_enable(ps(i), obj.TIME_STEP);
            end

            % Calling MATLAB desktop versionwb_differential_wheels_set_speed(1, -1);
            % desktop;

            % main loop:
            % perform simulation steps of TIME_STEP milliseconds
            % and leave the controll to the keyboard


            while wb_robot_step(obj.TIME_STEP) ~= -1

                % read all distance sensors
                    for i=1:self.N
                        sensor_values(i) = wb_distance_sensor_get_value(ps(i));
                    end
                % display all distance sensors values
                    sensor_values


                %set_speeds(left_speed,right_speed);
                %angular_sensor = sqrt(2* (26.5 + sensor_values(1))^2);
                %threshold = 10;
                
                %is_straight = and(sensor_values(2) < angular_sensor + threshold, sensor_values(2) > angular_sensor - threshold);

                if 
                

                end;
                %control goes to the keyboard
                %keyboard;
            end
        end
    end
end
