% create the computational grid
PML_size = 20;
Nx = 128 - 2*PML_size;
Ny = 128 - 2*PML_size;
dx = 0.1e-3;
dy = 0.1e-3;
kgrid = makeGrid(Nx, dx, Ny, dy);

% define the properties of the propagation medium
medium.sound_speed = 1500 + (rand(Nx, Ny) - 0.5)*300;
medium.density = medium.sound_speed./1.5;

% define initial pressure distribution and binary sensor mask
p0 = zeros(Nx, Ny);
p0(Nx/4, Ny/4) = 1;
sensor_mask = zeros(Nx, Ny);
sensor_mask(3*Nx/4, 3*Ny/4) = 1;

% set simulation options
input_args = {'LogScale', true, 'DisplayMask', p0 | sensor_mask, ...
'PMLInside', false, 'PlotPML', false};

% assign the source and sensor and run the simulation
source.p0 = p0;
sensor.mask = sensor_mask;
sensor_data_12 = kspaceFirstOrder2D(kgrid, medium, source, sensor, input_args{:});

% switch the source and sensor and run the simulation again
source.p0 = sensor_mask;
sensor.mask = p0;
sensor_data_21 = kspaceFirstOrder2D(kgrid, medium, source, sensor, input_args{:});

% plot the impulse response
figure;
plot(sensor_data_12, 'k-');
hold on;
plot(sensor_data_21, 'r--');
legend('Impulse Response P1 to P2', 'Impulse Response P2 to P1');