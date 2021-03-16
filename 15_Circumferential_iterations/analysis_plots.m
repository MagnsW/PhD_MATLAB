function analysis_plots(analysis_struct)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here


figure('Position', [10 10 1510 810])
%Plotting cross-correlations
subplot(2,2,1)
plot(analysis_struct.analysis_ux.phase_correction.s1.lags_time, analysis_struct.analysis_ux.phase_correction.s1.c)
hold on
stem(analysis_struct.analysis_ux.phase_correction.s1.lags_locs_time, analysis_struct.analysis_ux.phase_correction.s1.pks)
grid on; grid minor;
title('X-corr of source wavelet with itself')
xlim([-1 1]*1e-4);
ylim([-1 1.2]*1e-11)
xlabel('Time [s]')


subplot(2,2,2)
plot(analysis_struct.analysis_ux.phase_correction.s2.lags_time, analysis_struct.analysis_ux.phase_correction.s2.c)
hold on
stem(analysis_struct.analysis_ux.phase_correction.s2.lags_locs_time, analysis_struct.analysis_ux.phase_correction.s2.pks)
grid on; grid minor;
title('X-corr of first pass with source wavelet')
xlim([-1 1]*1e-4);
ylim([-1 1.2]*1e-11)
xlabel('Time [s]')

subplot(2,2,3)
plot(analysis_struct.analysis_ux.phase_correction.s3.lags_time, analysis_struct.analysis_ux.phase_correction.s3.c)
hold on
stem(analysis_struct.analysis_ux.phase_correction.s3.lags_locs_time, analysis_struct.analysis_ux.phase_correction.s3.pks)
grid on; grid minor;
title('X-corr of second pass with first pass')
xlim([-1 1]*1e-4);
ylim([-1 1.2]*1e-11)
xlabel('Time [s]')

subplot(2,2,4)
plot(analysis_struct.analysis_ux.phase_correction.s4.lags_time, analysis_struct.analysis_ux.phase_correction.s4.c)
hold on
stem(analysis_struct.analysis_ux.phase_correction.s4.lags_locs_time, analysis_struct.analysis_ux.phase_correction.s4.pks)
grid on; grid minor;
title('X-corr of third pass with second pass')
xlim([-1 1]*1e-4);
ylim([-1 1.2]*1e-11)
xlabel('Time [s]')

suptitle(['Thickness [mm]: ', num2str(analysis_struct.input_param.thickness*analysis_struct.dx*1e3), '; Pitting depth [mm]: ',num2str(analysis_struct.input_param.pitting_depth*analysis_struct.dx*1e3)]);



figure('Position', [10 10 1510 810])
hold on
%plotting cropped signal concatenated
plot(analysis_struct.analysis_ux.cropped_max_signal.t_array.s1, analysis_struct.analysis_ux.cropped_max_signal.signal.s1)
plot(analysis_struct.analysis_ux.cropped_max_signal.t_array.s2, analysis_struct.analysis_ux.cropped_max_signal.signal.s2)
plot(analysis_struct.analysis_ux.cropped_max_signal.t_array.s3, analysis_struct.analysis_ux.cropped_max_signal.signal.s3)
plot(analysis_struct.analysis_ux.cropped_max_signal.t_array.s4, analysis_struct.analysis_ux.cropped_max_signal.signal.s4)

set(gca,'ColorOrderIndex',1)

%plotting envelopes
plot(analysis_struct.analysis_ux.cropped_max_env.t_array.s1, analysis_struct.analysis_ux.cropped_max_env.signal.s1, '--')
plot(analysis_struct.analysis_ux.cropped_max_env.t_array.s2, analysis_struct.analysis_ux.cropped_max_env.signal.s2, '--')
plot(analysis_struct.analysis_ux.cropped_max_env.t_array.s3, analysis_struct.analysis_ux.cropped_max_env.signal.s3, '--')
plot(analysis_struct.analysis_ux.cropped_max_env.t_array.s4, analysis_struct.analysis_ux.cropped_max_env.signal.s4, '--')

stem(analysis_struct.analysis_ux.env_max.pks_locs_time, analysis_struct.analysis_ux.env_max.pks,'k')

