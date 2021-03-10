%%
clear all;
lines = imread('Horizontal2.bmp');
% lines = imread('Vertical_low_left.bmp');
% lines = imread('Vertical_up_right.bmp');
% lines = imread('Rotate45.bmp');
% lines = imread('Hor_thin.bmp');
% lines = imread('Hor_thick.bmp');
% lines = imread('Hor_thick_short.bmp');

lines = imcomplement(lines); % negative image to get white lines on black

figure('Position', [10 10 1410 510])
subplot(1,2,1)
imagesc(lines)
colormap(gray(255));
axis('image');
title('Image');

subplot(1,2,2)
Nfft = 512;

deltaX = 1e-3;
deltaY = 1e-3;

xfreqs = linspace(-0.5, 0.5, Nfft+1)*(1/deltaX); xfreqs(end) = [];
yfreqs = linspace(-0.5, 0.5, Nfft+1)*(1/deltaY); yfreqs(end) = [];

lines_fft = fft2(lines);
imagesc(xfreqs, yfreqs, 20*log10(fftshift(abs(lines_fft))));
colorbar
colormap(gray(255));
dyn = 50;

gain = -75;
caxis([-dyn 0]-gain)
axis('image')
title('2D Fourier Transform')
