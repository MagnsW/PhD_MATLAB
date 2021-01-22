function outputAgg = filter_agg(agg, subagg, attribute, minval, maxval)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
logic_arr = (subagg.(attribute) >= minval) & (subagg.(attribute) <= maxval);
% I = find(logic_arr);
outputAgg.datasets = agg.datasets(logic_arr);
% outputAgg.thickness.mean = agg.thickness.mean(logic_arr);
% outputAgg.thickness.max = agg.thickness.max(logic_arr);
% outputAgg.thickness.min = agg.thickness.min(logic_arr);
% outputAgg.thickness.diff = agg.thickness.diff(logic_arr);
% outputAgg.model.pVel_avg = agg.model.pVel(logic_arr);
% outputAgg.velocities.ux_vph = agg.velocities.ux_vph(logic_arr);
% outputAgg.velocities.ux_vgr = agg.velocities.ux_vgr(logic_arr);
fn = fieldnames(agg.thickness);
for k=1:numel(fn)
    outputAgg.thickness.(fn{k}) = agg.thickness.(fn{k})(logic_arr);
end
outputAgg.model.pVel_avg = agg.model.pVel_avg(logic_arr);
outputAgg.velocities.ux_vph = agg.velocities.ux_vph(logic_arr);
outputAgg.velocities.ux_vgr = agg.velocities.ux_vgr(logic_arr);

hf = fieldnames(agg.amplitudes.lin);
for i=1:numel(hf)
    outputAgg.amplitudes.lin.(hf{i}) = agg.amplitudes.lin.(hf{i})(logic_arr,:);
    outputAgg.amplitudes.db.(hf{i}) = agg.amplitudes.db.(hf{i})(logic_arr,:);
    
    outputAgg.amplitudes_H.lin.(hf{i}) = agg.amplitudes_H.lin.(hf{i})(logic_arr,:);
    outputAgg.amplitudes_H.db.(hf{i}) = agg.amplitudes_H.db.(hf{i})(logic_arr,:);
end

outputAgg.analysis.kurtosis = agg.analysis.kurtosis(logic_arr,:);
outputAgg.analysis_H.kurtosis = agg.analysis_H.kurtosis(logic_arr,:);


end

