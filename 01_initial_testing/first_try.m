
% create the computational grid
Nx = 128; % number of grid points in the x (row) direction
Ny = 256; % number of grid points in the y (column) direction
dx = 50e-6; % grid point spacing in the x direction [m]
dy = 50e-6; % grid point spacing in the y direction [m]
kgrid = makeGrid(Nx, dx, Ny, dy);

% define the medium properties
medium.sound_speed = 1500*ones(Nx, Ny); % [m/s]
medium.sound_speed(1:50, :) = 1800; % [m/s]
medium.density = 1040; % [kg/m^3]

% define an initial pressure using makeDisc
disc_x_pos = 75; % [grid points]
disc_y_pos = 120; % [grid points]
disc_radius = 8; % [grid points]
disc_mag = 3; % [Pa]
source.p0 = disc_mag*makeDisc(Nx, Ny, disc_x_pos, disc_y_pos, disc_radius);

%% Define sensor mask
% define a Cartesian sensor mask of a centered circle with 50 sensor elements
sensor_radius = 2.5e-3; % [m]
num_sensor_points = 50;
sensor.mask = makeCartCircle(sensor_radius, num_sensor_points);


% define a 2D binary sensor mask in the shape of a line
x_offset = 25; % [grid points]
width = 50; % [grid points]
sensor.mask = zeros(Nx, Ny);
sensor.mask(x_offset, Ny/2 - width/2 + 1:Ny/2 + width/2) = 1;

%% run the simulation
sensor_data = kspaceFirstOrder2D(kgrid, medium, source, sensor);