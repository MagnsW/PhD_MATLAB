function [output] = struct_corr(input_struct, ref_trace_no)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
fn = fieldnames(input_struct);

for k=1:numel(fn)
    trace_ref = input_struct.(fn{ref_trace_no});
    trace_comp = input_struct.(fn{k});
    
    output.timediff(k) = finddelay(trace_ref, trace_comp);
    [~,  output.(fn{k}).Ya] = alignsignals(trace_ref, trace_comp);
    %må finne flere peaks i xcorr og velge den som er mest sannsynlig
    %basert på forventet hastighet
end
    


end

