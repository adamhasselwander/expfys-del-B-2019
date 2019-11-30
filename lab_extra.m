close all;
figure('Renderer', 'painters', 'Position', [10 10 390 380])
hold on;

% EXTRA VATTEN RÖD GRÖN BLÅ 
waterset4 = ["pendulum_0,997rho_0,066kg_25,5mm.tsv" 
    "pendulum_0,997rho_0,140kg_31,7mm.tsv"
    "pendulum_0,997rho_0,235kg_38,1mm_2.tsv" ];
     
% EXTRA GLYCEROL: RÖD GRÖN BLÅ
glycelset4 = [ "pendulum_1,1429rho_0,066kg_25,5mm_2.tsv" 
    "pendulum_1,1429rho_0,140kg_31,7mm_2.tsv" 
    "pendulum_1,1429rho_0,235kg_38,1mm_2.tsv" ];

K = [];
K0 = [];
L = [];
i = 0;

for file=waterset4'
    i = i + 1;
    measurement = parse_file_name(file);
    A = measurement.data;

    measurement = fit_pendulum_circle(measurement);
    A = measurement.data;

    A = A(200:1700, :);
    
    x = A(:,3);
    y = A(:,4);
    z = A(:,5);
    t = A(:,2);
    r = measurement.radiusmm;
    %l = r / 1000;
    l = 1.392 + measurement.rmm / 1000;
    hz = measurement.hz;

    rhoP = 7807;
    rhoV = measurement.rho * 1000;

    oma = sqrt(9.817/l);

    theta = atan(x./z);
    thetadeg = theta * (360 / (2 * pi));

    A(:, 5) = thetadeg;

    plot(t(1:10:length(t)),thetadeg(1:10:length(t)),'x','DisplayName',get_legend_weight(measurement), 'color', get_color(measurement))
    
    [resr, fun2] = fmin_fit_damped_sine(A, 1.8, 1/ (2 * pi / (2.67)));

    plot(A(:,2), resr(fun2, A(:,2)),'HandleVisibility','off', 'color', get_color(measurement))

    omF = 1/fun2(2);
    lambda = fun2(4);

    k = calc_k(oma,omF,lambda,rhoP,rhoV);
    k0 = calc_k(oma,omF,0,rhoP,rhoV);
    % k omega air

    K = [K, k];
    K0 = [K0, k0];
    L = [L l];

end

K
K0
L

xlabel('Tid [s]');
ylabel('Vinkel [deg]');
legend

figure('Renderer', 'painters', 'Position', [10 10 390 380])

hold on

K = [];
K0 = [];
L = [];
i = 0;

for file=glycelset4'
    i = i + 1;
    measurement = parse_file_name(file);
    A = measurement.data;

    measurement = fit_pendulum_circle(measurement);
    A = measurement.data;

    A = A(200:2:1700, :);
    
    x = A(:,3);
    y = A(:,4);
    z = A(:,5);
    t = A(:,2);
    r = measurement.radiusmm;
    l = r / 1000;
    l = 1.392 + measurement.rmm / 1000;
    hz = measurement.hz;

    rhoP = 7807;
    rhoV = measurement.rho * 1000;

    oma = sqrt(9.817/l);

    theta = atan(x./z);
    thetadeg = theta * (360 / (2 * pi));

    A(:, 5) = thetadeg;

    plot(t(1:10:length(t)),thetadeg(1:10:length(t)),'x','DisplayName',get_legend_weight(measurement), 'color', get_color(measurement))

    [resr, fun2] = fmin_fit_damped_sine(A, 1.8, 1/ (2 * pi / (2.67)));

    plot(A(:,2), resr(fun2, A(:,2)),'HandleVisibility','off', 'color', get_color(measurement))
    
    omF = 1/fun2(2);
    lambda = fun2(4);

    k = calc_k(oma,omF,lambda,rhoP,rhoV);
    k0 = calc_k(oma,omF,0,rhoP,rhoV);
    % k omega air

    K = [K, k];
    K0 = [K0, k0];
    L = [L l];

end

K
K0
L
rr

xlabel('Tid [s]');
ylabel('Vinkel [deg]');
legend