% set(gca,'ColorOrderIndex',1)
% 
% stem(analysis_struct.analysis_ux.phase_correction.s1.lags_locs_time_plus_env_lag, analysis_struct.analysis_ux.phase_correction.s1.pks)
% stem(analysis_struct.analysis_ux.phase_correction.s2.lags_locs_time_plus_env_lag, analysis_struct.analysis_ux.phase_correction.s2.pks)
% stem(analysis_struct.analysis_ux.phase_correction.s3.lags_locs_time_plus_env_lag, analysis_struct.analysis_ux.phase_correction.s3.pks)
% stem(analysis_struct.analysis_ux.phase_correction.s4.lags_locs_time_plus_env_lag, analysis_struct.analysis_ux.phase_correction.s4.pks)

grid on;grid minor;
title({'Signals and envelopes from all passes concatenated', ['Thickness [mm]: ', num2str(analysis_struct.input_param.thickness*analysis_struct.dx*1e3), '; Pitting depth [mm]: ',num2str(analysis_struct.input_param.pitting_depth*analysis_struct.dx*1e3)  ]})
xlim([-0.5 4]*1e-4);
ylim([-1 1]*1e-7)
xlabel('Time [s]')


figure('Position', [10 10 1510 810])
hold on
fact = 0.75e4;
%plotting cross-correlation signals concatenated
plot(analysis_struct.analysis_ux.phase_correction.s1.lags_time_plus_env_lag, analysis_struct.analysis_ux.phase_correction.s1.c*fact)
plot(analysis_struct.analysis_ux.phase_correction.s2.lags_time_plus_env_lag, analysis_struct.analysis_ux.phase_correction.s2.c*fact)
plot(analysis_struct.analysis_ux.phase_correction.s3.lags_time_plus_env_lag, analysis_struct.analysis_ux.phase_correction.s3.c*fact)
plot(analysis_struct.analysis_ux.phase_correction.s4.lags_time_plus_env_lag, analysis_struct.analysis_ux.phase_correction.s4.c*fact)

set(gca,'ColorOrderIndex',1)

%plotting envelopes
plot(analysis_struct.analysis_ux.cropped_max_env.t_array.s1, analysis_struct.analysis_ux.cropped_max_env.signal.s1, '--')
plot(analysis_struct.analysis_ux.cropped_max_env.t_array.s2, analysis_struct.analysis_ux.cropped_max_env.signal.s2, '--')
plot(analysis_struct.analysis_ux.cropped_max_env.t_array.s3, analysis_struct.analysis_ux.cropped_max_env.signal.s3, '--')
plot(analysis_struct.analysis_ux.cropped_max_env.t_array.s4, analysis_struct.analysis_ux.cropped_max_env.signal.s4, '--')

stem(analysis_struct.analysis_ux.env_max.pks_locs_time, analysis_struct.analysis_ux.env_max.pks,'k')

set(gca,'ColorOrderIndex',1)

stem(analysis_struct.analysis_ux.phase_correction.s1.lags_locs_time_plus_env_lag, analysis_struct.analysis_ux.phase_correction.s1.pks*fact)
stem(analysis_struct.analysis_ux.phase_correction.s2.lags_locs_time_plus_env_lag, analysis_struct.analysis_ux.phase_correction.s2.pks*fact)
stem(analysis_struct.analysis_ux.phase_correction.s3.lags_locs_time_plus_env_lag, analysis_struct.analysis_ux.phase_correction.s3.pks*fact)
stem(analysis_struct.analysis_ux.phase_correction.s4.lags_locs_time_plus_env_lag, analysis_struct.analysis_ux.phase_correction.s4.pks*fact)

grid on;grid minor;
title({'X-correlations (scaled) with marked maxima for all passes concatenated', ['Thickness [mm]: ', num2str(analysis_struct.input_param.thickness*analysis_struct.dx*1e3), '; Pitting depth [mm]: ',num2str(analysis_struct.input_param.pitting_depth*analysis_struct.dx*1e3)  ]})
xlim([-0.5 4]*1e-4);
ylim([-1 1]*1e-7)
xlabel('Time [s]')
end

