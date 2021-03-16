function [output] = struct_corr(input_struct, dt, envelope_lags)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
sourcefreq = 5e4; %KHz
period = 1/(sourcefreq*2); %s setting minimum peak distance for the picking

fn = fieldnames(input_struct);

for k=1:numel(fn)
    %if k = 1 trace reference same as trace_comp
    %else trace reference is k-1
    if k == 1
        trace_ref = input_struct.(fn{k});
    else
        trace_ref = input_struct.(fn{k-1});
    end
%     trace_ref = input_struct.(fn{ref_trace_no});
    trace_comp = input_struct.(fn{k});
    [c, lags] = xcorr(trace_ref, trace_comp);
    [pks, locs_time] = findpeaks(c, 1/dt, 'MinPeakDistance', period);
    locs = int32(locs_time/dt);
    
    output.(fn{k}).c = c;
    output.(fn{k}).lags = lags;
    output.(fn{k}).lags_time = lags*dt;
    output.(fn{k}).lags_time_plus_env_lag = lags*dt + envelope_lags(k);
    output.(fn{k}).pks = pks;
    output.(fn{k}).locs = locs;
    output.(fn{k}).lags_locs = lags(locs);
    output.(fn{k}).lags_locs_time = lags(locs)*dt;
    output.(fn{k}).lags_locs_time_plus_env_lag = lags(locs)*dt + envelope_lags(k);
    
    
    
    
%     output.timediff(k) = finddelay(trace_ref, trace_comp);
%     [~,  output.(fn{k}).Ya] = alignsignals(trace_ref, trace_comp);
    
    
    
    %må finne flere peaks i xcorr og velge den som er mest sannsynlig
    %basert på forventet hastighet
end
    


end

