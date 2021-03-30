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
output.env_autocorr.avg_time_diff = mean(output.env_autocorr.pks_locs_time_diff(2:end)); %omitting source pulse from averaging

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
output.env_max.avg_time_diff = mean(output.env_max.pks_locs_time_diff(2:end)); %omitting source pulse from averaging

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

% Frequency domain analysis

decim_fact = 100; % decimation factor before frequency analysis

output.freq_analysis.decim_trace = input_trace(1:decim_fact:end);
output.freq_analysis.decim_dt = dt * decim_fact;
output.freq_analysis.Fs = 1/output.freq_analysis.decim_dt;

windowlength = floor(length(output.freq_analysis.decim_trace)/(num_cycles+1));
[output.freq_analysis.s, output.freq_analysis.f, output.freq_analysis.t] = spectrogram(output.freq_analysis.decim_trace, windowlength , 0, 1024, output.freq_analysis.Fs);
output.freq_analysis.s_abs = abs(output.freq_analysis.s);
output.freq_analysis.s_abs_db = 20*log10(output.freq_analysis.s_abs);
output.freq_analysis.phase = angle(output.freq_analysis.s);
phase_diff = diff(output.freq_analysis.phase, 1, 2);
phase_diff(phase_diff > pi) = phase_diff(phase_diff > pi) - 2*pi;
phase_diff(phase_diff < -pi) = phase_diff(phase_diff < -pi) + 2*pi;
output.freq_analysis.phase_diff = phase_diff;





for winno=1:length(output.freq_analysis.s(1,:))
    %Dividing by reference spectrum (source pulse)
    factor = max(output.freq_analysis.s_abs(:,winno))/max(output.freq_analysis.s_abs(:,1));
    output.freq_analysis_div_by_source.s_abs(:,winno) = output.freq_analysis.s_abs(:,winno)*factor;
    output.freq_analysis_div_by_source.s_abs_db(:,winno) = 20*log10(output.freq_analysis_div_by_source.s_abs(:,winno));
    
    fieldname = ['window_no' num2str(winno)];
    output.freq_analysis.(fieldname) = spect_analysis(output.freq_analysis.s_abs(:,winno), output.freq_analysis.f);
    output.freq_analysis_div_by_source.(fieldname) = spect_analysis(output.freq_analysis_div_by_source.s_abs(:,winno), output.freq_analysis.f);
    
end
output.freq_analysis.phase_diff_mean = mean(phase_diff(output.freq_analysis.window_no2.f5_idx:output.freq_analysis.window_no2.f6_idx,:));

% output.time_group = output.env_max.pks_locs_time;
% output.time_phase = output.env_max.pks_locs_time + output.phase_correction.timediff*dt;
% 
% output.round_time_group = diff(output.time_group);
% output.round_time_phase = diff(output.time_phase);
% 
% output.propag_vel_group = circumference ./ output.round_time_group; 
% output.propag_vel_phase = circumference ./ output.round_time_phase;
end

