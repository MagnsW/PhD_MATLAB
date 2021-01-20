
% signal processing lecture
% 17.01.05 Hans Torp
% 11.01.2017 Update HT
%% Single frequency signal
T=0.5;%time interval length [s]
dt=1e-4;%time increment
fs=1/dt%sampling frequency
t=0:dt:T;%time vector
f=400;%frequency
A=1.0; %amplitude
s=A*cos(2*pi*f*t);
%s=A*randn(1,length(t));%uncomment to use random white noise signal

figure(1); clf;
plot(t,s);grid;zoom xon;
axis([0,T,-1.2,1.2]);

E=sum(s.^2*dt) % energy
P=E/T %power P = E/T = mean(s.^2)
RMS=sqrt(P) % Root Mean Square amplitude 
dB = 10*log10(P) % Power in deciBell: dB = 10*log10(P) = 20*log10(RMS)

%% 
sound(s,fs);
%% Filter example
% 1.order recursive lowpass filter
%     a(1)*y(n) = b(1)*x(n) - a(2)*y(n-1)
%  a(1)=1, a(2)= - d,  b(1) = 1-d
%  constant 0 < d < 1
d=0.98;
%d=0.5;
a=[1 ,-d]; b= 1-d;
si=zeros(size(t));si(1)=1;%impulse signal
h=filter(b,a,si);%%filter impulse respons
figure(1);subplot(2,1,1);plot(t,h); zoom;
y=filter(b,a,s);%filter signal s by diff. equation
subplot(2,1,2);plot(t,s,t,y); zoom xon
sound(s,fs);pause(T+0.5);sound(y,fs);

Py=mean(y.^2)%power P = E/T = mean(s.^2)
Attenuation_dB = 10*log10(P/Py) % Power in deciBell: dB = 10*log10(P) = 20*log10(RMS)

%% Frequency response
H=fft(h);
N=length(t);f1=(0:N-1)*fs/N;
subplot(2,1,1);plot(f1,20*log10(abs(H)));grid;

return;
%% sounddemo 
%Hvordan hres korte lydpulser ut?
% 30.09.04 Hans Torp

f0=440;%frekvens lyd, 440 Hz =kammertone
fs=16e3;
for Ncycles=[1,2,4,8,16,32,64,128,256],
    figure(1);
    T=Ncycles/f0;
    t=0:1/fs:T;
    s=sin(2*pi*f0*t);
    Nfft=10000;
    S=fft(s,Nfft);
    f=(0:Nfft-1)*fs/Nfft;
    S=S/max(S);
    subplot(2,1,1);plot(t,s);xlabel('tid [s]');
    subplot(2,1,2);plot(f,abs(S));axis([0,2000,0,1]);
    xlabel('frekvens [Hz]');
    sound(s,fs);
    pause;
end;

