function [p_align_sensor_data, ux_align_sensor_data, p_timeshifts, ux_timeshifts, v_p, v_ux] = velestim(sensor_data, dx, dt)
%VELESTIM Summary of this function goes here
%   Detailed explanation goes here
% In this version, the time shifts are returned instead of the aligned data

display('Velestim started');
p_sensor_data = squeeze(sensor_data.p(1,61:end,:))';
ux_sensor_data = squeeze(sensor_data.ux(1,61:end,:))';

p_time_sensor_data = s_convert(p_sensor_data, 0, dt);
ux_time_sensor_data = s_convert(ux_sensor_data, 0, dt);

p_align_sensor_data = s_align(p_time_sensor_data, {'maxshift', 1e-5}, {'adapt', 'yes'});
ux_align_sensor_data = s_align(ux_time_sensor_data, {'maxshift', 1e-5}, {'adapt', 'yes'});

x = 1:1:1200;
x = x.*dx;

p_timeshifts = p_align_sensor_data.headers(2,:);
ux_timeshifts = ux_align_sensor_data.headers(2,:);


p_coefficients = polyfit(x, p_align_sensor_data.headers(2,:), 1);
ux_coefficients = polyfit(x, ux_align_sensor_data.headers(2,:), 1);

v_p = -1/p_coefficients(1);
v_ux = -1/ux_coefficients(1);

s_plot(p_time_sensor_data)
s_plot(ux_time_sensor_data)
s_plot(p_align_sensor_data)
s_plot(ux_align_sensor_data)
end

