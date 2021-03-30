function [P1, P1db, f] = onedft(trace, dt)
T = dt; %sampling period
Fs = 1/T; %sampling frequency
% L = length(data.traces)-1;
% t = (0:L-1)*T;        % Time vector

Nfft = 32768;  

Y = fft(trace, Nfft);
f = linspace(0, 0.5, Nfft/2+1)*Fs; f(end) = [];

P1 = abs(Y(1:Nfft/2));
P1db = 20*log10(P1);

% P1 = abs(Y(Nfft/2+1:end,:));

% Y = fft(data.traces(1:end-1,:), Nfft);
% P2 = abs(Y/L);
% P1 = P2(1:L/2+1,:);
% P1(2:end-1,:) = 2*P1(2:end-1,:);
% f = Fs*(0:(L/2))/L;
end