function [sensor_data, medium, dt, dx, dy] = lamb_simulate(Nx_thickness, velcoeff, platemodel)
%LAMB_SIMULATE_VELCHANGE Summary of this function goes here
%   Detailed explanation goes here
% ====================================================================
% SIMULATION
% ====================================================================
% create the computational grid

%PML size (perfectly matched layer)
PML_X_size = 10; % [gridpoints]
PML_Y_size = 80; % [gridpoints]
PML_size = [PML_X_size, PML_Y_size];

Nx = 100; % number of grid points in the x direction
Ny = 1280; % number of grid points in the y direction
dx = 0.2e-3;% grid point spacing in the x direction [m]
dy = dx; % grid point spacing in the y direction [m]

kgrid = kWaveGrid(Nx, dx, Ny, dy);

%Bottom=15; Nominal
Bottom=Nx-1-PML_X_size-PML_X_size-Nx_thickness;

model_template = zeros(Nx, Ny);
model_template(PML_X_size+1:Nx-PML_X_size-Bottom-1,:)= platemodel;


%velocity_coeff = Nx_thickness/64
velocity_coeff = velcoeff;

% Medium properties
medium.sound_speed_compression = velocity_coeff*5930*model_template; % [m/s]
%medium.sound_speed_shear =zeros(Nx, Ny); % [m/s]
medium.sound_speed_shear =velocity_coeff*3230*model_template; %MW
medium.density =7850*model_template; % [kg/m^3]

% %Bottom of the plate for rough surface
% medium.sound_speed_compression(Nx-PML_X_size-Bottom:end, :) =343; % [m/s]
% medium.sound_speed_shear(Nx-PML_X_size-Bottom:end, :) = 0;
% medium.density(Nx-PML_X_size-Bottom:end, :) =120; % [kg/m^3] % I have multiplied air density by 100
% 
% %Top of the plate
% medium.sound_speed_compression(1:PML_X_size, :) = 343; % [m/s]
% medium.sound_speed_shear(1:PML_X_size, :) = 0;% [m/s]
% medium.density(1:PML_X_size, :) = 120;% [kg/m^3] % I have multiplied air density by 100

%Outside the plate
medium.sound_speed_compression(medium.sound_speed_compression == 0) = 343; % [m/s]
medium.sound_speed_shear(medium.sound_speed_shear == 0) = 0;
medium.density(medium.density == 0) = 120; % [kg/m^3] % I have multiplied air density by 100
 

% define the absorption properties
medium.alpha_coeff_compression =0;%0.1; % [dB/(MHz^2 cm)]
medium.alpha_coeff_shear =0;% 0.5; % [dB/(MHz^2 cm)]
% medium.alpha_coeff_compression =0.1; % [dB/(MHz^2 cm)] (MW)
% medium.alpha_coeff_shear =0.5; % [dB/(MHz^2 cm)] (MW)

% Multiply with platemodel


% Apply gradient in thickness direction:
% dv_dx = linspace(62/64, 66/64, Nx_thickness);
% dv_dx = flip(dv_dx);
% medium.sound_speed_compression(PML_X_size+1:Nx-PML_X_size-Bottom-1,:) = dv_dx'.*medium.sound_speed_compression(PML_X_size+1:Nx-PML_X_size-Bottom-1,:);
% medium.sound_speed_shear(PML_X_size+1:Nx-PML_X_size-Bottom-1,:) = dv_dx'.*medium.sound_speed_shear(PML_X_size+1:Nx-PML_X_size-Bottom-1,:);
% 
% % Apply gradient in lateral direction:
% dv_dy = linspace(62/64, 66/64, Ny);
% dv_dy = flip(dv_dy);
% medium.sound_speed_compression(PML_X_size+1:Nx-PML_X_size-Bottom-1,:) = dv_dy.*medium.sound_speed_compression(PML_X_size+1:Nx-PML_X_size-Bottom-1,:);
% medium.sound_speed_shear(PML_X_size+1:Nx-PML_X_size-Bottom-1,:) = dv_dy.*medium.sound_speed_shear(PML_X_size+1:Nx-PML_X_size-Bottom-1,:);

% create the time array
%cfl = 0.35; %
%cfl = 0.33; % (MW changed from 0.1)
%t_end = 12.7e-6;
%t_end = 1e-6; %(MW)
%t_end = 130e-6;
t_end = 150e-6;
dt = 10e-9;
kgrid.setTime(int32(t_end/dt), dt);
%kgrid.makeTime(max(medium.sound_speed_compression(:)), cfl, t_end);



% define source mask to be a square  piston
source_x_pos = 11; % [grid points]
source_radius = 24; % [grid points]
source.u_mask = zeros(Nx, Ny);
%source.u_mask(source_x_pos, Ny/2 - source_radius:Ny/2 + source_radius) = 1;
source.u_mask(source_x_pos, 105 - source_radius:105 + source_radius) = 1; % MW - shift source to one side
% define source to be a velocity source
source_freq = 5e4 ; % [Hz]
%source_freq = freq;
source_cycles = 4;
source_mag = 0.5e-7;% [m/s]
source.ux = source_mag * toneBurst(1/kgrid.dt, source_freq, source_cycles);
%source.uy = source_mag * toneBurst(1/kgrid.dt, source_freq, source_cycles); %(MW)
% define sensor mask in x-y plane using cuboid corners.
%sensor.mask = [1 + PML_X_size, 1 + PML_Y_size, Nx - PML_X_size, Ny - PML_Y_size].';
sensor.mask = [1 + PML_X_size, 1 + PML_Y_size, 1 + PML_X_size, Ny - PML_Y_size].'; % MW - only sensors at top

sensor.record = {'p', 'p_max', 'u'}; %(MW)
% define a custom display mask showing the position of the interface from
% the fluid side
display_mask = false(Nx, Ny);
%display_mask(Nx/2 - 1, :) = 1;
% define input arguments
% input_args = {'PlotScale', [-2, 2, -0.1, 0.1], 'DataCast', 'single',...
% 'PMLSize', PML_size,'DisplayMask', source.u_mask, 'RecordMovie', false, 'MovieName', 'example_movie'};
% input_args = {'PlotScale', 'auto', 'DataCast', 'single',...
% 'PMLSize', PML_size,'DisplayMask', source.u_mask, 'RecordMovie', false, 'MovieName', 'example_movie'};
%input_args = {'PlotSim', false, 'DataCast', 'single'}; % rerun3
input_args = {'PlotSim', false, 'DataCast', 'single', 'PMLSize', PML_size}; % rerun4
%input_args = {'PlotSim', false, 'DataCast', 'single', 'PMLSize', 10}; % rerun5

% run the simulation with PML inside
sensor_data = pstdElastic2D(kgrid, medium, source, sensor, input_args{:});

end

