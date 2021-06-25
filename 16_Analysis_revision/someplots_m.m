
%%
figure
stem(data_circ.d064_012_002_099.analysis_ux.autocorrelation.locs_time, data_circ.d064_012_002_099.analysis_ux.autocorrelation.pks)
hold on
stem(data_circ.d064_012_002_099.analysis_ux.env_autocorr.pks_locs_time, data_circ.d064_012_002_099.analysis_ux.env_autocorr.pks)

%%
figure
stem(data_circ.d061_012_002_099.analysis_ux.autocorrelation.locs_time, data_circ.d061_012_002_099.analysis_ux.autocorrelation.pks)
hold on
stem(data_circ.d061_012_002_099.analysis_ux.env_autocorr.pks_locs_time, data_circ.d061_012_002_099.analysis_ux.env_autocorr.pks)
%%
figure
plot(data_circ.d061_012_002_099.analysis_ux.autocorrelation.t_array,data_circ.d061_012_002_099.analysis_ux.autocorrelation.signal)
hold on
stem(data_circ.d061_012_002_099.analysis_ux.autocorrelation.locs_time, data_circ.d061_012_002_099.analysis_ux.autocorrelation.pks)
plot(data_circ.d061_012_002_099.analysis_ux.env_autocorr.lags_time, data_circ.d061_012_002_099.analysis_ux.env_autocorr.c)
stem(data_circ.d061_012_002_099.analysis_ux.env_autocorr.pks_locs_time, data_circ.d061_012_002_099.analysis_ux.env_autocorr.pks)

%%
figure
plot(data_circ.d064_002_002_099.analysis_ux.autocorrelation.t_array,data_circ.d064_002_002_099.analysis_ux.autocorrelation.signal)
hold on
stem(data_circ.d064_002_002_099.analysis_ux.autocorrelation.locs_time, data_circ.d064_002_002_099.analysis_ux.autocorrelation.pks)
plot(data_circ.d064_002_002_099.analysis_ux.env_autocorr.lags_time, data_circ.d064_002_002_099.analysis_ux.env_autocorr.c)
stem(data_circ.d064_002_002_099.analysis_ux.env_autocorr.pks_locs_time, data_circ.d064_002_002_099.analysis_ux.env_autocorr.pks)
