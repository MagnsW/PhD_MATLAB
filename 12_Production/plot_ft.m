%%
figure('position', [100 100 1000 1200])
plot(data_analyzed.d064_000_000_100.sensor_data_ft.f, data_analyzed.d064_000_000_100.sensor_data_ft.ux, 'LineWidth', 2)
hold on
plot(data_analyzed.d061_000_000_100.sensor_data_ft.f, data_analyzed.d061_000_000_100.sensor_data_ft.ux, ':','LineWidth', 2)
xlim([0, 1e5])
grid on
xlabel('Frequency (Hz)')
ylabel('Amplitude')
title('Amplitude spectrum - uniform thickness reduction')

%%
figure('position', [100 100 1000 1200])
plot(data_analyzed.d064_000_000_100.sensor_data_ft.f, data_analyzed.d064_000_000_100.sensor_data_ft.ux, 'LineWidth', 2)
hold on
plot(data_analyzed.d061_000_000_100.sensor_data_ft.f, data_analyzed.d064_012_000_100.sensor_data_ft.ux, ':','LineWidth', 2)
xlim([0, 1e5])
grid on
xlabel('Frequency (Hz)')
ylabel('Amplitude')
title('Amplitude spectrum - pitting')