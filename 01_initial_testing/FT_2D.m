%ux_disp = cumtrapz(kgrid.t_array, ux); %Integration

p = squeeze(sensor_data.ux(1,:,:))';
% run next line to integrate
p = cumtrapz(kgrid.t_array, p);

p_decim = p(1:100:end, 1:10:end);

x_ratio = 10;
t_ratio = 100;

p_decim = p(1:t_ratio:end, 1:x_ratio:end);
p_dim = size(p_decim);

dx = kgrid.dx*x_ratio;
dt = kgrid.dt*t_ratio;

%p_resample = resample(double(p), 1, t_ratio);
%p_resample = p_resample(:, 1:x_ratio:end); 

Nyq_k = 1/(2*dx); % Nyquist of data in first dimension
Nyq_f = 1/(2*dt); % Nyquist of data in second dimension
dk = 1/(p_dim(2)*dx);   % Wavenumber increment
df = 1/(p_dim(1)*dt);   % Frequency increment

k = -Nyq_k : dk : Nyq_k-dk; % wavenumber
f = -Nyq_f : df : Nyq_f-df; % frequency
%f = 0 : df : Nyq_f-df;
fft2result = fftshift(fft2(p_decim))*dx*dt;

fft2resultdb = 20*log10(abs(fft2result)/max(abs(fft2result(:))));

colorbar; 

%figure
subplot(211)
imagesc(p_decim)
colorbar;
title('ux displacement')
subplot(212)
imagesc(k,f,(fft2resultdb));
set(gca, 'YDir','reverse');
colorbar; 
title('FFT2');
