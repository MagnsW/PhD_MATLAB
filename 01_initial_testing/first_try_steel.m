% create the computational grid
Nx = 128; % number of grid points in the x (row) direction
Ny = 512; % number of grid points in the y (column) direction
dx = 50e-5; % grid point spacing in the x direction [m]
dy = 50e-5; % grid point spacing in the y direction [m]
kgrid = makeGrid(Nx, dx, Ny, dy);

% define the medium properties
medium.sound_speed = 1500*ones(Nx, Ny); % [m/s]
medium.sound_speed(1:100, :) = 5850; % [m/s]
medium.density = 1040*ones(Nx, Ny); % [kg/m^3]
medium.density(1:100, :) = 7800; % [kg/m^3]

% define an initial pressure using makeDisc
disc_x_pos = 20; % [grid points]
disc_y_pos = 128; % [grid points]
disc_radius = 8; % [grid points]
disc_mag = 3; % [Pa]
source.p0 = disc_mag*makeDisc(Nx, Ny, disc_x_pos, disc_y_pos, disc_radius);

% define a 2D binary sensor mask in the shape of a line
x_offset = 20; % [grid points]
%width = 50; % [grid points]
sensor.mask = zeros(Nx, Ny);
%sensor.mask(x_offset, Ny/2 - width/2 + 1:Ny/2 + width/2) = 1;
sensor.mask(x_offset, linspace(11, 511, 11)) = 1;

kgrid.t_array = 0:2e-8:4e-5

%% run the simulation
sensor_data = kspaceFirstOrder2D(kgrid, medium, source, sensor);

%% plotting
mesh(kgrid.t_array, dy*linspace(11, 511, 11), sensor_data)
view(90,90)
