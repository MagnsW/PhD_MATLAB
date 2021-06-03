% ====================================================================
% 2D ULTRASONIC SIMULATION IN SOLID COMPONENT
% CIRCULAR TRANSDUCER
% ====================================================================
close all;
clearvars;
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
for step=1:26; % Semi-sphere hole step
kgrid = kWaveGrid(Nx, dx, Ny, dy);
Disc_Radius=75; % Radius for rough surface
Bottom=75;
radio= Disc_Radius;
radio2=step-1; % Radius for Semi-sphere
Grind=0;
% Medium properties
medium.sound_speed_compression = 5930*ones(Nx, Ny); % [m/s]
medium.sound_speed_shear =zeros(Nx, Ny); % [m/s]
medium.density =7850*ones(Nx, Ny); % [kg/m^3]
%Botom of the plate for rough surface
medium.sound_speed_compression(Nx-PML_X_size-Bottom:end, :) =343; % [m/s]
medium.sound_speed_shear(Nx-PML_X_size-Bottom:end, :) = 0;
medium.density(Nx-PML_X_size-Bottom:end, :) =120; % [kg/m^3] % I have multiplied air density by 100
% Botom shape of rough surface
for n=1:5
%disc left
disc_L= makeDisc(Nx,Ny,Nx-PML_X_size-Bottom, (Ny/2)-1*(n-1)*Disc_Radius,radio); % Disc position, radius
%disc right
disc_R= makeDisc(Nx,Ny,Nx-PML_X_size-Bottom, (Ny/2)+1*(n-1)*Disc_Radius,radio); % Disc position, radius
% Medium properties for disc left
medium.sound_speed_compression(disc_L==1) =5930; % [m/s]
medium.sound_speed_shear(disc_L==1) = 0; % [m/s]
medium.density(disc_L==1) =7850; % [kg/m^
% Medium properties for disc right
medium.sound_speed_compression(disc_R==1) =5930; % [m/s]
medium.sound_speed_shear(disc_R==1) = 0; % [m/s]
medium.density(disc_R==1) =7850; % [kg/m^
end
% Semi-shpere on rough surface.
for n=1:1 %
%disc left
disc_L= makeDisc(Nx,Ny,Nx-PML_X_size, (Ny/2)-1*(n-1)*round(Disc_Radius/2),radio2); % Disc position, radius
%disc right
% disc_R= makeDisc(Nx,Ny,Nx-PML_X_size, (Ny/2)-1*(n-1)*round(Disc_Radius/2),radio2); % Disc position, radius
% Medium properties for left
medium.sound_speed_compression(disc_L==1) =343; % [m/s]
medium.sound_speed_shear(disc_L==1) = 0; % [m/s]
medium.density(disc_L==1) =120; % [kg/m]
% Medium properties for disc right
%medium.sound_speed_compression(disc_R==1) =343; % [m/s]
%medium.sound_speed_shear(disc_R==1) = 0; % [m/s]
%medium.density(disc_R==1) =120; % [kg/m^
end
%Grinding from the Botom of the plate for gorgon
medium.sound_speed_compression(Nx-PML_X_size-Grind:end, :) = 343; % [m/s]
medium.sound_speed_shear(Nx-PML_X_size-Grind:end, :) = 0; % [m/s]
medium.density(Nx-PML_X_size-Grind:end, :) = 120; % [kg/m^3] % I have multiplied air density by 100
%Botom of the plate for reflection
medium.sound_speed_compression(Nx-PML_X_size:end, :) = 343; % [m/s]
medium.sound_speed_shear(Nx-PML_X_size:end, :) = 0; % [m/s]
medium.density(Nx-PML_X_size:end, :) = 120; % [kg/m^3] % I have multiplied air density by 100
%Top of the plate
medium.sound_speed_compression(1:PML_X_size, :) = 343; % [m/s]
medium.sound_speed_shear(1:PML_X_size, :) = 0;% [m/s]
medium.density(1:PML_X_size, :) = 120;% [kg/m^3] % I have multiplied air density by 100
% define the absorption properties
medium.alpha_coeff_compression =0;%0.1; % [dB/(MHz^2 cm)]
medium.alpha_coeff_shear =0;% 0.5; % [dB/(MHz^2 cm)]
% create the time array
cfl = 0.35; %
t_end = 12.7e-6;
kgrid.makeTime(max(medium.sound_speed_compression(:)), cfl, t_end);
% define source mask to be a square piston
source_x_pos = 51; % [grid points]
source_radius = 125; % [grid points]
source.u_mask = zeros(Nx, Ny);
source.u_mask(source_x_pos, Ny/2 - source_radius:Ny/2 + source_radius) = 1;
% define source to be a velocity source
source_freq = 5e6; % [Hz]
source_cycles =4;
source_mag = 0.5e-7;% [m/s]
source.ux = source_mag * toneBurst(1/kgrid.dt, source_freq, source_cycles);
% define sensor mask in x-y plane using cuboid corners.
sensor.mask = [1 + PML_X_size, 1 + PML_Y_size, Nx - PML_X_size, Ny - PML_Y_size].';
% record p and p_max maximum pressure in the plane
sensor.record = {'p','p_max'};
% define a custom display mask showing the position of the interface from
% the fluid side
display_mask = false(Nx, Ny);
%display_mask(Nx/2 - 1, :) = 1;
% define input arguments
input_args = {'PlotScale', [-2, 2, -0.1, 0.1], 'DataCast', 'single',...
'PMLSize', PML_size,'DisplayMask', source.u_mask};
% run the simulation with PML inside
sensor_data = pstdElastic2D(kgrid, medium, source, sensor, input_args{:});
wfms_Full(:,step)=squeeze(mean(sensor_data.p(2,((Ny-2*PML_Y_size)/2)-(source_radius-2):((Ny-2*PML_Y_size)/2)+(source_radius-2),:)));
step
end