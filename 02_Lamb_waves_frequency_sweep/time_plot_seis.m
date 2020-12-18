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