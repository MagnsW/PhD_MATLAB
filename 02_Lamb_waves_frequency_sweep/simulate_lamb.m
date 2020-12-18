close all;
clearvars;
% ====================================================================
% SIMULATION
% ====================================================================
% create the computational grid

%PML size (perfectly matched layer)
PML_X_size = 10; % [gridpoints]
PML_Y_size = 10; % [gridpoints]
PML_size = [PML_X_size, PML_Y_size];

Nx = 100; % number of grid points in the x direction
Ny = 1280; % number of grid points in the y direction
dx = 0.2e-3;% grid point spacing in the x direction [m]
dy = dx; % grid point spacing in the y direction [m]

kgrid = kWaveGrid(Nx, dx, Ny, dy);
%Disc_Radius=75; % Radius for rough surface
Bottom=15;
%radio= Disc_Radius;
%radio2=step-1; % Radius for Semi-sphere
%Grind=0;

% Medium properties
medium.sound_speed_compression = 5930*ones(Nx, Ny); % [m/s]
%medium.sound_speed_shear =zeros(Nx, Ny); % [m/s]
medium.sound_speed_shear =3230*ones(Nx, Ny); %MW
medium.density =7850*ones(Nx, Ny); % [kg/m^3]

%Bottom of the plate for rough surface
medium.sound_speed_compression(Nx-PML_X_size-Bottom:end, :) =343; % [m/s]
medium.sound_speed_shear(Nx-PML_X_size-Bottom:end, :) = 0;
medium.density(Nx-PML_X_size-Bottom:end, :) =120; % [kg/m^3] % I have multiplied air density by 100

%Top of the plate
medium.sound_speed_compression(1:PML_X_size, :) = 343; % [m/s]
medium.sound_speed_shear(1:PML_X_size, :) = 0;% [m/s]
medium.density(1:PML_X_size, :) = 120;% [kg/m^3] % I have multiplied air density by 100

% define the absorption properties
medium.alpha_coeff_compression =0;%0.1; % [dB/(MHz^2 cm)]
medium.alpha_coeff_shear =0;% 0.5; % [dB/(MHz^2 cm)]
%medium.alpha_coeff_compression =0.1; % [dB/(MHz^2 cm)] (MW)
%medium.alpha_coeff_shear =0.5; % [dB/(MHz^2 cm)] (MW)


% create the time array
%cfl = 0.35; %
cfl = 0.33; % (MW changed from 0.1)
%t_end = 12.7e-5;
t_end = 25e-5; %(MW)
kgrid.makeTime(max(medium.sound_speed_compression(:)), cfl, t_end);

%MW: load source pulse
load('test_source.dat');
test_source = zeros(length(test_source),1);
test_source(5000) = 1;
% define source mask to be a square piston
source_x_pos = 11; % [grid points]
source_radius = 25; % [grid points]
source.u_mask = zeros(Nx, Ny);
%source.u_mask(source_x_pos, Ny/2 - source_radius:Ny/2 + source_radius) = 1;
source.u_mask(source_x_pos, 40 - source_radius:40 + source_radius) = 1; % MW - shift source to one side
% define source to be a velocity source
%source_freq = 0.5e5 ; % [Hz]
%source_cycles =8;
source_mag = 0.5e-7;% [m/s]
%source.ux = source_mag * toneBurst(1/kgrid.dt, source_freq, source_cycles);
source.ux = source_mag * test_source';
%source.uy = source_mag * toneBurst(1/kgrid.dt, source_freq, source_cycles); %(MW)
% define sensor mask in x-y plane using cuboid corners.
%sensor.mask = [1 + PML_X_size, 1 + PML_Y_size, Nx - PML_X_size, Ny - PML_Y_size].';
sensor.mask = [1 + PML_X_size, 1 + PML_Y_size, 1 + PML_X_size, Ny - PML_Y_size].'; % MW - only sensors at top

%sensor.record = {'p','p_max'};
sensor.record = {'p', 'p_max', 'u'}; %(MW)
% define a custom display mask showing the position of the interface from
% the fluid side
display_mask = false(Nx, Ny);
%display_mask(Nx/2 - 1, :) = 1;
% define input arguments
input_args = {'PlotScale', [-2, 2, -0.1, 0.1], 'DataCast', 'single',...
'PMLSize', PML_size,'DisplayMask', source.u_mask, 'RecordMovie', true, 'MovieName', 'example_movie'};
% run the simulation with PML inside
sensor_data = pstdElastic2D(kgrid, medium, source, sensor, input_args{:});
