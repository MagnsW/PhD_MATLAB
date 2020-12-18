figure('position', [100 100 1000 700])
plot([0 1200]/2,[0 -0.24/5930]/2, '-.k')
hold on
plot([0 1200]/2,[0 -0.24/3260]/2, '-.k')
plot([0 1200]/2,[0 -0.24/3070]/2, '-.k')
plot([0 1200]/2,[0 -0.24/2050]/2, '-.k')
plot(ux_align_grad_lat.headers(2,:)', 'Color', '#0072BD')
plot(ux_align_grad_lat_gv.headers(2,:)', 'Color','#0072BD')
plot(ux_align_grad_no.headers(2,:)', 'Color', '#D95319')
plot(ux_align_grad_no_gv.headers(2,:)', 'Color', '#D95319')
plot(ux_align_grad_lat_flip.headers(2,:)', 'Color', '#EDB120')
plot(ux_align_grad_lat_flip_gv.headers(2,:)', 'Color', '#EDB120')
text(1200/2, -0.24/5930/2, '5930m/s (p-velocity)')
text(1200/2, -0.24/3260/2, '3260m/s (s-velocity)')
text(1200/2, -0.24/3070/2, '3070m/s')
text(1200/2, -0.24/2050/2, '2050m/s')
hold off
title('Gradient Change')
ylabel('Time correction[s]')
xlabel('Trace number; Trace separation: 0.2mm')
grid on
text(1200, -1.15e-4, {'Phase', 'velocities'}, 'Color', 'black', 'FontSize', 12);
text(1200, -0.75e-4, {'Group', 'velocities'}, 'Color', 'black', 'FontSize', 12);
text(1000, -0.04e-4, {'Lateral gradient'}, 'Color', 'black', 'FontSize', 12);
text(1000, -0.10e-4, 'Decreasing', 'Color', '#EDB120', 'FontSize', 12);
text(1000, -0.14e-4, 'No gradient', 'Color', '#D95319', 'FontSize', 12);
text(1000, -0.18e-4, 'Increasing', 'Color', '#0072BD', 'FontSize', 12);

figure('position', [100 100 1000 700])
plot([0 1200]/2,[0 -0.24/5930]/2, '-.k')
hold on
plot([0 1200]/2,[0 -0.24/3260]/2, '-.k')
plot([0 1200]/2,[0 -0.24/3070]/2, '-.k')
plot([0 1200]/2,[0 -0.24/2050]/2, '-.k')
plot(ux_align_nx64_vc6264.headers(2,:)', 'Color', '#0072BD')
plot(ux_align_nx64_vc6264_gv.headers(2,:)', 'Color', '#0072BD')
plot(ux_align_nx64_vc6464.headers(2,:)', 'Color', '#D95319')
plot(ux_align_nx64_vc6464_gv.headers(2,:)', 'Color', '#D95319')
plot(ux_align_nx64_vc6664.headers(2,:)', 'Color', '#EDB120')
plot(ux_align_nx64_vc6664_gv.headers(2,:)', 'Color', '#EDB120')
text(1200/2, -0.24/5930/2, '5930m/s (p-velocity)')
text(1200/2, -0.24/3260/2, '3260m/s (s-velocity)')
text(1200/2, -0.24/3070/2, '3070m/s')
text(1200/2, -0.24/2050/2, '2050m/s')
hold off
title('Model velocity change only')
ylabel('Time correction[s]')
xlabel('Trace number; Trace separation: 0.2mm')
grid on
text(1200, -1.15e-4, {'Phase', 'velocities'}, 'Color', 'black', 'FontSize', 12);
text(1200, -0.75e-4, {'Group', 'velocities'}, 'Color', 'black', 'FontSize', 12);
text(1000, -0.04e-4, {'Velocity'}, 'Color', 'black', 'FontSize', 12);
text(1000, -0.10e-4, '+3.125%', 'Color', '#EDB120', 'FontSize', 12);
text(1000, -0.14e-4, 'Reference', 'Color', '#D95319', 'FontSize', 12);
text(1000, -0.18e-4, '-3.125%', 'Color', '#0072BD', 'FontSize', 12);

figure('position', [100 100 1000 700])
plot([0 1200]/2,[0 -0.24/5930]/2, '-.k')
hold on
plot([0 1200]/2,[0 -0.24/3260]/2, '-.k')
plot([0 1200]/2,[0 -0.24/3070]/2, '-.k')
plot([0 1200]/2,[0 -0.24/2050]/2, '-.k')
plot(ux_align_nx62_vc6264.headers(2,:)', 'Color', '#0072BD')
plot(ux_align_nx62_vc6264_gv.headers(2,:)', 'Color', '#0072BD')
plot(ux_align_nx64_vc6464.headers(2,:)', 'Color', '#D95319')
plot(ux_align_nx64_vc6464_gv.headers(2,:)', 'Color', '#D95319')
plot(ux_align_nx66_vc6664.headers(2,:)', 'Color', '#EDB120')
plot(ux_align_nx66_vc6664_gv.headers(2,:)', 'Color', '#EDB120')
text(1200/2, -0.24/5930/2, '5930m/s (p-velocity)')
text(1200/2, -0.24/3260/2, ' 3260m/s (s-velocity)')
text(1200/2, -0.24/3070/2, '3070m/s')
text(1200/2, -0.24/2050/2, '2050m/s')
hold off
title('Model thickness change and velocity change', 'Velocity change that would obscure the thickness change in a pulse-echo measurement')
ylabel('Time correction[s]')
xlabel('Trace number; Trace separation: 0.2mm')
grid on
text(1200, -1.15e-4, {'Phase', 'velocities'}, 'Color', 'black', 'FontSize', 12);
text(1200, -0.75e-4, {'Group', 'velocities'}, 'Color', 'black', 'FontSize', 12);
text(1000, -0.04e-4, {'Thickness', 'and Velocity'}, 'Color', 'black', 'FontSize', 12);
text(1000, -0.10e-4, '+3.125%', 'Color', '#EDB120', 'FontSize', 12);
text(1000, -0.14e-4, 'Reference', 'Color', '#D95319', 'FontSize', 12);
text(1000, -0.18e-4, '-3.125%', 'Color', '#0072BD', 'FontSize', 12);

figure('position', [100 100 1000 700])
plot([0 1200]/2,[0 -0.24/5930]/2, '-.k')
hold on
plot([0 1200]/2,[0 -0.24/3260]/2, '-.k')
plot([0 1200]/2,[0 -0.24/3070]/2, '-.k')
plot([0 1200]/2,[0 -0.24/2050]/2, '-.k')
plot(ux_timeshifts_0_rr4, 'Color', '#0072BD')
plot(ux_timeshifts_0_rr5, 'Color', '#D95319')
text(1200/2, -0.24/5930/2, '5930m/s (p-velocity)')
text(1200/2, -0.24/3260/2, ' 3260m/s (s-velocity)')
text(1200/2, -0.24/3070/2, '3070m/s')
text(1200/2, -0.24/2050/2, '2050m/s')
hold off
title('Ux propagation velocity with and without PML size explicitly defined')
ylabel('Time correction[s]')
xlabel('Trace number; Trace separation: 0.2mm')
grid on
text(1200, -1.15e-4, {'Phase', 'velocities'}, 'Color', 'black', 'FontSize', 12);
text(1000, -0.10e-4, 'Rerun 4', 'Color', '#0072BD', 'FontSize', 12);
text(1000, -0.14e-4, 'Rerun 5', 'Color', '#D95319', 'FontSize', 12);