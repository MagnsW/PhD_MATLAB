function [output] = trace_analyse(input_trace, dt)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
time_tresh = 50e-6; %At least 50 microseconds per revolution

num_cycles = 3; %Number of circumferential cycles considered
circumference = 1280*0.2e-3; %m 

%envelope detection and circumferential propagation time for group. Based
%on autocorrelation.
output.envelope = abs(hilbert(input_trace));
[c, lags] = xcorr(output.envelope);
output.env_autocorr.c = c(floor(length(c)/2):end); %only look at last half
output.env_autocorr.lags = lags(floor(length(lags)/2):end); %only look at last half
output.env_autocorr.lags_time = output.env_autocorr.lags*dt;
[output.env_autocorr.pks, output.env_autocorr.pks_locs_time] = findpeaks(output.env_autocorr.c, 1/dt, 'MinPeakDistance', time_tresh);

time_diff_autocorr_temp = diff(output.env_autocorr.pks_locs_time);
num_max1 = min(length(time_diff_autocorr_temp), num_cycles);
output.env_autocorr.pks_locs_time_diff = time_diff_autocorr_temp(1:num_max1);
output.env_autocorr.avg_time_diff = mean(output.env_autocorr.pks_locs_time_diff);

output.env_autocorr.pks_locs = output.env_autocorr.pks_locs_time / dt;
autocorr_locs = int32(output.env_autocorr.pks_locs_time / dt);

output.cropped_autocorr_signal = crop_signal(input_trace, autocorr_locs, dt);
output.cropped_autocorr_env = crop_signal(output.envelope, autocorr_locs, dt);

%using maximum of envelope to pick time. Alternative to the autocorrelation
%approach.

[output.env_max.pks, output.env_max.pks_locs_time] = findpeaks(output.envelope, 1/dt, 'MinPeakDistance', time_tresh);
output.env_max.pks = output.env_max.pks(1:num_cycles+1);
output.env_max.pks_locs_time = output.env_max.pks_locs_time(1:num_cycles+1);
output.env_max.pks_locs = int32(output.env_max.pks_locs_time / dt);
time_diff_max_temp = diff(output.env_max.pks_locs_time);
output.env_max.pks_locs_time_diff = time_diff_max_temp(1:num_cycles);
output.env_max.avg_time_diff = mean(output.env_max.pks_locs_time_diff);

% New - find minimum peaks in the envelope to define the index for cropping
% the signal.

[output.env_max.pks_min, output.env_max.pks_min_locs_time] = findpeaks(-output.envelope, 1/dt, 'MinPeakDistance', time_tresh);
output.env_max.pks_min = output.env_max.pks_min(1:num_cycles+1);
output.env_max.pks_min_locs_time = output.env_max.pks_min_locs_time(1:num_cycles+1);
output.env_max.pks_min_locs = int32(output.env_max.pks_min_locs_time / dt);
max_locs_min = int32(output.env_max.pks_min_locs_time / dt);

output.cropped_max_signal = crop_signal(input_trace, max_locs_min, dt);
output.cropped_max_env = crop_signal(output.envelope, max_locs_min, dt);

% End of new code

% output.env_max.pks_locs = int32(output.env_max.pks_locs_time / dt);
% max_locs = int32(output.env_max.pks_locs_time / dt);
% 
% output.cropped_max_signal = crop_signal(input_trace, max_locs - max_locs(1) + 1, dt); %start at loc = 1
% output.cropped_max_env = crop_signal(output.envelope, max_locs - max_locs(1) + 1, dt); %start at loc = 1

%Group round time =
%Phase round time = Group round time + phase delay.

%computing phase delays:
output.phase_correction = struct_corr(output.cropped_max_signal.signal, dt, output.env_max.pks_locs_time); % changed from output.env_max.pks_locs_time to output.env_max.pks_min_locs_time

signals = fieldnames(output.phase_correction);
for k=2:length(signals)
    output.traveltime_matrix.(signals{k}) = difference_matrix(output.phase_correction.(signals{k}).lags_locs_time_plus_env_lag, output.phase_correction.(signals{k-1}).lags_locs_time_plus_env_lag);
    output.ph_velocity_matrix.(signals{k}) = circumference ./ output.traveltime_matrix.(signals{k});
end

sourcefreq = 5e4; %KHz
period = 1/(sourcefreq*10); %s setting minimum peak distance for the picking

autocorr = xcorr(input_trace);
output.autocorrelation.signal = autocorr(length(input_trace)-1:end);
output.autocorrelation.t_array = (1:length(output.autocorrelation.signal))*dt;
[output.autocorrelation.pks, output.autocorrelation.locs_time] = findpeaks(output.autocorrelation.signal, 1/dt,'MinPeakDistance',period);
output.autocorrelation.locs = int32(output.autocorrelation.locs_time / dt);

output.autocorrelation.traveltime_matrix = difference_matrix(output.autocorrelation.locs_time, output.autocorrelation.locs_time);
output.autocorrelation.ph_velocity_matrix = circumference ./ output.autocorrelation.traveltime_matrix;


% output.time_group = output.env_max.pks_locs_time;
% output.time_phase = output.env_max.pks_locs_time + output.phase_correction.timediff*dt;
% 
% output.round_time_group = diff(output.time_group);
% output.round_time_phase = diff(output.time_phase);
% 
% output.propag_vel_group = circumference ./ output.round_time_group; 
% output.propag_vel_phase = circumference ./ output.round_time_phase;
end

