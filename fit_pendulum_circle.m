function ret=fit_pendulum_circle(measurement)
    ret = measurement;
    A = ret.data;
    [fun, res] = fmin_fit_xy_line(A);

    m = res(2);
    k = res(1);
    
    cosarctan = @(x) 1 / sqrt(x.^2 + 1);
    sinarctan = @(x) x / sqrt(x.^2 + 1);

    %theta = arctan(k);
    %R = [cos(theta) -sin(theta); ...
    %     sin(theta)  cos(theta)];

    Rk = [cosarctan(k) sinarctan(k); ...
        -sinarctan(k)  cosarctan(k)];

    B = Rk * [A(:, 3) + m/k A(:, 4)]';
    x = B(1,:);
    y = B(2,:);

    minz = min(A(:,5));

    A(:, 3) = x;
    A(:, 4) = y;
    A(:, 5) = A(:,5) - minz;

    xy = [A(:,3) A(:,5)];
    res = CircleFitByPratt(xy);
        
    A(:, 3) = A(:, 3) - res(1);
    A(:, 5) = A(:,5) - res(2);

    ret.data = A;
    ret.radiusmm = res(3);
end
