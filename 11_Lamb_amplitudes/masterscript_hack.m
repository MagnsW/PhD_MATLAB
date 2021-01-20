tic
FileName = 'X:\Magnus\PhD\Matlab_data\09_Production\data_full.mat';
data_full_params_backup = make_input_params();
% fn = fieldnames(data_full_params_backup);
fn = [{'d064_000_000_100'} {'d064_012_000_100'} {'d061_000_000_100'} {'d061_012_000_100'}]';
for k=1:numel(fn)
    full_temp = load(FileName, fn{k});
    data_analyzed_avg_decim_ft_nfft.(fn{k}) = analyse_one(full_temp.(fn{k}), data_full_params_backup, fn{k});
    clear full_temp
end
toc