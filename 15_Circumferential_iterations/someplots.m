
%%
figure
hold on
plot(data_circ.d064_000_000_098.analysis_ux.cropped_max_signal.s1,'r-','LineWidth',2)
plot(data_circ.d064_000_000_098.analysis_ux.cropped_max_env.s1, 'r:','LineWidth',2)
plot(data_circ.d064_000_000_098.analysis_ux.cropped_max_signal.s2,'b-','LineWidth',2)
plot(data_circ.d064_000_000_098.analysis_ux.cropped_max_env.s2,'b:','LineWidth', 2)
plot(data_circ.d064_000_000_098.analysis_ux.cropped_max_signal.s3,'g-','LineWidth',2)
plot(data_circ.d064_000_000_098.analysis_ux.cropped_max_env.s3,'g:','LineWidth', 2)
plot(data_circ.d064_000_000_098.analysis_ux.cropped_max_signal.s4,'c-','LineWidth',2)
plot(data_circ.d064_000_000_098.analysis_ux.cropped_max_env.s4,'c:','LineWidth',2)

legend('source pulse', 'source env', 'rot 1', 'env', 'rot 2','env', 'rot 3','env')
hold off
title('Reference')
grid on

figure
hold on
plot(data_circ.d064_002_000_098.analysis_ux.cropped_max_signal.s1,'r-','LineWidth',2)
plot(data_circ.d064_002_000_098.analysis_ux.cropped_max_env.s1, 'r:','LineWidth',2)
plot(data_circ.d064_002_000_098.analysis_ux.cropped_max_signal.s2,'b-','LineWidth',2)
plot(data_circ.d064_002_000_098.analysis_ux.cropped_max_env.s2,'b:','LineWidth', 2)
plot(data_circ.d064_002_000_098.analysis_ux.cropped_max_signal.s3,'g-','LineWidth',2)
plot(data_circ.d064_002_000_098.analysis_ux.cropped_max_env.s3,'g:','LineWidth', 2)
plot(data_circ.d064_002_000_098.analysis_ux.cropped_max_signal.s4,'c-','LineWidth',2)
plot(data_circ.d064_002_000_098.analysis_ux.cropped_max_env.s4,'c:','LineWidth',2)

legend('source pulse', 'source env', 'rot 1', 'env', 'rot 2','env', 'rot 3','env')
hold off
title('Rough model')
grid on

%%

figure
subplot(2,2,1)
plot(data_circ.d063_000_000_098.analysis_ux.phase_correction.s1.lags_time, data_circ.d063_000_000_098.analysis_ux.phase_correction.s1.c)
hold on
stem(data_circ.d063_000_000_098.analysis_ux.phase_correction.s1.lags_locs_time, data_circ.d063_000_000_098.analysis_ux.phase_correction.s1.pks)
grid on

subplot(2,2,2)
plot(data_circ.d063_000_000_098.analysis_ux.phase_correction.s2.lags_time, data_circ.d063_000_000_098.analysis_ux.phase_correction.s2.c)
hold on
stem(data_circ.d063_000_000_098.analysis_ux.phase_correction.s2.lags_locs_time, data_circ.d063_000_000_098.analysis_ux.phase_correction.s2.pks)
grid on

subplot(2,2,3)
plot(data_circ.d063_000_000_098.analysis_ux.phase_correction.s3.lags_time, data_circ.d063_000_000_098.analysis_ux.phase_correction.s3.c)
hold on
stem(data_circ.d063_000_000_098.analysis_ux.phase_correction.s3.lags_locs_time, data_circ.d063_000_000_098.analysis_ux.phase_correction.s3.pks)
grid on

