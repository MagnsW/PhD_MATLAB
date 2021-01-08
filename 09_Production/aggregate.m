fn = fieldnames(data_decim);
agg_thickness_avg = zeros(numel(fn),1);
agg_thickness_max = zeros(numel(fn),1);
agg_thickness_min = zeros(numel(fn),1);
agg_model_pVel_avg = zeros(numel(fn),1);
agg_ux_vph = zeros(numel(fn),1);
agg_ux_vgr = zeros(numel(fn),1);
for k=1:numel(fn)
    %disp(fn{k});
    vel_ratio = data_decim.(fn{k}).velinfo.ux_vph / data_decim.(fn{k}).velinfo.ux_vgr;
    thick_min = data_decim.(fn{k}).model.stats.thickness.min;
    thick_max = data_decim.(fn{k}).model.stats.thickness.max;
%     if vel_ratio < 0.7 && thick_min == thick_max
        agg_thickness_avg(k) = data_decim.(fn{k}).model.stats.thickness.avg;
        agg_thickness_max(k) = data_decim.(fn{k}).model.stats.thickness.max;
        agg_thickness_min(k) = data_decim.(fn{k}).model.stats.thickness.min;
        agg_model_pVel_avg(k) = data_decim.(fn{k}).model.stats.pVel.avg;
        agg_ux_vph(k) = data_decim.(fn{k}).velinfo.ux_vph;
        agg_ux_vgr(k) = data_decim.(fn{k}).velinfo.ux_vgr;
%     end
end
% agg_all.agg_model_pVel_avg = agg_model_pVel_avg(agg_model_pVel_avg~=0);
% agg_all.agg_thickness_avg = agg_thickness_avg(agg_thickness_avg~=0);
% agg_all.agg_thickness_max = agg_thickness_max(agg_thickness_max~=0);
% 
% agg_all.agg_thickness_min = agg_thickness_min(agg_thickness_min~=0);
% agg_all.agg_ux_vgr = agg_ux_vgr(agg_ux_vgr~=0);
% agg_all.agg_ux_vph = agg_ux_vph(agg_ux_vph~=0);
% 
% agg_all.agg_thickness_diff = agg_all.agg_thickness_max - agg_all.agg_thickness_min;
% agg_all.agg_ux_vph_vgr_ratio = agg_all.agg_ux_vph ./ agg_all.agg_ux_vgr;

% agg_nopit.agg_model_pVel_avg = agg_model_pVel_avg(agg_model_pVel_avg~=0);
% agg_nopit.agg_thickness_avg = agg_thickness_avg(agg_thickness_avg~=0);
% agg_nopit.agg_thickness_max = agg_thickness_max(agg_thickness_max~=0);
% 
% agg_nopit.agg_thickness_min = agg_thickness_min(agg_thickness_min~=0);
% agg_nopit.agg_ux_vgr = agg_ux_vgr(agg_ux_vgr~=0);
% agg_nopit.agg_ux_vph = agg_ux_vph(agg_ux_vph~=0);
% 
% agg_nopit.agg_thickness_diff = agg_nopit.agg_thickness_max - agg_nopit.agg_thickness_min;
% agg_nopit.agg_ux_vph_vgr_ratio = agg_nopit.agg_ux_vph ./ agg_nopit.agg_ux_vgr;

agg_ux_vph_vgr_ratio = agg_ux_vph ./ agg_ux_vgr;