%%
figure; hold on;
plot(agg.model_stats.min*0.04, agg.results.thickness_uncomp)
%plot(agg.model_stats.min*0.04, agg.results.thickness_comp)
set(gca, 'XDir','reverse')
grid on; grid minor;


%%
figure
imagesc(agg.model_stats.min*0.04, [], agg.sensor_data.trace)
set(gca, 'XDir','reverse')
colormap(gray)
%%
figure
imagesc(agg.model_stats.min*0.04, [], agg.sensor_data.trace_autocorr)
set(gca, 'XDir','reverse')
colormap(gray)

%%
figure
imagesc(agg.model_stats.min*0.04, [], agg.sensor_data.trace_hilbert)
set(gca, 'XDir','reverse')
%colormap(gray)