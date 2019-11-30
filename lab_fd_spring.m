close all
set4 = ["spring_0,110kg_30mm_3.tsv" "spring_0,140kg_31,7mm_3.tsv" "spring_0,235kg_38,1mm_2.tsv"];

figure('Renderer', 'painters', 'Position', [10 10 390 380])
hold on

i = 0;
aa = [];
bb = [];
rr = [];

spconstA=dlmread('Före.tsv');
spconstB=dlmread('Efter.tsv');

for file=set4'
    i = i + 1;
    measurement = parse_file_name(file);
    
    measurement.k = calc_spring_const(spconstA, spconstB, measurement);
    measurement = shift_spring_equ(measurement);

    A = measurement.data;
    
    [a,b,alpha,beta,fun,tlocs,pks,resnorm]=calc_fd_spring(measurement);
    lpks = length(pks);
    
    A0 = 30;
    tlocs = tlocs(pks < A0);
    pks = pks(pks < A0);
    
    plot(tlocs(1:10:length(pks))-tlocs(1), pks(1:10:length(pks)),'x','DisplayName',get_legend_weight(measurement), 'color', get_color(measurement))
    plot((tlocs(1):1000)-tlocs(1), fun([alpha beta], tlocs(1):1000),'HandleVisibility','off', 'color', get_color(measurement))

    aa = [aa a];
    bb = [bb b];
	rr = [rr resnorm / lpks];

end

aa
bb
rr

xlim([0 500])
xlabel('Tid [s]');
ylabel('Största amplituden för var 10:de oscillation [mm]');
legend

for file=set4'
    measurement = parse_file_name(file);
    
    measurement.k = calc_spring_const(spconstA, spconstB, measurement);
    measurement = shift_spring_equ(measurement);
    
    A = measurement.data;
    
    calc_fd_spring_monte_carlo(measurement);
end

