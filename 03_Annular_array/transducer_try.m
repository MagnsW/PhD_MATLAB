clear;

% create the computational grid
Nx = 128;           % number of grid points in the x (row) direction
Ny = 128;           % number of grid points in the y (column) direction
dx = 0.1e-3;        % grid point spacing in the x direction [m]
dy = 0.1e-3;        % grid point spacing in the y direction [m]
kgrid = kWaveGrid(Nx, dx, Ny, dy);

% define the properties of the propagation medium
medium.sound_speed = 1500;  % [m/s]
medium.alpha_coeff = 0.75;  % [dB/(MHz^y cm)]
medium.alpha_power = 1.5;

%medium.sound_speed_compression = 5930*ones(Nx, Ny); % [m/s]
%medium.sound_speed_shear =zeros(Nx, Ny); % [m/s]
%medium.sound_speed_shear =3230*ones(Nx, Ny); %MW
%medium.density =7850*ones(Nx, Ny); % [kg/m^3]


% define a curved transducer element
arc_pos = [20, 20];         % [grid points]  
radius = 60;                % [grid points]
diameter = 81;              % [grid points]
focus_pos = [Nx/2, Nx/2];   % [grid points]
source.p_mask = makeArc([Nx, Ny], arc_pos, radius, diameter, focus_pos);

% create time array
t_end = 6e-6;       % [s]
cfl = 0.33;
kgrid.makeTime(medium.sound_speed(:), cfl, t_end);

% define a time varying sinusoidal source
source_freq = 0.25e6;       % [Hz]
source_mag = 0.5;           % [Pa]
source.p = source_mag * sin(2 * pi * source_freq * kgrid.t_array);

% filter the source to remove any high frequencies not supported by the grid
source.p = filterTimeSeries(kgrid, medium, source.p);


% create a sensor mask covering the entire computational domain using the
% opposing corners of a rectangle
sensor.mask = [1, 1, Nx, Ny].';

% set the record mode to capture the final wave-field and the statistics at
% each sensor point
sensor.record = {'p_final', 'p_max', 'p_rms'};

% create a display mask to display the transducer
display_mask = source.p_mask;

% assign the input options
input_args = {'DisplayMask', display_mask, 'PMLInside', false, 'PlotPML', false};

% run the simulation
sensor_data = kspaceFirstOrder2D(kgrid, medium, source, sensor, input_args{:});
%sensor_data = pstdElastic2D(kgrid, medium, source, sensor, input_args{:});