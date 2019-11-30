function color=get_color(measurement, offset)
    if (nargin == 1)
        offset = 0;
    end
    
    colors = cubehelix(256);
    i = 0;
    if (measurement.mkg == 0.066)
        i = 2;
    elseif (measurement.mkg == 0.110)
        i = 3;
    elseif (measurement.mkg == 0.140)
        i = 4;
    elseif (measurement.mkg == 0.235)
        i = 5;
    end
    if (i == 0) 
        color = [0 0 0];
        return
    end
    
    color = colors(floor(length(colors) / 7 * i + offset), :);
end