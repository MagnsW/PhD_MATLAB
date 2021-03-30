function plot_variations_ph(reference_dataset, dataset1, dataset2, dataset3)

windowno = 3;

figure
plot(reference_dataset.analysis_ux.freq_analysis.f, reference_dataset.analysis_ux.freq_analysis.phase(:,windowno))
hold on
plot(dataset1.analysis_ux.freq_analysis.f, dataset1.analysis_ux.freq_analysis.phase(:,windowno))
plot(dataset2.analysis_ux.freq_analysis.f, dataset2.analysis_ux.freq_analysis.phase(:,windowno))
plot(dataset3.analysis_ux.freq_analysis.f, dataset3.analysis_ux.freq_analysis.phase(:,windowno))
grid on; grid minor;
xlim([0 1]*1e5);
% ylim([0 1.4]*1e-6)
xlabel('Frequency [Hz]')

leg = legend(convertCharsToStrings(reference_dataset.input_param.datasetname), dataset1.input_param.datasetname,...
    dataset2.input_param.datasetname, dataset3.input_param.datasetname);
set(leg,'Interpreter', 'none')
end
