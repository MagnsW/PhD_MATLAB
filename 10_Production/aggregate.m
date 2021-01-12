function [agg] = aggregate(data_decim)
fn = fieldnames(data_decim);
agg.datsets = fn;
agg.thickness_mean = zeros(numel(fn),1);
agg.thickness_max = zeros(numel(fn),1);
agg.thickness_min = zeros(numel(fn),1);
agg.model_pVel_avg = zeros(numel(fn),1);
agg.ux_vph = zeros(numel(fn),1);
agg.ux_vgr = zeros(numel(fn),1);
for k=1:numel(fn)
    %disp(fn{k});
    %agg.vel_ratio = data_decim.(fn{k}).velinfo.ux_vph / data_decim.(fn{k}).velinfo.ux_vgr;
    agg.thickness_mean(k) = data_decim.(fn{k}).model.stats.thickness.mean;
    agg.thickness_max(k) = data_decim.(fn{k}).model.stats.thickness.max;
    agg.thickness_min(k) = data_decim.(fn{k}).model.stats.thickness.min;
    agg.model_pVel_avg(k) = data_decim.(fn{k}).model.stats.pVel.avg;
    agg.ux_vph(k) = data_decim.(fn{k}).velinfo.ux_vph * 50;
    agg.ux_vgr(k) = data_decim.(fn{k}).velinfo.ux_vgr * 50;
end


end
