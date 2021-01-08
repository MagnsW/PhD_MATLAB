function plot_fft(dataset, titletext)
figure
imagesc(dataset.fft.k, dataset.fft.f, dataset.fft.fftdb_ux)
set(gca, 'YDir','normal');
colorbar; 
title(['FK - ux; ' titletext]);
ylim([-1e5 1e5]);
caxis([-24 0]);


figure
imagesc(dataset.fft.k, dataset.fft.f, dataset.fft.fftdb_ux_displacement)
set(gca, 'YDir','normal');
colorbar; 
title(['FK - ux displacement; ' titletext]);
ylim([-1e5 1e5]);
caxis([-24 0]);

% figure
% imagesc(data_decim.d064_000_000_096.fft.k, data_decim.d064_000_000_096.fft.f, data_decim.d064_000_000_096.fft.fftdb_ux)
% set(gca, 'YDir','normal');
% colorbar; 
% title('FFT2');
% ylim([-1e5 1e5]);
% caxis([-50 0]);