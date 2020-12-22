function [data_full, data_decim] = model_and_process(Nx, pittingdepth, seed)
%MODEL_AND_PROCESS Summary of this function goes here
%   Detailed explanation goes here
velcoeff = 1;
[data_full.sensor_data, data_full.model, data_full.sensor_data.dt, data_full.model.dx, ...
    data_full.model.dy] = lamb_simulate(Nx, velcoeff, make_random_model(Nx, 1280, pittingdepth, seed));
[data_full.model.stats.thickness, data_full.model.stats.pVel, data_full.model.stats.sVel] = ...
    model_stats(data_full.model);

startn = 100;
finishn = 1120;
incrementn = 50;
transradn = 48;

data_decim.sensor_data.p = decim_data(data_full.sensor_data.p, startn, finishn, incrementn, transradn);
data_decim.sensor_data.ux = decim_data(data_full.sensor_data.ux, startn, finishn, incrementn, transradn);
data_decim.sensor_data.uy = decim_data(data_full.sensor_data.uy, startn, finishn, incrementn, transradn);
data_decim.sensor_data.dt = data_full.sensor_data.dt;

data_decim.model = data_full.model;
data_decim.model.dy = data_full.model.dy*incrementn;

%velocity analysis on data_decim
[data_decim.sensor_data_aligned_vph.p, data_decim.sensor_data_aligned_vph.ux, ...
    data_decim.velinfo.timeshifts.p_ph, data_decim.velinfo.timeshifts.ux_ph, ...
    data_decim.velinfo.p_vph, data_decim.velinfo.ux_vph] = ...
    velestim_ph(data_decim.sensor_data, data_decim.model.dy, data_decim.sensor_data.dt);

[data_decim.sensor_data_aligned_vgr.p, data_decim.sensor_data_aligned_vgr.ux, ...
    data_decim.velinfo.timeshifts.p_gr, data_decim.velinfo.timeshifts.ux_gr, ...
    data_decim.velinfo.p_vgr, data_decim.velinfo.ux_vgr] = ...
    velestim_gr(data_decim.sensor_data, data_decim.model.dy, data_decim.sensor_data.dt);


end

