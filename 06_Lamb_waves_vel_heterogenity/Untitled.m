testmodel = medium.sound_speed_compression;
dv_dx = linspace(62/64, 66/64, Nx_thickness);
testmodel(PML_X_size+1:Nx-PML_X_size-Bottom-1,:) = dv_dx'.*testmodel(PML_X_size+1:Nx-PML_X_size-Bottom-1,:);
testmodel(PML_X_size+1:Nx-PML_X_size-Bottom-1,:) = flip(dv_dx').*testmodel(PML_X_size+1:Nx-PML_X_size-Bottom-1,:);

dv_dy = linspace(62/64, 66/64, Ny);
