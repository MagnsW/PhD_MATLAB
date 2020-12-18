p_sensor_data_nx62_vc6264 = squeeze(sensor_data_nx62_vc6264.p(1,61:end,:))';
p_sensor_data_nx63_vc6364 = squeeze(sensor_data_nx63_vc6364.p(1,61:end,:))';
p_sensor_data_nx64_vc6464 = squeeze(sensor_data_nx64_vc6464.p(1,61:end,:))';
p_sensor_data_nx65_vc6564 = squeeze(sensor_data_nx65_vc6564.p(1,61:end,:))';
p_sensor_data_nx66_vc6644 = squeeze(sensor_data_nx66_vc6664.p(1,61:end,:))';

p_time_sensor_data_nx62_vc6264 = s_convert(p_sensor_data_nx62_vc6264, 0, dt);
p_time_sensor_data_nx63_vc6364 = s_convert(p_sensor_data_nx63_vc6364, 0, dt);
p_time_sensor_data_nx64_vc6464 = s_convert(p_sensor_data_nx64_vc6464, 0, dt);
p_time_sensor_data_nx65_vc6564 = s_convert(p_sensor_data_nx65_vc6564, 0, dt);
p_time_sensor_data_nx66_vc6644 = s_convert(p_sensor_data_nx66_vc6644, 0, dt);

p_align_sensor_data_nx62_vc6264 = s_align(p_time_sensor_data_nx62_vc6264);
p_align_sensor_data_nx63_vc6364 = s_align(p_time_sensor_data_nx63_vc6364);
p_align_sensor_data_nx64_vc6464 = s_align(p_time_sensor_data_nx64_vc6464);
p_align_sensor_data_nx65_vc6564 = s_align(p_time_sensor_data_nx65_vc6564);
p_align_sensor_data_nx66_vc6664 = s_align(p_time_sensor_data_nx66_vc6664);




