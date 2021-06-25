%%

fn = fieldnames(data_circ_random);

for jj=1:numel(fn)
    if( isfield(data_circ_random.(fn{jj}), 'sensor_data') )
        disp(['Processing done on simulation no: ', num2str(jj), ', Datasetname: ', data_circ_random.(fn{jj}).input_param.datasetname]);
        trace_temp = data_circ_random.(fn{jj}).analysis_ux.freq_analysis.decim_trace;
        hilbert_temp = abs(hilbert(trace_temp));
        xcorr_temp = xcorr(trace_temp);
        xcorr_hilbert_temp = xcorr(hilbert_temp);
        output_trace(:,jj) = trace_temp;
        output_hilbert(:,jj) = hilbert_temp;
        output_xcorr_trace(:,jj) = xcorr_temp(floor(length(xcorr_temp)/2+1):end);
        output_xcorr_hilbert(:,jj) = xcorr_hilbert_temp(floor(length(xcorr_hilbert_temp)/2+1):end);
    end
end
save('output_trace.mat', 'output_trace', '-v6'); 
save('output_hilbert.mat', 'output_hilbert', '-v6');
save('output_xcorr.mat', 'output_xcorr_trace', '-v6');
save('output_xcorr_hilbert.mat', 'output_xcorr_hilbert', '-v6');

%% Aggregate features -random
%features_titles = {'MTMax', 'MTMin', 'MTDiff', 'MTMedian', 'MTMean', 'MTStd', 'MVelCoeff'};
labels_titles = {'ModelThickMax', 'ModelThickMin', 'ModelThickDiff', 'ModelThickMedian', 'ModelThickMean', 'ModelThickStd', 'ModeVelCoeff'};
label_array_random = zeros(length(fn), length(labels_titles));
% features_array_random = zeros(782, length(features_titles));
for k=1:numel(fn)
    if( isfield(data_circ_random.(fn{k}), 'sensor_data') )
        disp(['Processing done on simulation no: ', num2str(k), ', Datasetname: ', data_circ_random.(fn{k}).input_param.datasetname]);
        [ModelThickMax, ModelThickMin, ModelThickDiff, ModelThickMedian, ModelThickMean, ModelThickStd, ModeVelCoeff, EnvelopeAvgTimeDiff, EnvelopeAvgAmpReduc, PhaseDiffMean, Win4_PeakAmp, Win4_PeakFreq, Win4_fwhmFreqRange] = get_summary(data_circ_random.(fn{k}));
        label_array_random(k,:) = [ModelThickMax, ModelThickMin, ModelThickDiff, ModelThickMedian, ModelThickMean, ModelThickStd, ModeVelCoeff]; 
    end
end
labels_table_random = array2table(label_array_random,'VariableNames', labels_titles);
clear ModelThickMax ModelThickMin ModelThickDiff ModelThickMedian ModelThickMean ModelThickStd ModeVelCoeff EnvelopeAvgTimeDiff EnvelopeAvgAmpReduc PhaseDiffMean Win4_PeakAmp Win4_PeakFreq Win4_fwhmFreqRange;

writetable(labels_table_random);