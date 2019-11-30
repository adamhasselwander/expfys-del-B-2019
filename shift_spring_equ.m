% Assuming motion in z-axis where data is  n | t | x | y | z
function ret=shift_spring_equ(measurement) 
   ret = measurement;
   
   A = measurement.data;
   z = A(:, 5);
   t = A(:, 2);
   k = measurement.k;
   m = measurement.mkg;
    
   z = z - mean(z);
   % Find all peaks
   [maxpks, maxlocs] = findpeaks(z, t, 'MinPeakDistance', 2 * pi / sqrt(k/m) * 0.8);
   [minpks, minlocs] = findpeaks(-z, t, 'MinPeakDistance', 2 * pi / sqrt(k/m) * 0.8);

   maxlocs = maxlocs(maxpks > 0);
   maxpks = maxpks(maxpks > 0);
   
   minlocs = minlocs(minpks > 0);
   minpks = minpks(minpks > 0);
    
   % remove last peak until the numbers of peaks are the same.
   while(length(maxlocs) ~= length(minlocs))
      if (length(maxlocs) > length(minlocs))
         maxlocs = maxlocs(1:end-1);
         maxpks = maxpks(1:end-1);
      else
         minlocs = minlocs(1:end-1);
         minpks = minpks(1:end-1);
      end
   end

   maxavgpks=sum(maxpks)/length(maxpks);
   minavgpks=sum(-minpks)/length(minpks);
   eqpks=(maxavgpks+minavgpks)/2;

   z = z - eqpks;
   ret.data(:,5) = z;

end

