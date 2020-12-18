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

% create initial pressure distribution using makeDisc
disc_magnitude = 5; % [Pa]
disc_x_pos = 50;    % [grid points]
disc_y_pos = 50;    % [grid points]
disc_radius = 8;    % [grid points]
disc_1 = disc_magnitude * makeDisc(Nx, Ny, disc_x_pos, disc_y_pos, disc_radius);

disc_magnitude = 3; % [Pa]
disc_x_pos = 80;    % [grid points]
disc_y_pos = 60;    % [grid points]
disc_radius = 5;    % [grid points]
disc_2 = disc_magnitude * makeDisc(Nx, Ny, disc_x_pos, disc_y_pos, disc_radius);

source.p0 = disc_1 + disc_2;

% define a centered circular sensor
sensor_radius = 4e-3;   % [m]
num_sensor_points = 50;
sensor.mask = makeCartCircle(sensor_radius, num_sensor_points);

% run the simulation
sensor_data = kspaceFirstOrder2D(kgrid, medium, source, sensor);