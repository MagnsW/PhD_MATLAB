[sensor_data_db1, model_db1] = lamb_simulate(64, 1, ones(64, 1280));%input_args = {'PlotSim', false, 'DataCast', 'single', 'PMLSize', PML_size};
[sensor_data_db2, model_db2] = lamb_simulate(64, 1, ones(64, 1280)); %input_args = {'PlotSim', false, 'DataCast', 'single'};
[sensor_data_db3, model_db3] = lamb_simulate(64, 1, ones(64, 1280)); %input_args = {'PlotSim', false, 'DataCast', 'single'};
% Properties outside the plate not set

[sensor_data_db4, model_db4] = lamb_simulate(64, 1, ones(64, 1280));
%medium.alpha_coeff_compression =0.1; % [dB/(MHz^2 cm)] (MW)
%medium.alpha_coeff_shear =0.5; % [dB/(MHz^2 cm)] (MW)
% instead of zero

[sensor_data_db5, model_db5] = lamb_simulate(64, 1, ones(64, 1280)); % using cfl
% % create the time array
% %cfl = 0.35; %
% cfl = 0.33; % (MW changed from 0.1)
% %t_end = 12.7e-6;
% %t_end = 1e-6; %(MW)
% t_end = 130e-6;
% %dt = 10e-9;
% %kgrid.setTime(int32(t_end/dt), dt);
% kgrid.makeTime(max(medium.sound_speed_compression(:)), cfl, t_end);

%input_args = {'PlotSim', false, 'DataCast', 'single'}

[sensor_data_db6, model_db6] = lamb_simulate(64, 1, ones(64, 1280)); %input_args = {'PlotSim', false, 'DataCast', 'single', 'PMLSize', 10};

[sensor_data_db7, model_db7] = lamb_simulate(64, 1, ones(64, 1280)); %t_end = 200e-6;
%input_args = {'PlotSim', false, 'DataCast', 'single', 'PMLSize', PML_size};

[sensor_data_db8, model_db8] = lamb_simulate(64, 1, ones(64, 1280)); %t_end = 200e-6;
%PML_Y_size = 15; % [gridpoints]
%input_args = {'PlotSim', false, 'DataCast', 'single', 'PMLSize', PML_size};

[sensor_data_db9, model_db9] = lamb_simulate(64, 1, ones(64, 1280)); %t_end = 200e-6;
%PML_Y_size = 20; % [gridpoints]
%input_args = {'PlotSim', false, 'DataCast', 'single', 'PMLSize', PML_size};

[sensor_data_db10, model_db10] = lamb_simulate(64, 1, ones(64, 1280)); %t_end = 200e-6;
% PML_Y_size = 40;
% source_x_pos = 11; % [grid points]
% source_radius = 25; % [grid points]
% source.u_mask = zeros(Nx, Ny);
% source.u_mask(source_x_pos, 66 - source_radius:66 + source_radius) = 1; % MW - shift source to one side

[sensor_data_db11, model_db11] = lamb_simulate(64, 1, ones(64, 1280)); %t_end = 200e-6;
% PML_Y_size = 20;
% source_x_pos = 11; % [grid points]
% source_radius = 25; % [grid points]
% source.u_mask = zeros(Nx, Ny);
% source.u_mask(source_x_pos, 66 - source_radius:66 + source_radius) = 1; % MW - shift source to one side

[sensor_data_db12, model_db12] = lamb_simulate(64, 1, ones(64, 1280));

% %PML size (perfectly matched layer)
% PML_X_size = 10; % [gridpoints]
% PML_Y_size = 80; % [gridpoints]
% PML_size = [PML_X_size, PML_Y_size];
% 
% % define source mask to be a square  piston
% source_x_pos = 11; % [grid points]
% source_radius = 24; % [grid points]
% source.u_mask = zeros(Nx, Ny);
% %source.u_mask(source_x_pos, Ny/2 - source_radius:Ny/2 + source_radius) = 1;
% source.u_mask(source_x_pos, 105 - source_radius:105 + source_radius) = 1; % MW - shift source to one side
