function [ModelThickMax, ModelThickMin, ModelThickDiff, ModelThickMedian, ModelThickMean,  ModelThickStd, ModelVelCoeff, EnvelopeAvgTimeDiff, EnvelopeAvgAmpReduc, PhaseDiffMean, Win4_PeakAmp, Win4_PeakFreq, Win4_fwhmFreqRange] = get_summary(dataset)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
%DatasetName = dataset.input_param.datasetname;
ModelThickMax = dataset.model_stats.thickness.max;
ModelThickMin = dataset.model_stats.thickness.min;
ModelThickDiff = dataset.model_stats.thickness.max - dataset.model_stats.thickness.min;
ModelThickMean = dataset.model_stats.thickness.mean;
ModelThickMedian = dataset.model_stats.thickness.median;
ModelThickStd = dataset.model_stats.thickness.std;
ModelVelCoeff = dataset.input_param.velcoeff;
EnvelopeAvgTimeDiff = dataset.analysis_ux.env_max.avg_time_diff;
EnvelopeAvgAmpReduc = mean(diff(dataset.analysis_ux.env_max.pks(2:end) ./ dataset.analysis_ux.env_max.pks(2))); %reduced amplitude from second envelope
%PhaseDiffMean = mean(dataset.analysis_ux.freq_analysis.phase_diff_mean(2:end)); %mean phase difference omitting the source
PhaseDiffMean = dataset.analysis_ux.freq_analysis.phase_diff_mean(3); %last phase difference
% Peak frequency
Win4_PeakAmp = dataset.analysis_ux.freq_analysis.window_no4.peak_amp;
Win4_PeakFreq = dataset.analysis_ux.freq_analysis.window_no4.f_peak;
Win4_fwhmFreqRange = dataset.analysis_ux.freq_analysis.window_no4.fwhm_f_range;
% slopes, fwhm
end

