%% load data
data_circ = load('C:\Users\Magnus\PhD\Code\MATLAB\Scripts\15_Circumferential_iterations\data_circumferential.mat');
%data_circ_random = load('C:\Users\Magnus\PhD\Code\MATLAB\Scripts\15_Circumferential_iterations\data_circumferential_random.mat');

%% Compute model stats
fn = fieldnames(data_circ);
for i=1:numel(fn)
    disp(['Processing model stats on: ', num2str(i), ', Datasetname: ', data_circ.(fn{i}).input_param.datasetname])
    data_circ.(fn{i}).model_stats = model_stats(data_circ.(fn{i}).medium);
end

%% Compute model stats - random dataset
fn = fieldnames(data_circ_random);
for i=1:numel(fn)
    if( isfield(data_circ_random.(fn{i}), 'sensor_data') )
        disp(['Processing model stats on: ', num2str(i), ', Datasetname: ', data_circ_random.(fn{i}).input_param.datasetname])
        data_circ_random.(fn{i}).model_stats = model_stats(data_circ_random.(fn{i}).medium);
    end
end

%% Post processing
fn = fieldnames(data_circ);
for j=1:numel(fn)
    if( isfield(data_circ.(fn{j}), 'sensor_data') )
        disp(['Processing done on simulation no: ', num2str(j), ', Datasetname: ', data_circ.(fn{j}).input_param.datasetname]);
        data_circ.(fn{j}).trace_ux_mean = mean(data_circ.(fn{j}).sensor_data.ux);
        data_circ.(fn{j}).t_array = (1:length(data_circ.(fn{j}).trace_ux_mean))*data_circ.(fn{j}).dt;
        data_circ.(fn{j}).analysis_ux = trace_analyse(data_circ.(fn{j}).trace_ux_mean, data_circ.(fn{j}).dt);
        
    end
end

%% Post processing - random

fn = fieldnames(data_circ_random);
for j=1:numel(fn)
    if( isfield(data_circ_random.(fn{j}), 'sensor_data') )
        disp(['Processing done on simulation no: ', num2str(j), ', Datasetname: ', data_circ_random.(fn{j}).input_param.datasetname]);
        data_circ_random.(fn{j}).trace_ux_mean = mean(data_circ_random.(fn{j}).sensor_data.ux);
        data_circ_random.(fn{j}).t_array = (1:length(data_circ_random.(fn{j}).trace_ux_mean))*data_circ_random.(fn{j}).dt;
        data_circ_random.(fn{j}).analysis_ux = trace_analyse(data_circ_random.(fn{j}).trace_ux_mean, data_circ_random.(fn{j}).dt);
        
    end
end


%% Aggregate features
features_titles = {'MTMax', 'MTMin', 'MTDiff', 'MTMedian', 'MTMean', 'MTStd', 'MVelCoeff', 'EATDiff', 'EAARed', 'PhDMean', 'PAmpWin4', 'PFreqWin4', 'fwhmFreqRangeWin4'};
% features_titles = {'ModelThickMax', 'ModelThickMin', 'ModelThickDiff', 'ModelThickMedian', 'ModelThickMean', 'ModelThickStd', 'ModeVelCoeff', 'EnvelopeAvgTimeDiff', 'EnvelopeAvgAmpReduc', 'PhaseDiffMean', 'Win4_PeakAmp', 'Win4_PeakFreq', 'Win4_fwhmFreqRange'};
features_array = zeros(length(fn), length(features_titles));
for k=1:numel(fn)
    [ModelThickMax, ModelThickMin, ModelThickDiff, ModelThickMedian, ModelThickMean, ModelThickStd, ModeVelCoeff, EnvelopeAvgTimeDiff, EnvelopeAvgAmpReduc, PhaseDiffMean, Win4_PeakAmp, Win4_PeakFreq, Win4_fwhmFreqRange] = get_summary(data_circ.(fn{k}));
    features_array(k,:) = [ModelThickMax, ModelThickMin, ModelThickDiff, ModelThickMedian, ModelThickMean, ModelThickStd, ModeVelCoeff, EnvelopeAvgTimeDiff, EnvelopeAvgAmpReduc, PhaseDiffMean, Win4_PeakAmp, Win4_PeakFreq, Win4_fwhmFreqRange]; 
end
features_table = array2table(features_array,'VariableNames', features_titles);
clear ModelThickMax ModelThickMin ModelThickDiff ModelThickMedian ModelThickMean ModelThickStd ModeVelCoeff EnvelopeAvgTimeDiff EnvelopeAvgAmpReduc PhaseDiffMean Win4_PeakAmp Win4_PeakFreq Win4_fwhmFreqRange;
%% Aggregate features -random
features_titles = {'refno', 'MTMax', 'MTMin', 'MTDiff', 'MTMedian', 'MTMean', 'MTStd', 'MVelCoeff', 'EATDiff', 'EAARed', 'PhDMean', 'PAmpWin4', 'PFreqWin4', 'fwhmFreqRangeWin4'};
%features_titles = {'ModelThickMax', 'ModelThickMin', 'ModelThickDiff', 'ModelThickMedian', 'ModelThickMean', 'ModelThickStd', 'ModeVelCoeff', 'EnvelopeAvgTimeDiff', 'EnvelopeAvgAmpReduc', 'PhaseDiffMean', 'Win4_PeakAmp', 'Win4_PeakFreq', 'Win4_fwhmFreqRange'};
features_array_random = zeros(length(fn), length(features_titles));
% features_array_random = zeros(782, length(features_titles));
for k=1:numel(fn)
    if( isfield(data_circ_random.(fn{k}), 'sensor_data') )
        disp(['Processing done on simulation no: ', num2str(k), ', Datasetname: ', data_circ_random.(fn{k}).input_param.datasetname]);
        [ModelThickMax, ModelThickMin, ModelThickDiff, ModelThickMedian, ModelThickMean, ModelThickStd, ModeVelCoeff, EnvelopeAvgTimeDiff, EnvelopeAvgAmpReduc, PhaseDiffMean, Win4_PeakAmp, Win4_PeakFreq, Win4_fwhmFreqRange] = get_summary(data_circ_random.(fn{k}));
        features_array_random(k,:) = [k, ModelThickMax, ModelThickMin, ModelThickDiff, ModelThickMedian, ModelThickMean, ModelThickStd, ModeVelCoeff, EnvelopeAvgTimeDiff, EnvelopeAvgAmpReduc, PhaseDiffMean, Win4_PeakAmp, Win4_PeakFreq, Win4_fwhmFreqRange]; 
    end
end
features_table_random = array2table(features_array_random,'VariableNames', features_titles);
clear ModelThickMax ModelThickMin ModelThickDiff ModelThickMedian ModelThickMean ModelThickStd ModeVelCoeff EnvelopeAvgTimeDiff EnvelopeAvgAmpReduc PhaseDiffMean Win4_PeakAmp Win4_PeakFreq Win4_fwhmFreqRange;

