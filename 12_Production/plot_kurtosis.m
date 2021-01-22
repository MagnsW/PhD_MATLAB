%%
figure('position', [100 100 1200 1000])
plot(agg_nopit.analysis_H.kurtosis')
hold on
plot(agg_pit.analysis_H.kurtosis', ':')
hold off
grid on
title('Kurtosis of envelope')
xlabel('Trace number')
%%
figure('position', [100 100 1200 1000])
plot(agg_nopit.amplitudes_H.db.amax')
hold on
plot(agg_pit.amplitudes_H.db.amax', ':')
hold off
grid on
title('Amplitude of envelope (dB)')
xlabel('Trace number')
%%
figure('position', [100 100 1200 1000])
plot(agg_nopit.amplitudes_H.lin.amax')
hold on
plot(agg_pit.amplitudes_H.lin.amax', ':') 
hold off
grid on
title('Amplitude of envelope (lin)')
xlabel('Trace number')

%%
figure('position', [100 100 1200 1000])
plot(agg_nopit.amplitudes_H.lin.amax')
hold on
plot(agg_pit.amplitudes_H.lin.amax', ':') 
hold off
grid on
title('Amplitude of envelope (lin)')
xlabel('Trace number')