function [p_align_sensor_data, ux_align_sensor_data, p_timeshifts, ux_timeshifts, v_p, v_ux] = velestim_ph(sensor_data, dy, dt)
%VELESTIM Summary of this function goes here
%   Detailed explanation goes here
% In this version, the time shifts are returned instead of the aligned data

display('Velestim started');
p_time_sensor_data = s_convert(sensor_data.p', 0, dt);
ux_time_sensor_data = s_convert(sensor_data.ux', 0, dt);

p_align_sensor_data = s_align(p_time_sensor_data, {'adapt', 'yes'}, {'maxshift', 1e-5});
ux_align_sensor_data = s_align(ux_time_sensor_data, {'adapt', 'yes'}, {'maxshift', 1e-5});

[ymax, ~] = size(sensor_data.ux);
y = 1:1:ymax;
y = y.*dy;

p_timeshifts = p_align_sensor_data.headers(2,:);
ux_timeshifts = ux_align_sensor_data.headers(2,:);
% figure
% plot(p_timeshifts)
% hold on
% plot(ux_timeshifts)
% hold off

p_coefficients = polyfit(y, p_align_sensor_data.headers(2,:), 1);
ux_coefficients = polyfit(y, ux_align_sensor_data.headers(2,:), 1);

v_p = -1/p_coefficients(1);
v_ux = -1/ux_coefficients(1);

% s_plot(p_time_sensor_data)
% s_plot(p_align_sensor_data)
% s_plot(ux_time_sensor_data)
% s_plot(ux_align_sensor_data)
end

