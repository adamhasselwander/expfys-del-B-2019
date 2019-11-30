function [fun,s]=fmin_fit_xy_line(data)

    x = data(:,3);
    y = data(:,4);
    
    [maxx, i] = max(x);
    [minx, j] = min(x);
    
    l = 1;
    for xx=x
        if (abs(xx) < 0.001)
            break;
        end
        l = l + 1;
    end
    
    estk = (y(i) - y(j)) / (maxx - minx);
    estm = y(l);
    
    % Estimate offset
    fun = @(b,x)  b(1) .* x  + b(2);             % Function to fit
    fcn = @(b) sum((fun(b,x) - y).^2);                                              % Sum-squared-error cost function
    s = fminsearch(fcn, [estk; estm]);
    
end