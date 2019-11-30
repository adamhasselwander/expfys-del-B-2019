function ret=calc_fd_pendulum_monte_carlo(measurement)

    n = 10000;
    aa = zeros(n, 1);
    bb = zeros(n, 1);
    
	errg = 0.0005;
	errxyz = 4 / 1000;
	errm = 1 / 1000;
    
    for i=1:n
        m = measurement;
        m.g = m.g + rand() * errg * 2 - errg;
        m.data(:,3:5) = m.data(:,3:5) + rand(length(m.data), 3) + rand() * errxyz * 2 - errxyz;
        m.mkg = m.mkg + rand() * errm * 2 - errm;
        
        re = calc_fd_pendulum(m, true);
        
        aa(i) = re.a;
        bb(i) = re.b;
        
        if (mod(i, 20) == 0)
           i
        end
    end
    
    stda = std(aa)
    stdb = std(bb)
    
    figure('Renderer', 'painters', 'Position', [10 10 390 380])
    histogram(aa,linspace(min(aa), max(aa), 100));    
    figure('Renderer', 'painters', 'Position', [10 10 390 380])
    histogram(bb,linspace(min(bb), max(bb), 100));
    
    ret = [aa; bb];
end