
function ret=parse_file_name(filename)
    cd(fileparts(which(mfilename)))
    cd 'data';

    name = char(filename);
    name = name(1:end-4);
    data = strsplit(name, '_');
    data = strrep(data, ',', '.');
    
    ret = {};
    ret.g = 9.817;
    
    if (length(data) >= 3)
        lab = data{1};
        d2 = data{2};
        if (strcmp(d2(end-1:end), "kg")) % support for the old naming format.
            mkg = data{2};
            rmm = data{3};

            ret.lab = lab;
            ret.mkg = str2double(mkg(1:end-2));
            ret.rmm = str2double(rmm(1:end-2)) / 2;
            ret.rho = 0;

        elseif (strcmp(d2(end-2:end), "rho"))
            rho = data{2};
            mkg = data{3};
            rmm = data{4};

            ret.rho = str2double(rho(1:end-3));
            ret.lab = lab;
            ret.mkg = str2double(mkg(1:end-2));
            ret.rmm = str2double(rmm(1:end-2)) / 2;

        end
        
        ret.filename = filename;
        ret.data = dlmread(filename);
        ret.data(:, 2) = ret.data(:, 2) - ret.data(1, 2);
        ret.data(:,1 ) = ret.data(:, 1) - ret.data(1, 1) + 1;
        ret.hz = round(1/(ret.data(2,2)-ret.data(1,2)));
        ret.lengthsec = length(ret.data(:,2)) / ret.hz;
    else
        error('Invalid filename');
    end
    
end