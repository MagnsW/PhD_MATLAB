function [p_align_groupvel, ux_align_groupvel, vg_p,vg_ux] = velestim_group(sensor_data, dx, dt)
%VELESTIM Summary of this function goes here
%   Detailed explanation goes here
p_sensor_data = squeeze(sensor_data.p(1,61:end,:))';
ux_sensor_data = squeeze(sensor_data.ux(1,61:end,:))';

env_p = abs(hilbert(p_sensor_data));
env_ux = abs(hilbert(ux_sensor_data));

H_p_time = s_convert(env_p, 0, dt);
H_ux_time = s_convert(env_ux, 0, dt);

p_align_groupvel = s_align(H_p_time, {'maxshift', 1e-5}, {'adapt', 'yes'});
ux_align_groupvel = s_align(H_ux_time, {'maxshift', 1e-5}, {'adapt', 'yes'});

x = 1:1:1200;
x = x.*dx;

p_coefficients = polyfit(x, p_align_groupvel.headers(2,:), 1);
ux_coefficients = polyfit(x, ux_align_groupvel.headers(2,:), 1);

vg_p = -1/p_coefficients(1);
vg_ux = -1/ux_coefficients(1);
end