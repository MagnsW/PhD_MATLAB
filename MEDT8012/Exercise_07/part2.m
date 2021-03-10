%%
clear all;
lena = imread('lena.jpg');

[pixX, pixY] = size(lena);

Nfftx = pixX;
Nffty = pixY;

deltaX = 0.3/pixX;
deltaY = 0.3/pixY;

xfreqs = linspace(-0.5, 0.5, Nfftx+1)*(1/deltaX); xfreqs(end) = [];
yfreqs = linspace(-0.5, 0.5, Nffty+1)*(1/deltaY); yfreqs(end) = [];

figure('Position', [10 10 1210 610])
subplot(1,2,1)
image(lena)
axis('image')
colormap(gray(255));

subplot(1,2,2)
lena_fft = fft2(lena, Nfftx, Nffty);
imagesc(xfreqs, yfreqs, 20*log10(fftshift(abs(lena_fft))));
axis('image')
dyn = 100;
gain = -120;
caxis([-dyn 0]-gain);
colorbar;
%%
Nx = 5;
Ny = 5;
avgfilt = ones(Nx, Ny)/(Nx*Ny);

figure('Position', [10 10 1210 610])

subplot(1,2,1)
imagesc(avgfilt)
axis('image')

subplot(1,2,2)
avg_filt_fft = fft2(avgfilt, Nfftx, Nffty);
imagesc(xfreqs, yfreqs, 20*log10(fftshift(abs(avg_filt_fft))));
colormap(gray(255))
axis('image')
dyn = 50;
gain = 0;
caxis([-dyn 0]-gain);
colorbar;

%%
figure('Position', [10 10 1210 610])

lena_filt = filter2(avgfilt, lena);

subplot(1,2,1)
image(lena_filt)
axis('image')
colormap(gray(255));

lena_filt_fft = fft2(lena_filt, Nfftx, Nffty);

subplot(1,2,2)
imagesc(xfreqs, yfreqs, 20*log10(fftshift(abs(lena_filt_fft))));
colormap(gray(255))
axis('image')
dyn = 100;
gain = -120;
caxis([-dyn 0]-gain);
colorbar;

