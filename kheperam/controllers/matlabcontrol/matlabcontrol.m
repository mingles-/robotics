'running robot';
TIME_STEP = 64;
N = 8;

% get and enable distance sensors
for i=1:N
  ps(i) = wb_robot_get_device(['ds' int2str(i-1)]);
  wb_distance_sensor_enable(ps(i),TIME_STEP);
end

% Calling MATLAB desktop versionwb_differential_wheels_set_speed(1, -1);
% desktop;

left_pusher = push_to_left();
right_pusher = push_to_right();
% main loop:
% perform simulation steps of TIME_STEP milliseconds
% and leave the controll to the keyboard
while wb_robot_step(TIME_STEP) ~= -1

  % read all distance sensors
       for i=1:N
           sensor_values(i) = wb_distance_sensor_get_value(ps(i));
       end
  % display all distance sensors values
       sensor_values
  left_speed=1;
  right_speed=1;
  
  target = 600;
  threshold = 50;
  
  % continue old action squence if avaiable
  if left_pusher.is_acting()
    left_pusher.do_action();
  elseif right_pusher.is_acting()
    right_pusher.do_action();
  
  % find the next action
  elseif sensor_values(1)>target+threshold
    right_pusher.do_action();
  elseif sensor_values(1)<target-threshold
    left_pusher.do_action();
  else
    wb_differential_wheels_set_speed(10, 10);
  end;
  %control goes to the keyboard
  %keyboard;
end
