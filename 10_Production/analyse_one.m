function result = analyse_one(data_full, input_params_backup)
% if isfield(data_full, 'input_param') % if input parameters field is populated in raw dataset
%     result.input_param = data_full.input_param;
%     disp('input params found in dataset')
% elseif isfield(input_params_backup, string(data_full))
%     result.input_param = input_params_backup.(data_full).input_param;
%     disp('input params found in backup')
% else
%     disp('input params not found')
% end
disp(inputname(1))
fn = fieldnames(input_params_backup);
for k=1:numel(fn)
    if input_params_backup.(fn{k}).input_param.datasetname == inputname(1)
        result.input_param = input_params_backup.(fn{k}).input_param;
        disp('success')
    end
end

result.data_decim.startn = 100;
result.data_decim.finishn = 1120;
result.data_decim.incrementn = 50;
result.data_decim.transradn = 24;

disp('----------Decimation start----------');
result.data_decim.sensor_data.p = decim_data(data_full.sensor_data.p, result.data_decim.startn, result.data_decim.finishn, result.data_decim.incrementn, result.data_decim.transradn);
result.data_decim.sensor_data.ux = decim_data(data_full.sensor_data.ux, result.data_decim.startn, result.data_decim.finishn, result.data_decim.incrementn, result.data_decim.transradn);
result.data_decim.sensor_data.uy = decim_data(data_full.sensor_data.uy, result.data_decim.startn, result.data_decim.finishn, result.data_decim.incrementn, result.data_decim.transradn);
result.data_decim.sensor_data.dt = data_full.sensor_data.dt;
result.data_decim.sensor_data.t_array = 0:result.data_decim.sensor_data.dt:(length(result.data_decim.sensor_data.ux)-1)*result.data_decim.sensor_data.dt;
disp('----------Compute displacement----------');
%compute displacement
result.data_decim.sensor_data.ux_displacement = cumtrapz(result.data_decim.sensor_data.t_array, result.data_decim.sensor_data.ux');

result.model = data_full.model;
result.data_decim.trace_separation = data_full.model.dy*result.data_decim.incrementn;

disp('----------Model stats----------')
result.model.stats = model_stats(result.model);

disp('-------Phase velocity estimation----------')

disp('-------Group velocity estimation---------')
disp('--------Wavelet analysis and 1D FT---------')
disp('---------AVO-------------------')
disp('---------2DFT------')

end

