function plot_variations(reference_dataset, dataset1, dataset2, dataset3)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here


figure('position', [10 10, 1800, 1200])
subplot(2,2,1)
hold on
set(gca,'ColorOrderIndex',1)
plot(reference_dataset.t_array, reference_dataset.trace_ux_mean);
plot(dataset1.t_array, dataset1.trace_ux_mean);
plot(dataset2.t_array, dataset2.trace_ux_mean);
plot(dataset3.t_array, dataset3.trace_ux_mean);
title('Signal')
grid on; grid minor
xlim([0 3.5]*1e-4);


subplot(2,2,2)
hold on
set(gca,'ColorOrderIndex',1)


plot(reference_dataset.t_array, reference_dataset.analysis_ux.envelope);
plot(dataset1.t_array, dataset1.analysis_ux.envelope);
plot(dataset2.t_array, dataset2.analysis_ux.envelope);
plot(dataset3.t_array, dataset3.analysis_ux.envelope);
title('Envelope')
grid on; grid minor;
xlim([0 3.5]*1e-4);


subplot(2,2,3)
hold on
set(gca,'ColorOrderIndex',1)
plot(reference_dataset.analysis_ux.autocorrelation.t_array, reference_dataset.analysis_ux.autocorrelation.signal)
plot(dataset1.analysis_ux.autocorrelation.t_array, dataset1.analysis_ux.autocorrelation.signal)
plot(dataset2.analysis_ux.autocorrelation.t_array, dataset2.analysis_ux.autocorrelation.signal)
plot(dataset3.analysis_ux.autocorrelation.t_array, dataset3.analysis_ux.autocorrelation.signal)

set(gca,'ColorOrderIndex',1)

stem(reference_dataset.analysis_ux.autocorrelation.locs_time, reference_dataset.analysis_ux.autocorrelation.pks)
stem(dataset1.analysis_ux.autocorrelation.locs_time, dataset1.analysis_ux.autocorrelation.pks)
stem(dataset2.analysis_ux.autocorrelation.locs_time, dataset2.analysis_ux.autocorrelation.pks)
stem(dataset3.analysis_ux.autocorrelation.locs_time, dataset3.analysis_ux.autocorrelation.pks)
grid on; grid minor


title('Autocorrelation of signal')
xlim([0 3.5]*1e-4);


subplot(2,2,4)
hold on
set(gca,'ColorOrderIndex',1)
plot(reference_dataset.analysis_ux.env_autocorr.lags_time, reference_dataset.analysis_ux.env_autocorr.c)
plot(dataset1.analysis_ux.env_autocorr.lags_time, dataset1.analysis_ux.env_autocorr.c)
plot(dataset2.analysis_ux.env_autocorr.lags_time, dataset2.analysis_ux.env_autocorr.c)
plot(dataset3.analysis_ux.env_autocorr.lags_time, dataset3.analysis_ux.env_autocorr.c)

set(gca,'ColorOrderIndex',1)
stem(reference_dataset.analysis_ux.env_autocorr.pks_locs_time, reference_dataset.analysis_ux.env_autocorr.pks)
stem(dataset1.analysis_ux.env_autocorr.pks_locs_time, dataset1.analysis_ux.env_autocorr.pks)
stem(dataset2.analysis_ux.env_autocorr.pks_locs_time, dataset2.analysis_ux.env_autocorr.pks)
stem(dataset3.analysis_ux.env_autocorr.pks_locs_time, dataset3.analysis_ux.env_autocorr.pks)
title('Autocorrelation of envelopes')
grid on; grid minor;
xlim([0 3.5]*1e-4);

leg = legend(convertCharsToStrings(reference_dataset.input_param.datasetname), dataset1.input_param.datasetname,...
    dataset2.input_param.datasetname, dataset3.input_param.datasetname);
set(leg,'Interpreter', 'none')

end

