clear all; close all;
%% Excercise 1; Problem 1
fs = 100;
f1 = 5; a1 = 0.02; %frequency and amplitude of signal component 1
f2 = 45; a2 = 0.02; %frequency and amplitude of signal component 2
n1 = 0.0002; %noise amplitude
t = 0:1/fs:1;
s = a1*cos( 2*pi*f1*t) + a2*cos( 2*pi*f2*t) + n1*randn( size( t) );

%% 
fig1 = figure(1);
set(fig1, 'position', [1500 100 900 500], 'Name', 'Problem 1')
plot(t, s)
xlabel('t')
ylabel('amplitude')
title('Signal s')
grid on

%%
%p = (abs(fft(s))).^2;
Nfft = 512;
p = 20*log10(abs(fftshift(fft(s, Nfft))));

f = linspace(-0.5, 0.5, Nfft+1)*fs; f(end) = [];
fig2 = figure(2);
hold on
set(fig2, 'position', [1500 100 900 500], 'Name', 'Problem 1')
plot(f,p)
xlabel('f')
ylabel('amplitude')
title('Power spectrum')
grid on

%% Compute filters and plot
A1 = fir1(22, 0.5, 'low');
A2 = fir1(22, 0.5, 'high');
p_A1 = 20*log10(abs(fftshift(fft(A1, Nfft))));
p_A2 = 20*log10(abs(fftshift(fft(A2, Nfft))));
plot(f, p_A1)
plot(f, p_A2)
legend('s', 'A1', 'A2')
%% Compute filtered signals and plot
s_A1_filt = filter(A1, 1, s);
s_A2_filt = filter(A2, 1, s);
fig3 = figure(3);
set(fig3, 'position', [1500 100 900 500], 'Name', 'Problem 1')
subplot(2,1,1)
hold on
plot(t, s_A1_filt)
plot(t, s_A2_filt)
hold off
grid on
legend('A1 filtered', 'A2 filtered')
xlabel('t')
subplot(2,1,2)
hold on
plot(f, 20*log10(abs(fftshift(fft(s_A1_filt, Nfft)))));
plot(f, 20*log10(abs(fftshift(fft(s_A2_filt, Nfft)))));
hold off
grid on
xlabel('f')
legend('A1 filtered', 'A2 filtered')
%% Downsample signal
s_decim = s(1:2:end);
fig4 = figure(4);
set(fig4, 'position', [1500 100 900 500], 'Name', 'Problem 1')
subplot(2,1,1)
hold on
plot(t, s)
plot(t(1:2:end), s_decim)
hold off
grid on
legend('Original', 'Downsampled')
xlabel('t')
subplot(2,1,2)
hold on
plot(f, 20*log10(abs(fftshift(fft(s, Nfft)))));
plot(f, 20*log10(abs(fftshift(fft(s_decim, Nfft)))));
hold off
grid on
legend('Original', 'Downsampled')
xlabel('f')

