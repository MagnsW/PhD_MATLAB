function [p_align_sensor_data, ux_align_sensor_data, H_p_time, H_ux_time, p_align_H, ux_align_H, p_timeshifts, ux_timeshifts, v_p, v_ux] = velestim_gr(sensor_data, dy, dt)
%VELESTIM Summary of this function goes here
%   Detailed explanation goes here
p_sensor_data = squeeze(sensor_data.p)';
ux_sensor_data = squeeze(sensor_data.ux)';

env_p = abs(hilbert(p_sensor_data));
env_ux = abs(hilbert(ux_sensor_data));

H_p_time = s_convert(env_p, 0, dt);
H_ux_time = s_convert(env_ux, 0, dt);

p_align_H = s_align(H_p_time, {'adapt', 'yes'}, {'maxshift', 1e-5});
ux_align_H = s_align(H_ux_time, {'adapt', 'yes'}, {'maxshift', 1e-5});

[ymax, ~] = size(sensor_data.ux);
y = 1:1:ymax;
y = y.*dy;

p_timeshifts = p_align_H.headers(2,:);
ux_timeshifts = ux_align_H.headers(2,:);

p_coefficients = polyfit(y, p_align_H.headers(2,:), 1);
ux_coefficients = polyfit(y, ux_align_H.headers(2,:), 1); 

v_p = -1/p_coefficients(1);
v_ux = -1/ux_coefficients(1);

p_time_sensor_data = s_convert(sensor_data.p', 0, dt);
ux_time_sensor_data = s_convert(sensor_data.ux', 0, dt);

p_align_sensor_data = s_shift(p_time_sensor_data, {'shifts', p_timeshifts});
ux_align_sensor_data = s_shift(ux_time_sensor_data, {'shifts', ux_timeshifts});

% s_plot(H_p_time)
% s_plot(p_align_sensor_data)
% s_plot(H_ux_time)
% s_plot(ux_align_sensor_data)
end