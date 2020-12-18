ux_sensor_data_pittingdepth_0 = squeeze(sensor_data_pittingdepth_0.ux(1,61:end,:))';
ux_time_sensor_data_pittingdepth_0 = s_convert(ux_sensor_data_pittingdepth_0, 0, dt);
s_plot(ux_time_sensor_data_pittingdepth_0)
caxis([-1e-8 1e-8])
title('No pitting')

ux_sensor_data_bugtest_0 = squeeze(sensor_data_bugtest_0.ux(1,61:end,:))';
ux_time_sensor_data_bugtest_0 = s_convert(ux_sensor_data_bugtest_0, 0, dt);
s_plot(ux_time_sensor_data_bugtest_0)
caxis([-1e-8 1e-8])
title('Pitting')

ux_sensor_data = squeeze(sensor_data.ux(1,61:end,:))';
ux_time_sensor_data = s_convert(ux_sensor_data, 0, dt);
s_plot(ux_time_sensor_data)
caxis([-2.5e-8 2.5e-8])
title('Pitting')

ux_sensor_data_reference = squeeze(sensor_data_reference.ux(1,61:end,:))';
ux_time_sensor_data_reference = s_convert(ux_sensor_data_reference, 0, dt);
s_plot(ux_time_sensor_data_reference)
caxis([-2.5e-8 2.5e-8])
title('Reference')

ux_sensor_data = squeeze(sensor_data_bugtest_0_rerun3.ux(1,61:end,:))';
ux_time_sensor_data = s_convert(ux_sensor_data, 0, dt);
s_plot(ux_time_sensor_data)
caxis([-2.5e-8 2.5e-8])
title('Pitting')

ux_sensor_data_reference = squeeze(sensor_data_bugtest_ref_rerun3.ux(1,61:end,:))';
ux_time_sensor_data_reference = s_convert(ux_sensor_data_reference, 0, dt);
s_plot(ux_time_sensor_data_reference)
caxis([-2.5e-8 2.5e-8])
title('Reference')

figure('position', [100 100 1000 700])
subplot(2,1,1)
imagesc(squeeze(sensor_data_bugtest_0.ux(1,61:end,:))')
colorbar
title('Bugtest 0 - Rerun 3' )
subplot(2,1,2)
imagesc(squeeze(sensor_data_bugtest_1.ux(1,61:end,:))')
colorbar
title('Bugtest 1 - Rerun 3' )






