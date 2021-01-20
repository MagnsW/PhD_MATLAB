clear all; close all;
%% Loading and plotting
load('sigFile.mat')
fig5 = figure(5);
hold on
set(fig5, 'position', [1500 100 900 500], 'Name', 'Problem 2')
plot(t, s)
plot(t, sn)
legend('s', 'sn')
ax5 = gca;
%% Computing and plotting power spectrums
fs = 1/(mean(diff(t)));
Nfft = 512;
p_s = 20*log10(abs(fftshift(fft(s, Nfft))));
p_sn = 20*log10(abs(fftshift(fft(sn, Nfft))));
f = linspace(-0.5, 0.5, Nfft+1)*fs; f(end) = [];
fig6 = figure(6);
set(fig6, 'position', [1500 100 900 500], 'Name', 'Problem 2')
hold on
plot(f, p_s)
plot(f, p_sn)
legend('s', 'sn')

xlabel('f')
%% filter
b = fir1(60, 0.1, 'low');
plot(f, 20*log10(abs(fftshift(fft(b, Nfft)))));

sn_filt = filter(b, 1, sn);
plot(f, 20*log10(abs(fftshift(fft(sn_filt, Nfft)))));
legend('s', 'sn', 'filter', 'sn filtered');

%% Plotting with filter delay subtracted
N = mean(grpdelay(b));
fig5 = figure(5);clf;
hold on
set(fig5, 'position', [1500 100 900 500], 'Name', 'Problem 2')

plot(t, s)
plot(t, sn)
plot(t(1:end-N), sn_filt(N+1:end), 'LineWidth', 3)
legend('s', 'sn', 'sn filtered')


%% Truncating traces and computing quadratic mean
s_trunc = s(1:end-N);
sn_trunc = sn(1:end-N);
sn_filt_trunc = sn_filt(N+1:end);

%Computing root-mean-square deviation (quadratic mean)
rmsd_unfilt = sqrt(mean((sn_trunc - s_trunc).^2));
rmsd_filt = sqrt(mean((sn_filt_trunc - s_trunc).^2));
noisereduction_dB = 20*log10(rmsd_filt/rmsd_unfilt)
