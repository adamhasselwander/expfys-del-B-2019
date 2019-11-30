
function [a,b,alpha,beta,fun,tlocs,pks,resnorm]=calc_fd_spring(measurement)
    A = measurement.data;
    % A is now a nice circular arc with radius r and center in (0,r).
    x = A(:,3);
    y = A(:,4);
    z = A(:,5);
    t = A(:,2);
    m = measurement.mkg;
    k = measurement.k;
    
    [pks, tlocs] = findpeaks(z, t, 'MinPeakDistance', 2 * pi / sqrt(k/m) * 0.8);
    % Remove nonexistent peaks due to bad data
    tlocs = tlocs(pks > 0);
    pks = pks(pks > 0); 
    
    A0 = max(z); % has to be in SI units
    fun = @(b,t) ...
        A0 .* exp(-b(1).*t) ./ ...
        (b(2) .* (1 - exp(-b(1).*t)) + 1);

    x0 = {}; % inital guess (found by trial and error)
    x0.alpha = 1e-4;
    x0.beta = 1e-6;

    opts = optimset('Display','off');
    [sol2,resnorm,~,~,~] = lsqcurvefit(fun,[x0.alpha x0.beta],tlocs,pks,[ ],[ ],opts);

    % calculate a and b based on alpha and beta
    alpha = sol2(1);
    beta = sol2(2);

    % alpha = (1/2) a / m
    % beta = 8 A0 sqrt(k/m) b / (3 pi a)
    
    a = alpha * 2 * m;
    b = beta * (3 * pi * a / 8) * sqrt(m/k) / A0;

end
