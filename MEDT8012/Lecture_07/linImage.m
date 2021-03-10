%linear image system demo
%20.01.03 Hans Torp
%03.03.21 Jorgen Avdal

obj =[... %object 2D matrix
     0     0     0     0     0     0     0     0     0     0     0     0     0;
     0     0     0     0     10     10     0     0     0     0     0     0     0;
     0     0     0     0     0     5     0     0     0     0     0     0     0;
     0     0     0     0     0     0     0     0     0     16    0     0     0;
     0     0     4     0     0     0     0     0     0     0     0     0     0;
     0     0     0     0     0     0     0     0     0     0     0     0     0;
     0     0     0     0     8     16    0     0     0     0     0     0     0;
     0     0     0     0     0     0     0     0     0     0     0     0     0;
     0     0     0     0     0     0     0     0     0     0     0     0     0;
     0     0     0     0     0     0     0     0     0     0     0     0     0;
     0     0     0     0     0     0     0     0     0     0     0     0     0;
     0     0     0     0     0     0     0     0     0     0     0     0     0;
     0     0     0     0     0     0     0     0     0     0     0     0     0];
 
psf = [ 0   0.5  0; %point spread function
        0.5  1  0.5;
        0  0.5  0];
    
% psf = 1;
% psf = ones(6, 1);
psf = ones(1, 6);
% psf = 1;
% psf1 = ones(1,3);
% psf2 = ones(3,1);
% psf = psf1 + psf2;

% psfim = zeros( size( obj) );
% psfim(6:8, 6:8) = psf;
im=conv2(obj,psf,'same');
disp(im);
%%  
figure(1);colormap(gray(16)); 
subplot(3,1,1);imagesc(obj);colorbar;title('Object');
axis image;
% figure(1);colormap(gray(16)); 
% subplot(3,1,2);imagesc(psfim);colorbar;title('PSF');
% axis image;
subplot(3,1,3);imagesc(im);colorbar;title('Image');
axis image;
%%
O=fft2(obj);
[N,M]=size(obj);
Psf=fft2(psf,N,M);
figure(2);
subplot(3,1,1)
imagesc(20*log10( abs( fftshift(O) )));colormap(gray);
set( gca, 'xtick', [], 'ytick', []);
axis equal tight
title('Fourier transform of object')
subplot(3,1,2)
imagesc(20*log10( abs( fftshift(Psf) )));colormap(gray);
set( gca, 'xtick', [], 'ytick', []);
axis equal tight
title('Fourier transform of PSF')

subplot(3,1,3)
imagesc(20*log10( abs( fftshift(fft2(im) ) )));colormap(gray);
set( gca, 'xtick', [], 'ytick', []);
axis equal tight
title('Fourier transform of image')


%dynamic range 16 /1
dynRange= 20*log10(16) %dynamic range in dB
