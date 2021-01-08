figure('position', [100 100 1200 1000])
h_filled = scatter(agg_nopit.agg_ux_vgr,agg_nopit.agg_ux_vph, [], agg_nopit.agg_thickness_avg, 'filled');
hold on
h_nofilled = scatter(agg_all.agg_ux_vgr,agg_all.agg_ux_vph, [], agg_all.agg_thickness_avg);
grid on
axis equal
legend([h_filled, h_nofilled], {'No pitting', 'Pitting'})
c = colorbar;
c.Label.String = 'Average thickness (no of nodes)';
xlabel('Group velocity [m/s]')
ylabel('Phase velocity [m/s]')
title('Group and phase velocity dependence on average Thickness')

figure('position', [100 100 1200 1000])
h_filled = scatter(agg_nopit.agg_ux_vgr,agg_nopit.agg_ux_vph, [], agg_nopit.agg_thickness_diff, 'filled');
hold on
h_nofilled = scatter(agg_all.agg_ux_vgr,agg_all.agg_ux_vph, [], agg_all.agg_thickness_diff);
grid on
axis equal
legend([h_filled, h_nofilled], {'No pitting', 'Pitting'})
c = colorbar;
c.Label.String = 'Roughness (no of nodes)';
xlabel('Group velocity [m/s]')
ylabel('Phase velocity [m/s]')
title('Group and phase velocity dependence on Roughness')

figure('position', [100 100 1200 1000])
h_filled = scatter(agg_nopit.agg_ux_vgr,agg_nopit.agg_ux_vph, [], agg_nopit.agg_model_pVel_avg, 'filled');
hold on
h_nofilled = scatter(agg_all.agg_ux_vgr,agg_all.agg_ux_vph, [], agg_all.agg_model_pVel_avg);
grid on
axis equal
legend([h_filled, h_nofilled], {'No pitting', 'Pitting'})
c = colorbar;
c.Label.String = 'Model P-wave velocity (m/s)';
xlabel('Group velocity [m/s]')
ylabel('Phase velocity [m/s]')
title('Group and phase velocity dependence on Model velocity')

figure('position', [100 100 1200 1000])
h_filled = scatter(agg_fixed_avg.agg_ux_vgr,agg_fixed_avg.agg_ux_vph, [], agg_fixed_avg.agg_thickness_diff, 'filled');
hold on
h_nofilled = scatter(agg_all.agg_ux_vgr,agg_all.agg_ux_vph, [], agg_all.agg_thickness_diff);
grid on
axis equal
legend([h_filled, h_nofilled], {'Average thickness range: 60.9 - 61.1', 'Other'})
c = colorbar;
c.Label.String = 'Roughness (no of nodes)';
xlabel('Group velocity [m/s]')
ylabel('Phase velocity [m/s]')
title('Group and phase velocity dependence on Roughness')