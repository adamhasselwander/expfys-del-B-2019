function k=calc_spring_const(dataA, dataB, m)
    dx = abs(mean(dataB(:, 5)) - mean(dataA(:, 5))) / 1000;
    k = m.mkg * m.g / dx;
end
