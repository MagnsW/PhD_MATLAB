function [data_full, data_decim] = model_and_process(Nx, pittingdepth, seed)
%MODEL_AND_PROCESS Summary of this function goes here
%   Detailed explanation goes here
disp('----------Simulation start----------');
velcoeff = 1;
[data_full.sensor_data, data_full.model, data_full.sensor_data.dt, data_full.model.dx, ...
    data_full.model.dy] = lamb_simulate(Nx, velcoeff, make_random_model(Nx, 1280, pittingdepth, seed));
[data_full.model.stats.thickness, data_full.model.stats.pVel, data_full.model.stats.sVel] = ...
    model_stats(data_full.model);
disp('----------Simulation complete----------');
%define some decimation parameters. First trace, last trace, separation and
%transducer radius. In dy units
startn = 100;
finishn = 1120;
incrementn = 50;
transradn = 24;
disp('----------Decimation start----------');
data_decim.sensor_data.p = decim_data(data_full.sensor_data.p, startn, finishn, incrementn, transradn);
data_decim.sensor_data.ux = decim_data(data_full.sensor_data.ux, startn, finishn, incrementn, transradn);
data_decim.sensor_data.uy = decim_data(data_full.sensor_data.uy, startn, finishn, incrementn, transradn);
data_decim.sensor_data.dt = data_full.sensor_data.dt;
data_decim.sensor_data.t_array = 0:data_decim.sensor_data.dt:(length(data_decim.sensor_data.ux)-1)*data_decim.sensor_data.dt;
disp('----------Compute displacement----------');
%compute displacement
data_decim.sensor_data.ux_displacement = cumtrapz(data_decim.sensor_data.t_array, data_decim.sensor_data.ux');

data_decim.model = data_full.model;
data_decim.model.dy = data_full.model.dy*incrementn;

%velocity analysis on data_decim
disp('----------Velocity analysis start----------');
[data_decim.sensor_data_time.p, data_decim.sensor_data_time.ux, ...
    data_decim.sensor_data_aligned_vph.p, data_decim.sensor_data_aligned_vph.ux, ...
    data_decim.velinfo.timeshifts.p_ph, data_decim.velinfo.timeshifts.ux_ph, ...
    data_decim.velinfo.p_vph, data_decim.velinfo.ux_vph] = ...
    velestim_ph(data_decim.sensor_data, data_decim.model.dy, data_decim.sensor_data.dt);

[data_decim.sensor_data_aligned_vgr.p, data_decim.sensor_data_aligned_vgr.ux, ...
    data_decim.velinfo.timeshifts.p_gr, data_decim.velinfo.timeshifts.ux_gr, ...
    data_decim.velinfo.p_vgr, data_decim.velinfo.ux_vgr] = ...
    velestim_gr(data_decim.sensor_data, data_decim.model.dy, data_decim.sensor_data.dt);
disp('----------Velocity analysis complete----------');

%fft calculations
dimensions = size(data_decim.sensor_data.p');
dy = data_decim.model.dy;
dt = data_decim.sensor_data.dt;
Nyq_k = 1/(2*dy); % Nyquist of data in first dimension
Nyq_f = 1/(2*dt); % Nyquist of data in second dimension
dk = 1/(dimensions(2)*dy);   % Wavenumber increment
df = 1/(dimensions(1)*dt);   % Frequency increment

data_decim.fft.k = -Nyq_k : dk : Nyq_k-dk; % wavenumber
data_decim.fft.f = -Nyq_f : df : Nyq_f-df; % frequency
%fft p component
data_decim.fft.fft_p = fftshift(fft2(data_decim.sensor_data.p'))*dy*dt;
data_decim.fft.fftdb_p = 20*log10(abs(data_decim.fft.fft_p)/max(abs(data_decim.fft.fft_p(:))));
%fft ux component
data_decim.fft.fft_ux = fftshift(fft2(data_decim.sensor_data.ux'))*dy*dt;
data_decim.fft.fftdb_ux = 20*log10(abs(data_decim.fft.fft_ux)/max(abs(data_decim.fft.fft_ux(:))));
%fft ux displacement component
data_decim.fft.fft_ux_displacement = fftshift(fft2(data_decim.sensor_data.ux_displacement))*dy*dt;
data_decim.fft.fftdb_ux_displacement = 20*log10(abs(data_decim.fft.fft_ux_displacement)/max(abs(data_decim.fft.fft_ux_displacement(:))));

end

