%%
figure
hold on;
plot(data_analyzed_avg_decim_ft_nfft.d064_000_000_100.sensor_data_ft.f, data_analyzed_avg_decim_ft_nfft.d064_000_000_100.sensor_data_ft.ux(:,1:end))
plot(data_analyzed_avg_decim_ft_nfft.d064_012_000_100.sensor_data_ft.f, data_analyzed_avg_decim_ft_nfft.d064_012_000_100.sensor_data_ft.ux(:,1:end), ':')
xlim([0 1e5]);

%%
figure
hold on;
plot(data_analyzed_avg_decim_ft_nfft.d064_000_000_100.sensor_data_ft.f, data_analyzed_avg_decim_ft_nfft.d064_000_000_100.sensor_data_ft.ux_db(:,1:end))
plot(data_analyzed_avg_decim_ft_nfft.d061_000_000_100.sensor_data_ft.f, data_analyzed_avg_decim_ft_nfft.d061_000_000_100.sensor_data_ft.ux_db(:,1:end), ':')
xlim([0 1e5]);

%%
figure
hold on;
plot(data_analyzed_avg_decim_ft_nfft.d064_000_000_100.s_hilbert.ux.kurtosis)
plot(data_analyzed_avg_decim_ft_nfft.d064_012_000_100.s_hilbert.ux.kurtosis)

%%
figure
hold on;
plot(data_analyzed_avg_decim_ft_nfft.d064_000_000_100.s_hilbert.ux.headers(2,:), 'b-')
plot(data_analyzed_avg_decim_ft_nfft.d061_000_000_100.s_hilbert.ux.headers(2,:), 'r-')
plot(data_analyzed_avg_decim_ft_nfft.d064_012_000_100.s_hilbert.ux.headers(2,:), 'b:')
plot(data_analyzed_avg_decim_ft_nfft.d061_012_000_100.s_hilbert.ux.headers(2,:), 'r:')

%%
figure
hold on;
plot(data_analyzed_avg_decim_ft_nfft.d064_000_000_100.s_hilbert.ux.kurtosis, 'b-')
plot(data_analyzed_avg_decim_ft_nfft.d061_000_000_100.s_hilbert.ux.kurtosis, 'r-')
plot(data_analyzed_avg_decim_ft_nfft.d064_012_000_100.s_hilbert.ux.kurtosis, 'b:')
plot(data_analyzed_avg_decim_ft_nfft.d061_012_000_100.s_hilbert.ux.kurtosis, 'r:')

%%
figure
hold on;
plot(data_analyzed_avg_decim_ft_nfft.d064_000_000_100.s_sensor_data_time.ux.kurtosis, 'b-')
plot(data_analyzed_avg_decim_ft_nfft.d061_000_000_100.s_sensor_data_time.ux.kurtosis, 'r-')
plot(data_analyzed_avg_decim_ft_nfft.d064_012_000_100.s_sensor_data_time.ux.kurtosis, 'b:')
plot(data_analyzed_avg_decim_ft_nfft.d061_012_000_100.s_sensor_data_time.ux.kurtosis, 'r:')
