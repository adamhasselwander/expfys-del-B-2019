% function generate_monte_carlo_graphs() 
close all


airset4 = ["pendulum_0,066kg_25,5mm.tsv" 
           "pendulum_0,140kg_31,7mm_2.tsv" 
           "pendulum_0,235kg_38,1mm_2.tsv" ];
       
for file=airset4'
	measurement = parse_file_name(file);
    p = strsplit(num2str(measurement.mkg), '.');
    
    
    aaf = strjoin({'aa', p{2}}, '');
    bbf = strjoin({'bb', p{2}}, '');
    aaf = pad(aaf, 5, '0');
    bbf = pad(bbf, 5, '0');
    
    load(strjoin({bbf, '.txt'}, ''),'-ascii')
    load(strjoin({aaf, '.txt'}, ''),'-ascii')
    aa = eval(aaf);
    bb = eval(bbf);
    
    
    figure('Renderer', 'painters', 'Position', [10 10 390 380])
    histogram(aa,linspace(min(aa), max(aa), 100), 'FaceColor', get_color(measurement));    
    stda = std(aa)
    
    figure('Renderer', 'painters', 'Position', [10 10 390 380])
    histogram(bb,linspace(min(bb), max(bb), 100), 'FaceColor', get_color(measurement));
    stdb = std(bb)
end


close all


set4 = ["spring_0,110kg_30mm_3.tsv" "spring_0,140kg_31,7mm_3.tsv" "spring_0,235kg_38,1mm_2.tsv"];
  
for file=set4
	measurement = parse_file_name(file);
    p = strsplit(num2str(measurement.mkg), '.');
    
    
    aaf = strjoin({'saa', p{2}}, '');
    bbf = strjoin({'sbb', p{2}}, '');
    aaf = pad(aaf, 6, '0');
    bbf = pad(bbf, 6, '0');
    
    load(strjoin({bbf, '.txt'}, ''),'-ascii')
    load(strjoin({aaf, '.txt'}, ''),'-ascii')
    aa = eval(aaf);
    bb = eval(bbf);
    
    
    figure('Renderer', 'painters', 'Position', [10 10 390 380])
    histogram(aa,linspace(min(aa), max(aa), 100), 'FaceColor', get_color(measurement), 'FaceAlpha', .3);    
    stda = std(aa)
    
    figure('Renderer', 'painters', 'Position', [10 10 390 380])
    histogram(bb,linspace(min(bb), max(bb), 100), 'FaceColor', get_color(measurement));
    stdb = std(bb)
end


    
return

p = strsplit(num2str(measurement.mkg), '.');

aaf = strjoin({'saa', p{2}}, '');
bbf = strjoin({'sbb', p{2}}, '');
aaf = pad(aaf, 6, '0');
bbf = pad(bbf, 6, '0');

save(strjoin({bbf, '.txt'}, ''), 'aa','-ascii')
save(strjoin({aaf, '.txt'}, ''), 'bb','-ascii')

%end