figure
plot(data_circ.d061_000_000_098.analysis_ux.freq_analysis.f, data_circ.d061_000_000_098.analysis_ux.freq_analysis.s_abs(:,4))
hold on
stem(data_circ.d061_000_000_098.analysis_ux.freq_analysis.window_no4.f_peak, data_circ.d061_000_000_098.analysis_ux.freq_analysis.window_no4.max_amp,'r', 'LineWidth',2)
stem(data_circ.d061_000_000_098.analysis_ux.freq_analysis.window_no4.f1, data_circ.d061_000_000_098.analysis_ux.freq_analysis.window_no4.tenperc, 'b', 'LineWidth',2)
stem(data_circ.d061_000_000_098.analysis_ux.freq_analysis.window_no4.f4, data_circ.d061_000_000_098.analysis_ux.freq_analysis.window_no4.tenperc, 'b', 'LineWidth',2)
stem(data_circ.d061_000_000_098.analysis_ux.freq_analysis.window_no4.f2, data_circ.d061_000_000_098.analysis_ux.freq_analysis.window_no4.ninetyperc, 'g', 'LineWidth',2)
stem(data_circ.d061_000_000_098.analysis_ux.freq_analysis.window_no4.f3, data_circ.d061_000_000_098.analysis_ux.freq_analysis.window_no4.ninetyperc, 'g', 'LineWidth',2)
stem(data_circ.d061_000_000_098.analysis_ux.freq_analysis.window_no4.f5, data_circ.d061_000_000_098.analysis_ux.freq_analysis.window_no4.halfMax, 'c', 'LineWidth',2)
stem(data_circ.d061_000_000_098.analysis_ux.freq_analysis.window_no4.f6, data_circ.d061_000_000_098.analysis_ux.freq_analysis.window_no4.halfMax, 'c', 'LineWidth',2)
grid on; grid minor;
xlim([0 1]*1e5);