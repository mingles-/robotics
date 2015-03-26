function wall_creeeep(target, threshold, left_pusher, right_pusher, sensor_values, odom)
    % continue old action squence if avaiable
    if left_pusher.is_acting()
        left_pusher.do_action(odom);
    elseif right_pusher.is_acting()
        right_pusher.do_action(odom);

    % find the next action
    elseif sensor_values(1) > (target + threshold)
        right_pusher.do_action(odom);
    elseif sensor_values(1) < (target - threshold)
        left_pusher.do_action(odom);
    else
        move_forward(10, odom)
    end;
end