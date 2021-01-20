function result = analyse_one(data_full, input_params_backup, name)
% if isfield(data_full, 'input_param') % if input parameters field is populated in raw dataset
%     result.input_param = data_full.input_param;
%     disp('input params found in dataset')
% elseif isfield(input_params_backup, string(data_full))
%     result.input_param = input_params_backup.(data_full).input_param;
%     disp('input params found in backup')
% else
%     disp('input params not found')
% end
fn = fieldnames(input_params_backup);
%disp(fieldnames(data_full));
disp(name);
for k=1:numel(fn)
    if input_params_backup.(fn{k}).input_param.datasetname == name
        result.input_param = input_params_backup.(fn{k}).input_param;
        disp('input params found in backup') 
    end
end

if isfield(data_full, 'input_param') % if input parameters field is populated in raw dataset
    result.input_param = data_full.input_param;
    disp('input params found in dataset')
end

% result.data_decim.startn = 100;
result.data_decim.startn = 25;
% result.data_decim.finishn = 1120;
result.data_decim.finishn = 750; %First 13 traces
result.data_decim.incrementn = 50;
result.data_decim.transradn = 24;

% result.data_decim.startn = 1;
% result.data_decim.finishn = 1120;
% %result.data_decim.finishn = 750; %First 13 traces
% result.data_decim.incrementn = 1;
% result.data_decim.transradn = 24;


disp('----------Decimation start------------------');
result.data_decim.sensor_data.p = decim_data(data_full.sensor_data.p, result.data_decim.startn, result.data_decim.finishn, result.data_decim.incrementn, result.data_decim.transradn);
result.data_decim.sensor_data.ux = decim_data(data_full.sensor_data.ux, result.data_decim.startn, result.data_decim.finishn, result.data_decim.incrementn, result.data_decim.transradn);
result.data_decim.sensor_data.uy = decim_data(data_full.sensor_data.uy, result.data_decim.startn, result.data_decim.finishn, result.data_decim.incrementn, result.data_decim.transradn);
result.data_decim.sensor_data.dt = data_full.sensor_data.dt;
result.data_decim.sensor_data.t_array = 0:result.data_decim.sensor_data.dt:(length(result.data_decim.sensor_data.ux)-1)*result.data_decim.sensor_data.dt;
disp('----------Compute displacement--------------');
%compute displacement
result.data_decim.sensor_data.ux_displacement = cumtrapz(result.data_decim.sensor_data.t_array, result.data_decim.sensor_data.ux');
%result.data_decim.sensor_data.ux_displacement = cumtrapz(result.data_decim.sensor_data.t_array, result.data_decim.sensor_data.ux, 2);

result.model = data_full.model;
result.data_decim.trace_separation = data_full.model.dy*result.data_decim.incrementn;

disp('----------Model stats-----------------------')
result.model.stats = model_stats(result.model);

disp('----------Phase velocity estimation---------')
[result.s_sensor_data_time.p, result.s_sensor_data_time.ux, ...
    result.s_sensor_data_aligned_vph.p, result.s_sensor_data_aligned_vph.ux, ...
    result.velinfo.timeshifts.p_ph, result.velinfo.timeshifts.ux_ph, ...
    result.velinfo.p_vph, result.velinfo.ux_vph] = ...
    velestim_ph(result.data_decim.sensor_data, result.data_decim.trace_separation, result.data_decim.sensor_data.dt);

disp('----------Group velocity estimation---------')
[result.s_sensor_data_aligned_vgr.p, result.s_sensor_data_aligned_vgr.ux, ...
    result.s_hilbert.p, result.s_hilbert.ux, result.s_hilbert_aligned.p, result.s_hilbert_aligned.ux, ...
    result.velinfo.timeshifts.p_gr, result.velinfo.timeshifts.ux_gr, ...
    result.velinfo.p_vgr, result.velinfo.ux_vgr] = ...
    velestim_gr(result.data_decim.sensor_data, result.data_decim.trace_separation, result.data_decim.sensor_data.dt);

disp('---------Displacement time data-------------')
result.s_sensor_data_time.ux_displacement = s_convert(result.data_decim.sensor_data.ux_displacement, 0, result.data_decim.sensor_data.dt);

disp('----------Wavelet analysis --------')
[result.s_sensor_data_time.p, result.s_sensor_data_time.p.kurtosis]= wavelet_analysis(result.s_sensor_data_time.p);
[result.s_sensor_data_time.ux, result.s_sensor_data_time.ux.kurtosis]= wavelet_analysis(result.s_sensor_data_time.ux);
[result.s_sensor_data_time.ux_displacement, result.s_sensor_data_time.ux_displacement.kurtosis]= wavelet_analysis(result.s_sensor_data_time.ux_displacement);

[result.s_hilbert.p, result.s_hilbert.p.kurtosis]= wavelet_analysis(result.s_hilbert.p);
[result.s_hilbert.ux, result.s_hilbert.ux.kurtosis]= wavelet_analysis(result.s_hilbert.ux);

%commment from here if no decimation

disp('----------AVO-------------------------------')

disp('----------1DFT------------------------------')
disp('------------resampling----------------------')
Fs = 1e-6; % new sampling frequency
result.s_sensor_data_time_resampled.p = s_resample(result.s_sensor_data_time.p, Fs);
result.s_sensor_data_time_resampled.ux = s_resample(result.s_sensor_data_time.ux, Fs);
result.s_sensor_data_time_resampled.ux_displacement = s_resample(result.s_sensor_data_time.ux_displacement, Fs);

[result.sensor_data_ft.p, result.sensor_data_ft.p_db, result.sensor_data_ft.f] = onedft(result.s_sensor_data_time_resampled.p);
[result.sensor_data_ft.ux, result.sensor_data_ft.ux_db, result.sensor_data_ft.f] = onedft(result.s_sensor_data_time_resampled.ux);
[result.sensor_data_ft.ux_displacement, result.sensor_data_ft.ux_displacement_db, result.sensor_data_ft.f] = onedft(result.s_sensor_data_time_resampled.ux_displacement);

disp('----------2DFT------------------------------')
[result.fft.fft_p, result.fft.fftdb_p, result.fft.k, result.fft.f] = twodft(result.s_sensor_data_time_resampled.p, result.data_decim.trace_separation);
[result.fft.fft_ux, result.fft.fftdb_ux, result.fft.k, result.fft.f] = twodft(result.s_sensor_data_time_resampled.ux, result.data_decim.trace_separation);
[result.fft.fft_ux_displacement, result.fft.fftdb_ux_displacement, result.fft.k, result.fft.f] = twodft(result.s_sensor_data_time_resampled.ux_displacement, result.data_decim.trace_separation);
end

