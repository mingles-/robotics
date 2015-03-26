'running robot';
TIME_STEP = 64;
N = 8;

% get and enable distance sensors
for i=1:N
  ps(i) = wb_robot_get_device(['ds' int2str(i-1)]);
  wb_distance_sensor_enable(ps(i),TIME_STEP);
end

% enable camera
c =  wb_robot_get_device('camera');
wb_camera_enable(c, TIME_STEP);

% Calling MATLAB desktop versionwb_differential_wheels_set_speed(1, -1);
% desktop;

left_pusher = push_to_left();
right_pusher = push_to_right();
odom = odometry((1/TIME_STEP), 10, 4.1015);

is_home = 1;
printed_home = 1;
detected_intruder = 0;
% main loop:
% perform simulation steps of TIME_STEP milliseconds
% and leave the controll to the keyboard
print = 0;
while wb_robot_step(TIME_STEP) ~= -1
  % count green in image
  image = wb_camera_get_image(c);
  
  if detected_intruder == 0
    detected_intruder = find_intruder(image);
  end
    
  print = print + 1;
  if mod(print, 10) == 0 
    % disp(odom.pos);
  end
  
  [is_home, printed_home] = check_if_home(is_home, printed_home, odom);
  
  % read all distance sensors
       for i=1:N
           sensor_values(i) = wb_distance_sensor_get_value(ps(i));
       end
  % display all distance sensors values
       % sensor_values
  left_speed=1;
  right_speed=1;
  
  target = 600;
  threshold = 100;
  % to handle corners
  if or(sensor_values(3) > target, or(sensor_values(4) > target, sensor_values(2) > target))
     turn_right(10, odom);
  else
      
    % normal distance
    if and(sensor_values(1) <= target + (2 * threshold), sensor_values(1) > 0)
        wall_creeeep(target, threshold, left_pusher, right_pusher, sensor_values, odom)
        
    % very close    
    elseif sensor_values(1) > target + (2 * threshold)
       turn_right(1, odom);
    % very far away    
    else
       turn_left(1, odom)
    end
  end
  %control goes to the keyboard
  %keyboard;
end
