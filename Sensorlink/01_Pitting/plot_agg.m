%%
figure; hold on;
plot(agg.model_stats.min*0.04, agg.results.thickness_uncomp)
%plot(agg.model_stats.min*0.04, agg.results.thickness_comp)
set(gca, 'XDir','reverse')
grid on; grid minor;
xlabel('Min thickness (mm)')
ylabel('Thickness uncomp')


%%
figure; hold on;
plot(agg.results.thickness_uncomp)
%plot(agg.model_stats.min*0.04, agg.results.thickness_comp)
%set(gca, 'XDir','reverse')
grid on; grid minor;
xlabel('Trace number)')
ylabel('Thickness uncomp')


%%
figure
subplot(2,2,1)
imagesc(agg.model_stats.min*0.04, [], agg.sensor_data.trace)
set(gca, 'XDir','reverse')
%colormap(gray)
title('Trace')

subplot(2,2,2)
imagesc(agg.model_stats.min*0.04, [], agg.sensor_data.trace_hilbert)
set(gca, 'XDir','reverse')
title('Hilbert transform of trace')
%colormap(gray)

subplot(2,2,3)
imagesc(agg.model_stats.min*0.04, [], agg.sensor_data.trace_autocorr)
set(gca, 'XDir','reverse')
%colormap(gray)
title('Autocorrelation of trace')
xlabel('Min thickness (mm)')

subplot(2,2,4)
imagesc(agg.model_stats.min*0.04, [], agg.sensor_data.trace_autocorr_hilbert)
set(gca, 'XDir','reverse')
%colormap(gray)
title('Autocorrelation of Hilbert transform')
xlabel('Min thickness (mm)')

%%

figure; 
plot(agg.sensor_data.trace_autocorr(:,1))
hold on
plot(agg.sensor_data.trace_autocorr(:,6))
plot(agg.sensor_data.trace_autocorr(:,12))

%%

figure; 
plot(agg.sensor_data.trace_autocorr_hilbert(:,1))
hold on
plot(agg.sensor_data.trace_autocorr_hilbert(:,6))
plot(agg.sensor_data.trace_autocorr_hilbert(:,12))
legend('Trace 1', 'Trace 6', 'Trace 12')