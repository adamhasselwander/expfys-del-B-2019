
function [measurement]=calc_fd_pendulum(measurement, nocopy)
    if nargin == 1
        nocopy = false;
    end

    measurement = fit_pendulum_circle(measurement);
    A = measurement.data;

    % A is now a nice circular arc with radius r and center in (0,r).
    x = A(:,3);
    y = A(:,4);
    z = A(:,5);
    t = A(:,2);
    r = measurement.radiusmm;
    g = measurement.g;
    m = measurement.mkg;
    l = r / 1000;

    thetadeg = atan(x./z) * (360 / (2 * pi));

    [pks, tlocs] = findpeaks(thetadeg, t, 'MinPeakDistance', 2 * pi / sqrt(g/l) * 0.8);
    % Remove nonexistent peaks due to bad data
    tlocs = tlocs(pks > 0);
    pks = pks(pks > 0); 

    mtd = max(thetadeg);
    fun = @(b,t) ...
        b(1) .* mtd .* exp(-b(1).*t) ./ ...
        (b(2) .* mtd .* (1 - exp(-b(1).*t)) + b(1));

    x0 = {}; % inital guess (found by trial and error)
    x0.alpha = 1e-05;
    x0.beta = 1e-08;

    opts = optimset('Display','off');
    [sol2,resnorm,~,~,~] = lsqcurvefit(fun,[x0.alpha x0.beta],tlocs,pks,[ ],[ ],opts);

    % calculate a and b based on alpha and beta
    alpha = sol2(1);
    beta = sol2(2);

    % alpha = (1/2) b / m
    % beta = (4/3) sqrt(g/l) c l / (m pi)
    
    a = alpha * 2 * m;
    b = beta * (3/4) * sqrt(l/g) * pi * m / l;
    
    measurement.a = a;
    measurement.b = b;
    
    if (nocopy == false)
        measurement.alpha = alpha;
        measurement.beta = beta;
        measurement.fun = fun;
        measurement.tlocs = tlocs;
        measurement.pks = pks;
        measurement.resnorm = resnorm;
    end

end
