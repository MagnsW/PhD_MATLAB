function [agg] = aggregate(data_decim)
fn = fieldnames(data_decim);
agg.datasets = fn;
agg.thickness.mean = zeros(numel(fn),1);
agg.thickness.max = zeros(numel(fn),1);
agg.thickness.min = zeros(numel(fn),1);
agg.thickness.diff = zeros(numel(fn),1);
agg.model.pVel_avg = zeros(numel(fn),1);
agg.velocities.ux_vph = zeros(numel(fn),1);
agg.velocities.ux_vgr = zeros(numel(fn),1);
%agg.amplitudes = zeros(numel(fn), 1);
headerfields = data_decim.(fn{1}).s_sensor_data_time.ux.header_info(:,1);
headerfields_H = data_decim.(fn{1}).s_hilbert.ux.header_info(:,1);
for k=1:numel(fn)
    %disp(fn{k});
    %agg.vel_ratio = data_decim.(fn{k}).velinfo.ux_vph / data_decim.(fn{k}).velinfo.ux_vgr;
    agg.thickness.mean(k) = data_decim.(fn{k}).model.stats.thickness.mean;
    agg.thickness.max(k) = data_decim.(fn{k}).model.stats.thickness.max;
    agg.thickness.min(k) = data_decim.(fn{k}).model.stats.thickness.min;
    agg.thickness.diff(k) = agg.thickness.max(k) - agg.thickness.min(k);
    agg.model.pVel_avg(k) = data_decim.(fn{k}).model.stats.pVel.avg;
    agg.velocities.ux_vph(k) = data_decim.(fn{k}).velinfo.ux_vph;
    agg.velocities.ux_vgr(k) = data_decim.(fn{k}).velinfo.ux_vgr;
    for i=1:numel(headerfields)
        vals = data_decim.(fn{k}).s_sensor_data_time.ux.headers(i, :);
        agg.amplitudes.lin.(headerfields{i})(k,:) = vals;
        agg.amplitudes.db.(headerfields{i})(k,:) = 20*log10(abs(vals)/max(abs(vals)));
    end
    
    
    
    for i=1:numel(headerfields_H)
        vals = data_decim.(fn{k}).s_hilbert.ux.headers(i, :);
        agg.amplitudes_H.lin.(headerfields_H{i})(k,:) = vals;
        agg.amplitudes_H.db.(headerfields_H{i})(k,:) = 20*log10(abs(vals)/max(abs(vals)));
    end
    
    agg.analysis.kurtosis(k,:) = data_decim.(fn{k}).s_sensor_data_time.ux.kurtosis;
    agg.analysis_H.kurtosis(k,:) = data_decim.(fn{k}).s_hilbert.ux.kurtosis;

end


end
