t_end = 130e-6;
dt = 10e-9;

ux_sensor_data_nx64_vc6464_gradient = squeeze(sensor_data_nx64_vc6464_gradient.ux(1,61:end,:))';
ux_sensor_data_nx64_vc6464_gradient_flip = squeeze(sensor_data_nx64_vc6464_gradient_flip.ux(1,61:end,:))';
ux_sensor_data_nx64_vc6464_gradient_no = squeeze(sensor_data_nx64_vc6464_gradient_no.ux(1,61:end,:))';

ux_time_sensor_data_nx64_vc6464_gradient = s_convert(ux_sensor_data_nx64_vc6464_gradient, 0, dt);
ux_time_sensor_data_nx64_vc6464_gradient_flip = s_convert(ux_sensor_data_nx64_vc6464_gradient_flip, 0, dt);
ux_time_sensor_data_nx64_vc6464_gradient_no = s_convert(ux_sensor_data_nx64_vc6464_gradient_no, 0, dt);


ux_sensor_data_nx64_vc6464_grad_lateral = squeeze(sensor_data_nx64_vc6464_grad_lateral.ux(1,61:end,:))';
ux_sensor_data_nx64_vc6464_grad_lateral_flip = squeeze(sensor_data_nx64_vc6464_grad_lateral_flip.ux(1,61:end,:))';

ux_time_sensor_data_nx64_vc6464_grad_lateral = s_convert(ux_sensor_data_nx64_vc6464_grad_lateral, 0, dt);
ux_time_sensor_data_nx64_vc6464_grad_lateral_flip = s_convert(ux_sensor_data_nx64_vc6464_grad_lateral_flip, 0, dt);
