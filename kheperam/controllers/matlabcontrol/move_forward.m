function move_forward(speed, odom)
    wb_differential_wheels_set_speed(speed, speed);
    odom.move(speed);
end