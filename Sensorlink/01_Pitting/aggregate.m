function output = aggregate(inputs)
fn = fieldnames(inputs);
for i=1:numel(fn)
    output.model_stats.max(i) = inputs.(fn{i}).model_stats.thickness.max;
    output.model_stats.min(i) = inputs.(fn{i}).model_stats.thickness.min;
    output.model_stats.mean(i) = inputs.(fn{i}).model_stats.thickness.mean;
    output.model_stats.median(i) = inputs.(fn{i}).model_stats.thickness.median;
    output.model_stats.std(i) = inputs.(fn{i}).model_stats.thickness.std;
    output.model_stats.var(i) = inputs.(fn{i}).model_stats.thickness.var;
    
    output.results.thickness_uncomp(i) = inputs.(fn{i}).result.thickness_uncomp;
    output.results.thickness_comp(i) = inputs.(fn{i}).result.thickness_comp;
    
    output.sensor_data.trace(:,i) = squeeze(mean(inputs.(fn{i}).sensor_data.p));
    output.sensor_data.trace_autocorr(:,i) = xcorr(output.sensor_data.trace(:,i));
    output.sensor_data.trace_hilbert(:,i) = abs(hilbert(output.sensor_data.trace(:,i)));
end
end