tic
FileName = 'X:\Magnus\PhD\Matlab_data\09_Production\data_full.mat';
data_full_params_backup = make_input_params();
fn = fieldnames(data_full_params_backup);
for k=112:112 %numel(fn)
    full_temp = load(FileName, fn{k});
    data_decim.(fn{k}) = analyse_one(full_temp.(fn{k}), data_full_params_backup, fn{k});
    clear full_temp
end
toc