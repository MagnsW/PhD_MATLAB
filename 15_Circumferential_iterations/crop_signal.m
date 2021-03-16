function [output] = crop_signal(trace, locs, dt)
%crop_signal will split the signal at the locations given by the locs
%vector. Will return a struct with each  being one part of the cropped 
%signal

if length(locs) < 2
    output.s1 = trace;
else
    for idx = 1:length(locs)-1
%         disp([idx, int32(locs(idx)), int32(locs(idx+1))]);
        output.signal.(['s' num2str(idx)]) = trace((locs(idx):locs(idx+1)));
        output.i_array.(['s' num2str(idx)]) = (locs(idx):locs(idx+1));
        output.t_array.(['s' num2str(idx)]) = single(locs(idx):locs(idx+1))*dt;
    end
    last_trace = trace(locs(idx+1):end);
    output.signal.(['s' num2str(idx+1)]) = last_trace;
    output.i_array.(['s' num2str(idx+1)]) = (locs(idx+1):locs(idx+1)+length(last_trace)-1);
    output.t_array.(['s' num2str(idx+1)]) = single(locs(idx+1):locs(idx+1)+length(last_trace)-1)*dt;
    
    
end


end

