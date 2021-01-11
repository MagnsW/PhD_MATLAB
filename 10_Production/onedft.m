function [P1, f] = onedft(data)
T = data.step; %sampling period
Fs = 1/T; %sampling frequency
L = length(data.traces)-1;
t = (0:L-1)*T;        % Time vector

Y = fft(data.traces(1:end-1,:));
P2 = abs(Y/L);
P1 = P2(1:L/2+1,:);
P1(2:end-1,:) = 2*P1(2:end-1,:);
f = Fs*(0:(L/2))/L;
end