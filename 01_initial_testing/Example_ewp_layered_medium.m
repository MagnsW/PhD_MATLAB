% create the computational grid
Nx = 128;           % number of grid points in the x (row) direction
Ny = 128;           % number of grid points in the y (column) direction
dx = 0.1e-3;        % grid point spacing in the x direction [m]
dy = 0.1e-3;        % grid point spacing in the y direction [m]
kgrid = kWaveGrid(Nx, dx, Ny, dy);

% define the properties of the upper layer of the propagation medium
medium.sound_speed_compression = 1500 * ones(Nx, Ny);   % [m/s]
medium.sound_speed_shear       = zeros(Nx, Ny);         % [m/s]
medium.density                 = 1000 * ones(Nx, Ny);   % [kg/m^3]

% define the properties of the lower layer of the propagation medium
medium.sound_speed_compression(Nx/2:end, :) = 2000;     % [m/s]
medium.sound_speed_shear(Nx/2:end, :)       = 800;      % [m/s]
medium.density(Nx/2:end, :)                 = 1200;     % [kg/m^3]

% define the absorption properties
medium.alpha_coeff_compression = 0.1;   % [dB/(MHz^2 cm)]
medium.alpha_coeff_shear       = 0.5;   % [dB/(MHz^2 cm)]

% create initial pressure distribution using makeDisc
disc_magnitude = 5; % [Pa]
disc_x_pos = 30;    % [grid points]
disc_y_pos = 64;    % [grid points]
disc_radius = 5;    % [grid points]
source.p0 = disc_magnitude * makeDisc(Nx, Ny, disc_x_pos, disc_y_pos, disc_radius);

% define a centered circular sensor
sensor_radius = 4e-3;   % [m]
num_sensor_points = 50;
sensor.mask = makeCartCircle(sensor_radius, num_sensor_points);

% create the time array
cfl   = 0.1;    % Courant-Friedrichs-Lewy number
t_end = 8e-6;   % [s]
kgrid.makeTime(max(medium.sound_speed_compression(:)), cfl, t_end);

% define input arguments
input_args = {'PlotScale', [-0.75, 0.75, -0.15, 0.15], 'PlotPML', false,...
     'DataCast', 'single'};

% run the simulation
sensor_data = pstdElastic2D(kgrid, medium, source, sensor, input_args{:});
