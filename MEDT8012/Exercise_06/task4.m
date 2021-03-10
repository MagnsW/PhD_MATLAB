%%
clear all; close all;
load('invivoData.mat')

c = 1540; %Speed of sound
z0 = 0.01;

%%
dyn = 50;
gain = -100;
figure
imagesc([], RF_t, 20*log10(abs(RFdata)));
caxis([-dyn 0]-gain);
colormap gray
xlabel('Channel number')
ylabel('Time(s)')

%%
x = linspace( -2e-2, 2e-2, 256); %x-coordinates
z = linspace( 0, 4.5e-2, 512); %z-coordinates
[X, Z] = meshgrid( x, z); %make X and Z matrices
% initialize TOF-matrix
TOF = zeros( length(z), length(x), length(elPosX) );

for k=1:length(elPosX)
    TOF(:,:,k) = sqrt((X-elPosX(k)).^2 + Z.^2)/c + Z/c;
end
%%
realigned_data = interpTOF(RFdata, RF_t, TOF);

% fnum = 1;
% 
% apod = generateApod(elPosX, 0, z, fnum);
% figure
% imagesc([], z*1000, apod')
% ylabel('Depth [mm]')

for xind = 1:length(x)
    xpos = x(xind);
    apod = generateApod(elPosX, xpos, z, fnumber);
    bf_apod_data = squeeze(sum(realigned_data(:,:,xind).*apod, 1));
end

% apod_data = realigned_data .* apod;
% bf_apod_data = squeeze(sum(apod_data));
envelope_apod_data = abs( hilbert( bf_apod_data) );

apod_data = realigned_data .* apod;
bf_apod_data = squeeze(sum(apod_data));
envelope_apod_data = abs( hilbert( bf_apod_data) );

dyn = 50;
gain = -120;
figure
imagesc(20*log10(envelope_apod_data));
caxis([-dyn 0]-gain);
colorbar
colormap gray
xlabel('x')
ylabel('z')
title(['In vivo data - Expanding aperture F# ' num2str(fnumber)])
axis equal


