function [output] = struct_corr(input_struct, ref_trace_no, dt)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
sourcefreq = 5e4; %KHz
period = 1/sourcefreq; %s

fn = fieldnames(input_struct);

for k=1:numel(fn)
    trace_ref = input_struct.(fn{ref_trace_no});
    trace_comp = input_struct.(fn{k});
    [c, lags] = xcorr(trace_ref, trace_comp);
    [pks, locs_time] = findpeaks(c, 1/dt, 'MinPeakDistance', period);
    locs = locs_time/dt;
    
    output.(fn{k}).c = c;
    output.(fn{k}).lags = lags;
    output.(fn{k}).lags_time = lags*dt;
    output.(fn{k}).pks = pks;
    output.(fn{k}).locs = locs;
    output.(fn{k}).lags_locs = lags(int32(locs));
    
    
    
    
%     output.timediff(k) = finddelay(trace_ref, trace_comp);
%     [~,  output.(fn{k}).Ya] = alignsignals(trace_ref, trace_comp);
    
    
    
    %må finne flere peaks i xcorr og velge den som er mest sannsynlig
    %basert på forventet hastighet
end
    


end

