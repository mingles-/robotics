function y = find_intruder(image)
    hsv = rgb2hsv(image);
    greenCount = 0;
    
    for i=1:64
        for j=1:64
           hue = hsv(i,j,1);
           if and(hue > 0.16666, hue < 0.5)
               greenCount = greenCount + 1;
           end
        end
    end
    
    %disp(greenCount);
    
    if greenCount > 100
        disp('INTRUDER DETECTED')
        y = 1;
    else
        y = 0;
    end
end