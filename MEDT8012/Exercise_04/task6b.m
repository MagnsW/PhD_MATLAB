%%

full = load('profile_EL_7cm_full.mat');
timescale=full.Position(4,1)+full.Ts(1)*[1:size(full.RF,1)]; %Ts= Sampling rate
speedofsound=1500;%m/s
depthscale=timescale*speedofsound*1e3;%mm
azimutpositionscale=full.Position(2,:)*1e3; %mm
subplot(2,1,1)
imagesc(azimutpositionscale,depthscale,full.RF); %Neg. pressure dark
colormap(gray);
title('Full aperture')
xlabel('elevation (mm)')
ylabel('depth (mm)')

subplot(2,1,2)
reduced = load('profile_EL_7cm_reduced.mat');
imagesc(azimutpositionscale,depthscale,reduced.RF); %Neg. pressure dark
colormap(gray);
title('Reduced aperture')
xlabel('elevation (mm)')
ylabel('depth (mm)')