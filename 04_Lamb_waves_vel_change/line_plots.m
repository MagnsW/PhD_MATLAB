figure
plot(vg_ux_const_vel(2,:), vg_ux_const_vel(1,:))
hold on
plot(vg_ux_both_vary(2,:), vg_ux_both_vary(1,:))
hold off
legend('constant velocity', 'variable velocity')
xlabel('Plate thickness [m]')
ylabel('Measured Group Velocity [m/s]')
set(gca, 'XGrid', 'on', 'YGrid', 'on')
title('ux Group Velocity vs Plate thickness')


figure
plot(v_ux_const_thick(2,:), v_ux_const_thick(1,:))
hold on
plot(vg_ux_const_thick(2,:), vg_ux_const_thick(1,:))
hold off
legend('Phase velocity', 'Group velocity')
set(gca, 'XGrid', 'on', 'YGrid', 'on')
xlabel('Velocity ratio');
ylabel('Measured Velocity [m/s]');
title('ux Velocity vs Velocity ratio')

figure
plot(v_p_const_vel(2,:), v_p_const_vel(1,:))
hold on
plot(vg_p_const_vel(2,:), vg_p_const_vel(1,:))
hold off
legend('Phase velocity', 'Group velocity')
set(gca, 'XGrid', 'on', 'YGrid', 'on')
xlabel('Plate thickness [m/s]');
ylabel('Measured Velocity [m/s]');
title('p Velocity vs Velocity ratio')

plot(p_align_nx62_vc6264_gv.headers(2,:))
hold on
plot(p_align_nx62_vc6464_gv.headers(2,:))
plot(p_align_nx63_vc6364_gv.headers(2,:))
plot(p_align_nx63_vc6464_gv.headers(2,:))
plot(p_align_nx64_vc6264_gv.headers(2,:))
plot(p_align_nx64_vc6364_gv.headers(2,:))
plot(p_align_nx64_vc6464_gv.headers(2,:))
plot(p_align_nx64_vc6564_gv.headers(2,:))
plot(p_align_nx64_vc6664_gv.headers(2,:))
plot(p_align_nx65_vc6464_gv.headers(2,:))
plot(p_align_nx65_vc6564_gv.headers(2,:))
plot(p_align_nx66_vc6464_gv.headers(2,:))
plot(p_align_nx66_vc6664_gv.headers(2,:))
hold off
set(gca, 'XGrid', 'on', 'YGrid', 'on')
xlabel('Trace number')
ylabel('Timeshift')
ylabel('Timeshift [s]')
title('p All time shifts - Group velocity corrected')

figure
plot(p_align_nx64_vc6464.headers(2,:), '--b')
hold on
plot(p_align_nx64_vc6464_gv.headers(2,:), '-b')
plot(ux_align_nx64_vc6464.headers(2,:), '--r')
plot(ux_align_nx64_vc6464_gv.headers(2,:), '-r')
hold off
legend('p-component Phase velocity', 'p-component Group velocity', 'ux-component Phase velocity', 'ux-component Group velocity')
set(gca, 'XGrid', 'on', 'YGrid', 'on')
xlabel('Trace number')
ylabel('Timeshift [s]')
title('Time shifts - Phase and Group velocities compared')

figure('position', [100 100 1000 700])
plot(kgrid.t_array, squeeze(sensor_data_nx64_vc6464.ux(1,61:61,:))')
hold on
plot(kgrid.t_array, abs(hilbert(squeeze(sensor_data_nx64_vc6464.ux(1,61:61,:))')), '-r')
plot(kgrid.t_array,-abs(hilbert(squeeze(sensor_data_nx64_vc6464.ux(1,61:61,:))')), '--r')
hold off
legend('Trace', 'Envelope')
xlabel('Time')
ylabel('Amplitude')
title('Wavelet Envelope (absolute value of Hilbert transform) trace#61')

figure('position', [100 100 1000 700])
plot(kgrid.t_array, squeeze(sensor_data_nx64_vc6464.ux(1,901:901,:))')
hold on
plot(kgrid.t_array, abs(hilbert(squeeze(sensor_data_nx64_vc6464.ux(1,901:901,:))')), '-r')
plot(kgrid.t_array,-abs(hilbert(squeeze(sensor_data_nx64_vc6464.ux(1,901:901,:))')), '--r')
hold off
legend('Trace', 'Envelope')
xlabel('Time')
ylabel('Amplitude')
title('Wavelet Envelope (absolute value of Hilbert transform) trace#901')

figure
plot(v_ux_const_vel(2,:), v_ux_const_vel(1,:))
hold on
plot(vg_ux_const_vel(2,:), vg_ux_const_vel(1,:))
hold off
legend('phase velocity', 'group velocity')
xlabel('Plate thickness [m]')
ylabel('Measured Velocity [m/s]')
set(gca, 'XGrid', 'on', 'YGrid', 'on')
title('ux Phase and Group Velocity vs Plate thickness')

