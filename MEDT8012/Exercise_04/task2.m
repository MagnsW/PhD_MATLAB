sensitivity = 25.1e-9; %Volt/Pa
conv = 1/(1000*sensitivity); % kPa/Volt

p1 = load('pulse_7cm_-14dB_no_aver.mat');
p2 = load('pulse_7cm_-14dB_10x_aver.mat');
p3 = load('pulse_7cm_-8dB_10x_aver.mat');
p4 = load('pulse_7cm_0dB_10x_aver.mat');

snsplit = 1200; %signal to noise split

p1.signal = p1.RF(1:snsplit); p1.noise = p1.RF(snsplit+1:end);
p2.signal = p2.RF(1:snsplit); p2.noise = p2.RF(snsplit+1:end);
p3.signal = p3.RF(1:snsplit); p3.noise = p3.RF(snsplit+1:end);
p4.signal = p4.RF(1:snsplit); p4.noise = p4.RF(snsplit+1:end);

Nfft = 8192;
p1.fs = 1/p1.Ts;
p2.fs = 1/p2.Ts;
p3.fs = 1/p3.Ts;
p4.fs = 1/p4.Ts;

p1.freqtab = linspace(-0.5, 0.5, Nfft+1)*p1.fs; p1.freqtab(end) = [];
p2.freqtab = linspace(-0.5, 0.5, Nfft+1)*p2.fs; p2.freqtab(end) = [];
p3.freqtab = linspace(-0.5, 0.5, Nfft+1)*p3.fs; p3.freqtab(end) = [];
p4.freqtab = linspace(-0.5, 0.5, Nfft+1)*p4.fs; p4.freqtab(end) = [];

p1.s_pow_spect = 20*log10( abs( fftshift( fft( p1.signal, Nfft) ) ) );
p2.s_pow_spect = 20*log10( abs( fftshift( fft( p2.signal, Nfft) ) ) );
p3.s_pow_spect = 20*log10( abs( fftshift( fft( p3.signal, Nfft) ) ) );
p4.s_pow_spect = 20*log10( abs( fftshift( fft( p4.signal, Nfft) ) ) );

p1.n_pow_spect = 20*log10( abs( fftshift( fft( p1.noise, Nfft) ) ) );
p2.n_pow_spect = 20*log10( abs( fftshift( fft( p2.noise, Nfft) ) ) );
p3.n_pow_spect = 20*log10( abs( fftshift( fft( p3.noise, Nfft) ) ) );
p4.n_pow_spect = 20*log10( abs( fftshift( fft( p4.noise, Nfft) ) ) );

figure

subplot(4,1,1)
hold on
plot(p1.freqtab*1e-6, p1.n_pow_spect)
plot(p1.freqtab*1e-6, p1.s_pow_spect)
ylabel('dB')
xlabel('MHz')
legend('noise', 'signal')
xlim([0 50])
title('pulse 7cm -14dB no aver')
grid on
hold off

subplot(4,1,2)
hold on
plot(p2.freqtab*1e-6, p2.n_pow_spect)
plot(p2.freqtab*1e-6, p2.s_pow_spect)
ylabel('dB')
xlabel('MHz')
legend('noise', 'signal')
xlim([0 50])
title('pulse 7cm -14dB 10x aver')
grid on
hold off

subplot(4,1,3)
hold on
plot(p3.freqtab*1e-6, p3.n_pow_spect)
plot(p3.freqtab*1e-6, p3.s_pow_spect)
ylabel('dB')
xlabel('MHz')
legend('noise', 'signal')
xlim([0 50])
title('pulse 7cm -8dB 10x aver')
grid on
hold off

subplot(4,1,4)
hold on
plot(p4.freqtab*1e-6, p4.n_pow_spect)
plot(p4.freqtab*1e-6, p4.s_pow_spect)
ylabel('dB')
xlabel('MHz')
legend('noise', 'signal')
xlim([0 50])
title('pulse 7cm 0dB 10x aver')
grid on
hold off