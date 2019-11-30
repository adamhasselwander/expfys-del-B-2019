function leg=get_legend_weight(measurement)
    leg = strjoin({'m = ' strjoin({num2str(measurement.mkg, '%0.3f') 'kg'}, '')}, ' ');
end