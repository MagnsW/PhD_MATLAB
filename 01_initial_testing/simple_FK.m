dt = 1.1130e-08;
t_end = 12.7e-5;
timevector = 0:dt:t_end;

source_freq = 0.5e5;
source_cycles = 4;

signal = .25*sin(2*pi*timevector*0.5e5);
%tone = toneBurst(1/dt, source_freq, source_cycles);

%signal = [tone zeros(1, length(timevector)-length(tone))];

signalX = fft(signal);
signalAmp = 2*abs(signalX)/length(signal);

%Vector of frequencies in Hz:
hz = linspace(0, 1/dt, length(timevector)); 

figure
subplot(211)
plot(timevector,signal)
xlabel('Time (s)'), ylabel('Amplitude')
title('Time domain')

ratio = 25;
timevector_resamp = timevector(1:ratio:end);
signal_resamp = signal(1:ratio:end);
hz_resamp = hz(1:ratio:end);

subplot(212)
plot(timevector_resamp,signal_resamp)
xlabel('Time (s)'), ylabel('Amplitude')
title('Time domain')

signalX_resamp = fft(signal_resamp);
signalAmp_resamp = 2*abs(signalX_resamp)/length(signalX_resamp);

figure
subplot(211)
stem(hz,signalAmp(1:length(hz)),'ks','linew',2,'markersize',10)
subplot(212)
stem(hz_resamp,signalAmp_resamp(1:length(hz_resamp)),'ks','linew',2,'markersize',10)

