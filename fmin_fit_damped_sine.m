function [fun,s]=fmin_fit_damped_sine(data, estA, estF)
    t = data(:,2);
    y = data(:,5);
    yu = max(y);
    yl = min(y);
    yr = (yu-yl);                                                                   % Range of ‘y’
    yz = y-yu+(yr/2);
    zx = t(yz .* circshift(yz,[1 0]) <= 0);                                         % Find zero-crossings
    per = 2*mean(diff(zx));                                                         % Estimate period
    ym = mean(y);                                                                   % Estimate offset
    fun = @(b,x)  b(1).*(cos(x./b(2) + 1/b(3))) .* exp(b(4).*x) + b(5);             % Function to fit
    fcn = @(b) sum((fun(b,t) - y).^2);                                              % Sum-squared-error cost function
    s = fminsearch(fcn, [estA; estF;  -1;  -1;  ym]);
end
