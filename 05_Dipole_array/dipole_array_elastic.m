function [sensor_data] = dipole_array_elastic(Nx_thickness)

%close all;
%clearvars;
% ====================================================================
% SIMULATION
% ====================================================================
% create the computational grid

%PML size (perfectly matched layer)
PML_X_size = 50; % [gridpoints]
PML_Y_size = 50; % [gridpoints]
PML_size = [PML_X_size, PML_Y_size];

Nx = 500; % number of grid points in the x direction
Ny = 800; % number of grid points in the y direction
dx = 0.04e-3;% grid point spacing in the x direction [m]
dy = dx; % grid point spacing in the y direction [m]

kgrid = kWaveGrid(Nx, dx, Ny, dy);
%Disc_Radius=75; % Radius for rough surface
%Bottom=76; % dx thinner plate
Bottom=Nx-1-PML_X_size-PML_Y_size-Nx_thickness
% Bottom=74; % dx thicker plate
% Bottom=75; S0
%radio= Disc_Radius;
%radio2=step-1; % Radius for Semi-sphere
%Grind=0;

velocity_coeff = Nx_thickness/324

% Medium properties
medium.sound_speed_compression = velocity_coeff*5930*ones(Nx, Ny); % [m/s]
%medium.sound_speed_shear =zeros(Nx, Ny); % [m/s]
medium.sound_speed_shear =velocity_coeff*3230*ones(Nx, Ny); %MW
medium.density =7850*ones(Nx, Ny); % [kg/m^3]

%Botom of the plate for rough surface
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
%cfl = 0.33; % (MW changed from 0.1)
%t_end = 12.7e-6;
%t_end = 1e-6; %(MW)
%kgrid.makeTime(max(medium.sound_speed_compression(:)), cfl, t_end);
dt = 2e-9;
t_end = 6e-6;
kgrid.setTime(floor(t_end/dt)+1, dt);

% define source mask to be a square piston
source_x_pos = 51; % [grid points]
source_radius = 125; % [grid points]
source.u_mask = zeros(Nx, Ny);
source.u_mask(source_x_pos, Ny/2 - source_radius:Ny/2 + source_radius) = 1;
num_source_nodes = sum(sum(source.u_mask));
%source.ux = zeros(num_source_nodes,1);
% define source to be a velocity source
source_freq = 5e6; % [Hz]
source_cycles =4;
source_mag = 0.5e-7;% [m/s]

for idx = 1:num_source_nodes
    source.ux(idx,:) = source_mag * toneBurst(1/kgrid.dt, source_freq, source_cycles);
end
for idx2 = 76:175
    source.ux(idx2,:) = -source_mag * toneBurst(1/kgrid.dt, source_freq, source_cycles);
end
%source.ux(180,:) = source_mag * toneBurst(1/kgrid.dt, source_freq/2, source_cycles*2);
%source.uy = source_mag * toneBurst(1/kgrid.dt, source_freq, source_cycles); %(MW)
% define sensor mask in x-y plane using cuboid corners.
sensor.mask = [1 + PML_X_size, 1 + PML_Y_size, Nx - PML_X_size, Ny - PML_Y_size].';

%sensor.record = {'p','p_max'};
sensor.record = {'p', 'p_max', 'u'}; %(MW)
% define a custom display mask showing the position of the interface from
% the fluid side
display_mask = false(Nx, Ny);
%display_mask(Nx/2 - 1, :) = 1;
% define input arguments
input_args = {'PlotScale', [-2, 2, -0.1, 0.1], 'DataCast', 'single',...
'PMLSize', PML_size,'DisplayMask', source.u_mask, 'RecordMovie', true, 'MovieName', 'dipole_array'};
% run the simulation with PML inside
sensor_data = pstdElastic2D(kgrid, medium, source, sensor, input_args{:});

