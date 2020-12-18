p = squeeze(sensor_data.p(1,:,:))';
p_time = s_convert(p, 0, kgrid.dt);
s_plot(p_time)
title('p')

ux = squeeze(sensor_data.ux(1,:,:))';
ux_time = s_convert(ux, 0, kgrid.dt);
s_plot(ux_time)
title('ux')

uy = squeeze(sensor_data.uy(1,:,:))';
uy_time = s_convert(uy, 0, kgrid.dt);
s_plot(uy_time)
title('uy')

p_096 = squeeze(sensor_data_096.sensor_data.p(1,:,:))';
p_100 = squeeze(sensor_data_100.sensor_data.p(1,:,:))';
p_104 = squeeze(sensor_data_104.sensor_data.p(1,:,:))';
dt = 2e-9;

p_time_096 = s_convert(p_096, 0, dt);
p_time_100 = s_convert(p_100, 0, dt);
p_time_104 = s_convert(p_104, 0, dt);

ux_096 = squeeze(sensor_data_096.sensor_data.ux(1,:,:))';
ux_100 = squeeze(sensor_data_100.sensor_data.ux(1,:,:))';
ux_104 = squeeze(sensor_data_104.sensor_data.ux(1,:,:))';
dt = 2e-9;

ux_time_096 = s_convert(ux_096, 0, dt);
ux_time_100 = s_convert(ux_100, 0, dt);
ux_time_104 = s_convert(ux_104, 0, dt);

s_plot(ux_time_096)
title('ux 0.96v')
caxis([-1e-7 1e-7])

s_plot(ux_time_100)
title('ux 1.00v')
caxis([-1e-7 1e-7])

s_plot(ux_time_104)
title('ux 1.04v')
caxis([-1e-7 1e-7])