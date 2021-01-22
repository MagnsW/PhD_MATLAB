%%
figure('position', [100 100 1200 1000])
h_filled = scatter(agg_nopit.velocities.ux_vgr,agg_nopit.velocities.ux_vph, [], agg_nopit.thickness.mean, 'filled');
hold on
h_nofilled = scatter(agg.velocities.ux_vgr,agg.velocities.ux_vph, [], agg.thickness.mean);
grid on
axis equal
legend([h_filled, h_nofilled], {'No pitting', 'Pitting'})
c = colorbar;
c.Label.String = 'Average thickness (no of nodes)';
xlabel('Group velocity [m/s]')
ylabel('Phase velocity [m/s]')
title('Group and phase velocity dependence on average Thickness')

%%
figure('position', [100 100 1200 1000])

h_filled = scatter(agg_nopit.velocities.ux_vgr,agg_nopit.velocities.ux_vph, [], agg_nopit.thickness.diff, 'filled');
hold on

h_nofilled = scatter(agg.velocities.ux_vgr,agg.velocities.ux_vph, [], agg.thickness.diff);
grid on
axis equal
legend([h_filled, h_nofilled], {'No pitting', 'Pitting'})
c = colorbar;
c.Label.String = 'Roughness (no of nodes)';
xlabel('Group velocity [m/s]')
ylabel('Phase velocity [m/s]')
title('Group and phase velocity dependence on Roughness')

%%
figure('position', [100 100 1200 1000])

h_filled = scatter(agg_nopit.velocities.ux_vgr,agg_nopit.velocities.ux_vph, [], agg_nopit.model.pVel_avg, 'filled');
hold on

h_nofilled = scatter(agg.velocities.ux_vgr,agg.velocities.ux_vph, [], agg.model.pVel_avg);
grid on
axis equal
legend([h_filled, h_nofilled], {'No pitting', 'Pitting'})
c = colorbar;
c.Label.String = 'Model P-wave velocity (m/s)';
xlabel('Group velocity [m/s]')
ylabel('Phase velocity [m/s]')
title('Group and phase velocity dependence on Model velocity')
%%
figure('position', [100 100 1200 1000])
h_filled = scatter(agg_mean_const.velocities.ux_vgr, agg_mean_const.velocities.ux_vph, [], agg_mean_const.thickness.diff, 'filled');
hold on
h_nofilled = scatter(agg.velocities.ux_vgr, agg.velocities.ux_vph, [], agg.thickness.diff);
grid on
axis equal
legend([h_filled, h_nofilled], {'Average thickness range: 60.9 - 61.1', 'Other'})
c = colorbar;
c.Label.String = 'Roughness (no of nodes)';
xlabel('Group velocity [m/s]')
ylabel('Phase velocity [m/s]')
title('Group and phase velocity dependence on Roughness')