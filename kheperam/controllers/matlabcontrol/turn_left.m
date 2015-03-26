function turn_left(speed, odom)
    wb_differential_wheels_set_speed(-speed, speed);
    odom.turn(speed);
end