function [p_align_sensor_data, ux_align_sensor_data, p_timeshifts, ux_timeshifts, v_p, v_ux] = velestim_gr(sensor_data, dy, dt)
%VELESTIM Summary of this function goes here
%   Detailed explanation goes here
p_sensor_data = squeeze(sensor_data.p)';
ux_sensor_data = squeeze(sensor_data.ux)';

env_p = abs(hilbert(p_sensor_data));
env_ux = abs(hilbert(ux_sensor_data));

H_p_time = s_convert(env_p, 0, dt);
H_ux_time = s_convert(env_ux, 0, dt);

p_align_sensor_data = s_align(H_p_time, {'adapt', 'yes'}, {'maxshift', 1e-5});
ux_align_sensor_data = s_align(H_ux_time, {'adapt', 'yes'}, {'maxshift', 1e-5});

[ymax, ~] = size(sensor_data.ux);
y = 1:1:ymax;
y = y.*dy;

p_timeshifts = p_align_sensor_data.headers(2,:);
ux_timeshifts = ux_align_sensor_data.headers(2,:);
figure
plot(p_timeshifts)
hold on
plot(ux_timeshifts)

p_coefficients = polyfit(y, p_align_sensor_data.headers(2,:), 1);
ux_coefficients = polyfit(y, ux_align_sensor_data.headers(2,:), 1);

plot(p_coefficients(1).*y + p_coefficients(2))
plot(ux_coefficients(1).*y + ux_coefficients(2))
title('group vels')

v_p = -1/p_coefficients(1);
v_ux = -1/ux_coefficients(1);

% s_plot(H_p_time)
% s_plot(p_align_sensor_data)
% s_plot(H_ux_time)
% s_plot(ux_align_sensor_data)
end