dx = 0.2e-3;
dt = 10e-9;

load('sensor_data_nx62_vc6264.mat');
load('sensor_data_nx63_vc6364.mat');
load('sensor_data_nx64_vc6464.mat');
load('sensor_data_nx65_vc6564.mat');
load('sensor_data_nx66_vc6664.mat');
load('sensor_data_nx64_vc6264.mat');
load('sensor_data_nx64_vc6364.mat');
load('sensor_data_nx64_vc6564.mat');
load('sensor_data_nx64_vc6664.mat');
load('sensor_data_nx62_vc6464.mat');
load('sensor_data_nx63_vc6464.mat');
load('sensor_data_nx65_vc6464.mat');
load('sensor_data_nx66_vc6464.mat');

[p_align_nx62_vc6264, ux_align_nx62_vc6264, v_p_nx62_vc6264, v_ux_nx62_vc6264] = velestim(sensor_data_nx62_vc6264, dx, dt);
[p_align_nx63_vc6364, ux_align_nx63_vc6364, v_p_nx63_vc6364, v_ux_nx63_vc6364] = velestim(sensor_data_nx63_vc6364, dx, dt);
[p_align_nx64_vc6464, ux_align_nx64_vc6464, v_p_nx64_vc6464, v_ux_nx64_vc6464] = velestim(sensor_data_nx64_vc6464, dx, dt);
[p_align_nx65_vc6564, ux_align_nx65_vc6564, v_p_nx65_vc6564, v_ux_nx65_vc6564] = velestim(sensor_data_nx65_vc6564, dx, dt);
[p_align_nx66_vc6664, ux_align_nx66_vc6664, v_p_nx66_vc6664, v_ux_nx66_vc6664] = velestim(sensor_data_nx66_vc6664, dx, dt);
[p_align_nx64_vc6264, ux_align_nx64_vc6264, v_p_nx64_vc6264, v_ux_nx64_vc6264] = velestim(sensor_data_nx64_vc6264, dx, dt);
[p_align_nx64_vc6364, ux_align_nx64_vc6364, v_p_nx64_vc6364, v_ux_nx64_vc6364] = velestim(sensor_data_nx64_vc6364, dx, dt);
[p_align_nx64_vc6564, ux_align_nx64_vc6564, v_p_nx64_vc6564, v_ux_nx64_vc6564] = velestim(sensor_data_nx64_vc6564, dx, dt);
[p_align_nx64_vc6664, ux_align_nx64_vc6664, v_p_nx64_vc6664, v_ux_nx64_vc6664] = velestim(sensor_data_nx64_vc6664, dx, dt);
[p_align_nx62_vc6464, ux_align_nx62_vc6464, v_p_nx62_vc6464, v_ux_nx62_vc6464] = velestim(sensor_data_nx62_vc6464, dx, dt);
[p_align_nx63_vc6464, ux_align_nx63_vc6464, v_p_nx63_vc6464, v_ux_nx63_vc6464] = velestim(sensor_data_nx63_vc6464, dx, dt);
[p_align_nx65_vc6464, ux_align_nx65_vc6464, v_p_nx65_vc6464, v_ux_nx65_vc6464] = velestim(sensor_data_nx65_vc6464, dx, dt);
[p_align_nx66_vc6464, ux_align_nx66_vc6464, v_p_nx66_vc6464, v_ux_nx66_vc6464] = velestim(sensor_data_nx66_vc6464, dx, dt);

thicknesses = [62, 63, 64, 65, 66]*dx;
vel_ratios = [62, 63, 64, 65, 66] / 64;

v_p_const_vel = [v_p_nx62_vc6464, v_p_nx63_vc6464, v_p_nx64_vc6464, v_p_nx65_vc6464, v_p_nx66_vc6464; thicknesses];
v_ux_const_vel = [v_ux_nx62_vc6464, v_ux_nx63_vc6464, v_ux_nx64_vc6464, v_ux_nx65_vc6464, v_ux_nx66_vc6464; thicknesses];

v_p_const_thick = [v_p_nx64_vc6264, v_p_nx64_vc6364, v_p_nx64_vc6464, v_p_nx64_vc6564, v_p_nx64_vc6664; vel_ratios];
v_ux_const_thick = [v_ux_nx64_vc6264, v_ux_nx64_vc6364, v_ux_nx64_vc6464, v_ux_nx64_vc6564, v_ux_nx64_vc6664; vel_ratios];

v_p_both_vary = [v_p_nx62_vc6264, v_p_nx63_vc6364, v_p_nx64_vc6464, v_p_nx65_vc6564, v_p_nx66_vc6664; thicknesses];
v_ux_both_vary = [v_ux_nx62_vc6264, v_ux_nx63_vc6364, v_ux_nx64_vc6464, v_ux_nx65_vc6564, v_ux_nx66_vc6664; thicknesses];
