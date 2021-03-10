function [output] = crop_signal(trace, locs)
%crop_signal will split the signal at the locations given by the locs
%vector. Will return a struct with each  being one part of the cropped 
%signal

if length(locs) < 2
    output.s1 = trace;
else
    for idx = 1:length(locs)-1
%         disp([idx, int32(locs(idx)), int32(locs(idx+1))]);
        output.(['s' num2str(idx)]) = trace(int32(locs(idx)):int32(locs(idx+1)));
    end
    output.(['s' num2str(idx+1)]) = trace(int32(locs(idx+1)):end);
end


end

