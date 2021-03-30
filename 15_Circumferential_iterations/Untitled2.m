figure
plot(data_circ.d064_000_000_098.analysis_ux.freq_analysis.f, data_circ.d064_000_000_098.analysis_ux.freq_analysis.phase_diff )
xlim([0 1]*1e5);
grid on;
hold on

set(gca,'ColorOrderIndex',1)
plot(data_circ.d064_000_000_101.analysis_ux.freq_analysis.f, data_circ.d064_000_000_101.analysis_ux.freq_analysis.phase_diff, ':' )
