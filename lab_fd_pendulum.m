close all

figure('Renderer', 'painters', 'Position', [10 10 390 380])
hold on

airset4 = ["pendulum_0,066kg_25,5mm.tsv" 
           "pendulum_0,140kg_31,7mm_2.tsv" 
           "pendulum_0,235kg_38,1mm_2.tsv" ];

i = 0;
aa = [];
bb = [];

for file=airset4'
    i = i + 1;
    measurement = parse_file_name(file);
    
    A = measurement.data;
    measurement.data = A;

    measurement = calc_fd_pendulum(measurement);
    A = measurement.data;

    a = measurement.a;
    b = measurement.b;
    alpha = measurement.alpha;
    beta = measurement.beta;
    fun = measurement.fun;
    tlocs = measurement.tlocs;
    pks = measurement.pks;
    resnorm = measurement.resnorm;
    r = measurement.radiusmm;
    
    % cut to x deg angle. 
    % 5 deg.
    theta0 = 3.5;
    tlocs = tlocs(pks < theta0);
    pks = pks(pks < theta0);

    aa = [aa a];
    bb = [bb b];
    
    theta = linspace(0, 2 * pi, 1000);
    plot(r .* cos(theta), r .* sin(theta), '--', 'DisplayName',get_legend_weight(measurement), 'color', get_color(measurement));
    plot(A(1:10:end,3), A(1:10:end,5), 'HandleVisibility','off', 'color', get_color(measurement));
    
end

axis equal

%xlim([-500 500])
ylim([-1500 -1000])

xlabel('z [mm]');
ylabel('x [mm]');
legend

figure('Renderer', 'painters', 'Position', [10 10 390 380])
hold on

i = 0;
aa = [];
bb = [];
rr = [];

airset4(1)
for file=airset4'
    i = i + 1;
    measurement = parse_file_name(file);

    A = measurement.data;
    measurement.data = A;

    measurement = calc_fd_pendulum(measurement);
    A = measurement.data;

    a = measurement.a;
    b = measurement.b;
    alpha = measurement.alpha;
    beta = measurement.beta;
    fun = measurement.fun;
    tlocs = measurement.tlocs;
    pks = measurement.pks;
    resnorm = measurement.resnorm;
    r = measurement.radiusmm;
    lpks = length(pks);
    
    % cut to x deg angle. 
    % 5 deg.
    theta0 = 3.5;
    tlocs = tlocs(pks < theta0);
    pks = pks(pks < theta0);
    
    plot(tlocs(1:10:length(pks))-tlocs(1), pks(1:10:length(pks)),'x','DisplayName',get_legend_weight(measurement), 'color', get_color(measurement))
    plot(tlocs-tlocs(1), fun([alpha beta], tlocs),'HandleVisibility','off', 'color', get_color(measurement))
    
    aa = [aa a];
    bb = [bb b];
    rr = [rr resnorm/lpks];
    
end

aa
bb
rr

ylim([1 4])
xlim([0 600])
xlabel('Tid [s]');
ylabel('Största vinkeln för var 10:de oscillation [deg]');
legend

figure('Renderer', 'painters', 'Position', [10 10 390 380])
hold on

airset4(1)

for file=airset4'
    i = i + 1;
    measurement = parse_file_name(file);
	measurement = calc_fd_pendulum(measurement);
        
    fd = @(a, b, x) a .* x + b .* x.^2;
    x = 0:0.01:2.5;

    plot(x, fd(measurement.a, measurement.b, x), 'DisplayName',get_legend_weight(measurement), 'color', get_color(measurement))
    plot(x, fd(measurement.a, 0, x), '--','HandleVisibility','off', 'color', get_color(measurement))
    
end

ylabel('F_d(v) [N]');
xlabel('v [m/s]');
legend('Location', 'northwest')

for file=airset4'
	measurement = parse_file_name(file);
    calc_fd_pendulum_monte_carlo(measurement);
end
