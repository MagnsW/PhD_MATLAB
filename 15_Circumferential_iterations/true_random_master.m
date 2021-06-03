%%
formatSpec = '%03d';
formatSpecT = '%04d';
FileName = 'data_circumferential_random.mat';
FileNameBackup = 'X:\Magnus\PhD\Matlab_data\15_Circumferential_iterations\data_circumferential_random.mat';
circ_nodes = 1280;

thicknesses = randi([50 64], 1000,1);
% velcoeffs = (1.02-0.98).*rand(1000,1) + 0.98;
velcoeffs = randi([980 1020], 1000, 1);
pitting_depths = randi([1 12], 1000,1);
seeds = randi([3 99], 1000,1);

for n=783:1000
    fieldname = ['d' num2str(thicknesses(n), formatSpec) '_' num2str(pitting_depths(n), formatSpec) '_' num2str(seeds(n), formatSpec) '_' num2str(velcoeffs(n), formatSpecT)];
    data_circ_random.(fieldname).input_param.datasetname = (fieldname);
    data_circ_random.(fieldname).input_param.thickness = thicknesses(n);
    data_circ_random.(fieldname).input_param.velcoeff = velcoeffs(n)/1000;
    data_circ_random.(fieldname).input_param.pitting_depth = pitting_depths(n);
    data_circ_random.(fieldname).input_param.seed = seeds(n);
    data_circ_random.(fieldname).model = make_random_model(thicknesses(n), circ_nodes, pitting_depths(n), seeds(n));
    
end

%% The simulation itself and saving
fn = fieldnames(data_circ_random); 
for k=1001:numel(fn)
    disp([num2str(k) '-dataset name: ' data_circ_random.(fn{k}).input_param.datasetname]);
    [data_circ_random.(fn{k}).sensor_data, data_circ_random.(fn{k}).medium, data_circ_random.(fn{k}).dt, data_circ_random.(fn{k}).dx, data_circ_random.(fn{k}).dy] = lamb_simulate(data_circ_random.(fn{k}).input_param.thickness, data_circ_random.(fn{k}).input_param.velcoeff, data_circ_random.(fn{k}).model);
    disp('Simulation done');
    data_circ_random.(fn{k}).t_array = (1:length(data_circ_random.(fn{k}).sensor_data.ux))*data_circ_random.(fn{k}).dt;
    
    if exist(FileName, 'file')
        save(FileName, '-struct', 'data_circ_random', data_circ_random.(fn{k}).input_param.datasetname, '-append');
    else
        save(FileName, '-struct', 'data_circ_random' , data_circ_random.(fn{k}).input_param.datasetname) ;
        disp(['Creating file ' FileName]); 
    end
    
    if exist(FileNameBackup, 'file')
        save(FileNameBackup, '-struct', 'data_circ_random', data_circ_random.(fn{k}).input_param.datasetname, '-append');
    else
        save(FileNameBackup, '-struct', 'data_circ_random', data_circ_random.(fn{k}).input_param.datasetname);
        disp(['Creating file ' FileNameBackup]);
    end
    disp('Saving done');
end
%%
data_circ_random = load('data_circumferential_random.mat');
% data_circ_random_backup = load('X:\Magnus\PhD\Matlab_data\15_Circumferential_iterations\data_circumferential_random.mat');

%% Compute model stats
fn = fieldnames(data_circ_random);
for i=1:numel(fn)
    if( isfield(data_circ_random.(fn{i}), 'sensor_data') )
        disp(['Processing model stats on: ', num2str(i), ', Datasetname: ', data_circ_random.(fn{i}).input_param.datasetname])
        data_circ_random.(fn{i}).model_stats = model_stats(data_circ_random.(fn{i}).medium);
    end
end

%% Post processing
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
% features_titles = {'MTMax', 'MTMin', 'MTDiff', 'MTMedian', 'MTMean', 'MTStd', 'MVelCoeff', 'EATDiff', 'EAARed', 'PhDMean', 'PAmpWin4', 'PFreqWin4', 'fwhmFreqRangeWin4'};
features_titles = {'ModelThickMax', 'ModelThickMin', 'ModelThickDiff', 'ModelThickMedian', 'ModelThickMean', 'ModelThickStd', 'ModeVelCoeff', 'EnvelopeAvgTimeDiff', 'EnvelopeAvgAmpReduc', 'PhaseDiffMean', 'Win4_PeakAmp', 'Win4_PeakFreq', 'Win4_fwhmFreqRange'};
features_array_random = zeros(length(fn), length(features_titles));
% features_array_random = zeros(782, length(features_titles));
for k=1:numel(fn)
    if( isfield(data_circ_random.(fn{k}), 'sensor_data') )
        disp(['Processing done on simulation no: ', num2str(k), ', Datasetname: ', data_circ_random.(fn{k}).input_param.datasetname]);
        [ModelThickMax, ModelThickMin, ModelThickDiff, ModelThickMedian, ModelThickMean, ModelThickStd, ModeVelCoeff, EnvelopeAvgTimeDiff, EnvelopeAvgAmpReduc, PhaseDiffMean, Win4_PeakAmp, Win4_PeakFreq, Win4_fwhmFreqRange] = get_summary(data_circ_random.(fn{k}));
        features_array_random(k,:) = [ModelThickMax, ModelThickMin, ModelThickDiff, ModelThickMedian, ModelThickMean, ModelThickStd, ModeVelCoeff, EnvelopeAvgTimeDiff, EnvelopeAvgAmpReduc, PhaseDiffMean, Win4_PeakAmp, Win4_PeakFreq, Win4_fwhmFreqRange]; 
    end
end
features_table_random = array2table(features_array_random,'VariableNames', features_titles);
clear ModelThickMax ModelThickMin ModelThickDiff ModelThickMedian ModelThickMean ModelThickStd ModeVelCoeff EnvelopeAvgTimeDiff EnvelopeAvgAmpReduc PhaseDiffMean Win4_PeakAmp Win4_PeakFreq Win4_fwhmFreqRange;
%%
disp(fn(1))