subplot(2,2,4)
plot(data_circ.d063_000_000_098.analysis_ux.phase_correction.s4.lags_time, data_circ.d063_000_000_098.analysis_ux.phase_correction.s4.c)
hold on
stem(data_circ.d063_000_000_098.analysis_ux.phase_correction.s4.lags_locs_time, data_circ.d063_000_000_098.analysis_ux.phase_correction.s4.pks)
grid on
%%
figure
hold on
plot(data_circ.d063_000_000_098.analysis_ux.cropped_max_env.t_array.s1, data_circ.d063_000_000_098.analysis_ux.cropped_max_env.signal.s1)
plot(data_circ.d063_000_000_098.analysis_ux.cropped_max_env.t_array.s2, data_circ.d063_000_000_098.analysis_ux.cropped_max_env.signal.s2)
plot(data_circ.d063_000_000_098.analysis_ux.cropped_max_env.t_array.s3, data_circ.d063_000_000_098.analysis_ux.cropped_max_env.signal.s3)
plot(data_circ.d063_000_000_098.analysis_ux.cropped_max_env.t_array.s4, data_circ.d063_000_000_098.analysis_ux.cropped_max_env.signal.s4)

plot(data_circ.d063_000_000_098.analysis_ux.cropped_max_signal.t_array.s1, data_circ.d063_000_000_098.analysis_ux.cropped_max_signal.signal.s1)
plot(data_circ.d063_000_000_098.analysis_ux.cropped_max_signal.t_array.s2, data_circ.d063_000_000_098.analysis_ux.cropped_max_signal.signal.s2)
plot(data_circ.d063_000_000_098.analysis_ux.cropped_max_signal.t_array.s3, data_circ.d063_000_000_098.analysis_ux.cropped_max_signal.signal.s3)
plot(data_circ.d063_000_000_098.analysis_ux.cropped_max_signal.t_array.s4, data_circ.d063_000_000_098.analysis_ux.cropped_max_signal.signal.s4)

stem(data_circ.d063_000_000_098.analysis_ux.env_max.pks_locs_time, data_circ.d063_000_000_098.analysis_ux.env_max.pks)

stem(data_circ.d063_000_000_098.analysis_ux.phase_correction.s1.lags_locs_time_plus_env_lag, data_circ.d063_000_000_098.analysis_ux.phase_correction.s1.pks)
stem(data_circ.d063_000_000_098.analysis_ux.phase_correction.s2.lags_locs_time_plus_env_lag, data_circ.d063_000_000_098.analysis_ux.phase_correction.s2.pks)
stem(data_circ.d063_000_000_098.analysis_ux.phase_correction.s3.lags_locs_time_plus_env_lag, data_circ.d063_000_000_098.analysis_ux.phase_correction.s3.pks)
stem(data_circ.d063_000_000_098.analysis_ux.phase_correction.s4.lags_locs_time_plus_env_lag, data_circ.d063_000_000_098.analysis_ux.phase_correction.s4.pks)

grid on;
%%
figure
hold on
stem(data_circ.d063_000_000_098.analysis_ux.phase_correction.s1.lags_locs_time_plus_env_lag, data_circ.d063_000_000_098.analysis_ux.phase_correction.s1.c)

%% plot all seeds
%envelopes autocorr
figure
hold on
plot(data_circ.d061_000_000_100.analysis_ux.env_autocorr.lags, data_circ.d061_000_000_100.analysis_ux.env_autocorr.c)
plot(data_circ.d061_012_000_100.analysis_ux.env_autocorr.lags, data_circ.d061_012_000_100.analysis_ux.env_autocorr.c)
plot(data_circ.d061_012_001_100.analysis_ux.env_autocorr.lags, data_circ.d061_012_001_100.analysis_ux.env_autocorr.c)
plot(data_circ.d061_012_002_100.analysis_ux.env_autocorr.lags, data_circ.d061_012_002_100.analysis_ux.env_autocorr.c)
set(gca,'ColorOrderIndex',1)
stem(data_circ.d061_000_000_100.analysis_ux.env_autocorr.pks_locs, data_circ.d061_000_000_100.analysis_ux.env_autocorr.pks)
stem(data_circ.d061_012_000_100.analysis_ux.env_autocorr.pks_locs, data_circ.d061_012_000_100.analysis_ux.env_autocorr.pks)
stem(data_circ.d061_012_001_100.analysis_ux.env_autocorr.pks_locs, data_circ.d061_012_001_100.analysis_ux.env_autocorr.pks)
stem(data_circ.d061_012_002_100.analysis_ux.env_autocorr.pks_locs, data_circ.d061_012_002_100.analysis_ux.env_autocorr.pks)

%signal autocorr - phase info
figure
hold on

set(gca,'ColorOrderIndex',1)



