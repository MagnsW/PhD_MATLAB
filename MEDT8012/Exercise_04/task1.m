sensitivity = 25.1e-9; %Volt/Pa
conv = 1/(1000*sensitivity); % kPa/Volt

p1 = load('pulse_7cm_-14dB_no_aver.mat');
p2 = load('pulse_7cm_-14dB_10x_aver.mat');
p3 = load('pulse_7cm_-8dB_10x_aver.mat');
p4 = load('pulse_7cm_0dB_10x_aver.mat');

figure

p1.Time = 0:p1.Ts:(length(p1.RF)-1)*p1.Ts;
subplot(4,1,1)
plot(1e6*p1.Time, conv*p1.RF)
xlabel('\mus')
ylabel('kPa')
title('pulse 7cm -14dB no aver')
grid on

p2.Time = 0:p2.Ts:(length(p2.RF)-1)*p2.Ts;
subplot(4,1,2)
plot(1e6*p2.Time, conv*p2.RF)
xlabel('\mus')
ylabel('kPa')
title('pulse 7cm -14dB 10x aver')
grid on

p3.Time = 0:p3.Ts:(length(p3.RF)-1)*p3.Ts;
subplot(4,1,3)
plot(1e6*p3.Time, conv*p3.RF)
xlabel('\mus')
ylabel('kPa')
title('pulse 7cm -8dB 10x aver')
grid on

p4.Time = 0:p4.Ts:(length(p4.RF)-1)*p4.Ts;
subplot(4,1,4)
plot(1e6*p4.Time, conv*p4.RF)
xlabel('\mus')
ylabel('kPa')
title('pulse 7cm 0dB 10x aver')
grid on
