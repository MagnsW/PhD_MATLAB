%% Task 1
close all; clear all;


% load('phantomRFdata1.mat')
% load('phantomRFdata2.mat')
load('cardiacRFdata.mat')

fs = p.frs_Hz;
t_array = linspace(0, length(rf(:,1))*1/fs, length(rf(:,1))+1).'; t_array(end) = [];

figure(1)
subplot(3,1,1)
plot(t_array*1e6, rf)
xlabel('\mus')
title('Time series')

Nfft = length(rf(:,1));
freqtab = linspace(-0.5, 0.5, Nfft+1)*fs; freqtab(end) = [];
pow_spect = 20*log10( abs( fftshift( fft( rf, Nfft),1 ) ) );

subplot(3,1,2)
plot(freqtab*1e-6, pow_spect)
xlabel('MHz')
ylabel('dB')
title('Power spectrum')

% s = rf(:,1);
% w = 2*pi*p.f0_Hz;
w = 2*pi*p.f0_Hz*2; %Demodulation using twice the fundamental freq.
s_dm = rf.*exp(-1i.*w.*t_array);

pow_spect_dm = 20*log10( abs( fftshift( fft( s_dm, Nfft),1 ) ) );
subplot(3,1,3)
plot(freqtab*1e-6, pow_spect_dm)
xlabel('MHz')
ylabel('dB')
title('Power spectrum after downmixing')

% Trying the lowpass function in Matlab

% filter_freq = 0.5e6;
% s_dm_lowpass = lowpass(s_dm, filter_freq ,fs);

% Design filter

lpFilt = designfilt('lowpassfir','PassbandFrequency',0.025, 'StopbandFrequency',0.030);
s_dm_lowpass = filtfilt(lpFilt, s_dm);

pow_spect_dm_lowpass = 20*log10( abs( fftshift( fft( s_dm_lowpass, Nfft),1 ) ) );

figure(2)
subplot(2,1,1)
plot(freqtab*1e-6, pow_spect_dm)
xlabel('MHz')
ylabel('dB')
title('Power spectrum after downmixing')
subplot(2,1,2)
plot(freqtab*1e-6, pow_spect_dm_lowpass)
xlabel('MHz')
ylabel('dB')
title('Power spectrum after downmixing and low pass filtering')

figure(3)
hold on
plot(freqtab*1e-6, mean(pow_spect,2))
plot(freqtab*1e-6, mean(pow_spect_dm,2))
plot(freqtab*1e-6, mean(pow_spect_dm_lowpass,2))
hold off
grid on
xlabel('MHz')
ylabel('dB')
legend('Raw input', 'Downmixed', 'Downmixed and low pass filtered')

%% Task 2

c = 1540;

d_array = (t_array/2*c)+p.startdepth_m;
figure(4)
hold on
plot(d_array, rf(:,64))
xlabel('Depth [m]')

envelope = 2*abs(s_dm_lowpass);
plot(d_array, envelope(:,64))
hold off
legend('Raw trace no 64', 'Envelope of trace no 64')

%% Task 3

figure(5)
imagesc(1:1:length(envelope(1,:)), d_array, envelope)
ylabel('Depth [m]')
title('Image in beam space')
colormap(gray);

r_array = d_array;
theta_array = (1:1:length(envelope(1,:)))*p.angleincrement_rad + p.startangle_rad;

[im,xax,zax]=scanconvert(envelope,r_array,theta_array);

dyn = 50;
% gain = -100;
gain = -75

figure(6)
imagesc(xax, zax, 20*log10( abs(im)));
caxis([-dyn 0]-gain);
colormap(gray);
colorbar;
title('Image in Cartesian space')





