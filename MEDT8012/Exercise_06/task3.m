%%
apod = generateApod(elPosX, 0, z, 1);
figure
imagesc([], z*1000, apod')
ylabel('Depth [mm]')

apod_data = realigned_data .* apod;
bf_apod_data = squeeze(sum(apod_data));
envelope_apod_data = abs( hilbert( bf_apod_data) );

dyn = 50;
gain = -110;
figure
imagesc(20*log10(envelope_apod_data));
caxis([-dyn 0]-gain);
colorbar
colormap gray
xlabel('x')
ylabel('z')
title('Expanding aperture')
