function [new_home, new_print] = check_if_home(is_home, printed_home, odom)
  % print home when we renter the home zone
  if hypot(odom.pos, [0; 0]) < 100
      if is_home == 0
         printed_home = 0;
      end
      is_home = 1;
  else
      is_home = 0;
  end
  
  if and(is_home == 1, printed_home == 0)
      disp('We are home');
      printed_home = 1;
  end
  
  new_home = is_home;
  new_print = printed_home;
end