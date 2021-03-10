function [output] = trace_analyse(input_trace, dt)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
time_tresh = 50e-6; %At least 50 microseconds per revolution
num_cycles = 3; %Number of circumferential cycles considered

%envelope detection and circumferential propagation time for group
output.envelope = abs(hilbert(input_trace));
[c, lags] = xcorr(output.envelope);
output.env_autocorr.c = c(floor(length(c)/2):end); %only look at last half
output.env_autocorr.lags = lags(floor(length(lags)/2):end); %only look at last halfc
[output.env_autocorr.pks, output.env_autocorr.pks_locs_time] = findpeaks(output.env_autocorr.c, 1/dt, 'MinPeakDistance', time_tresh);

time_diff_autocorr_temp = diff(output.env_autocorr.pks_locs_time);
output.env_autocorr.pks_locs_time_diff = time_diff_autocorr_temp(1:num_cycles);
output.env_autocorr.avg_time_diff = mean(output.env_autocorr.pks_locs_time_diff);

output.env_autocorr.pks_locs = output.env_autocorr.pks_locs_time / dt;
autocorr_locs = output.env_autocorr.pks_locs_time / dt;

output.cropped_autocorr_signal = crop_signal(input_trace, autocorr_locs);
output.cropped_autocorr_env = crop_signal(output.envelope, autocorr_locs);

%using maximum of envelope to pick time

[output.env_max.pks, output.env_max.pks_locs_time] = findpeaks(output.envelope, 1/dt, 'MinPeakDistance', time_tresh);
time_diff_max_temp = diff(output.env_max.pks_locs_time);
output.env_max.pks_locs_time_diff = time_diff_max_temp(1:num_cycles);
output.env_max.avg_time_diff = mean(output.env_max.pks_locs_time_diff);

output.env_max.pks_locs = output.env_max.pks_locs_time / dt;
max_locs = output.env_max.pks_locs_time / dt;

output.cropped_max_signal = crop_signal(input_trace, max_locs - max_locs(1) + 1); %start at loc = 1
output.cropped_max_env = crop_signal(output.envelope, max_locs - max_locs(1) + 1); %start at loc = 1


end

