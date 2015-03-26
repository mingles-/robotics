function tests = odometryTest
    tests = functiontests(localfunctions);
end

function test_rotate_vector(testCase)
    odom = odometry(0, 0, 0);
    
    odom.rotate_direction(pi/2);
    x = int8(odom.dir(1));
    y = int8(odom.dir(2));
    expected = [int8(-1); int8(0)];
    verifyEqual(testCase, [x; y], expected)
end

function test_turn_left(testCase)
    odom = odometry(0.1, 10, 100);
    odom.turn(10);
    x = odom.dir(1);
    y = odom.dir(2);
    verifyTrue(testCase, x < 0);
    verifyTrue(testCase, y < 1);
end