function [fft_out, fftdb_out, k, f] = twodft(data, dy)
%fft calculations
dimensions = size(data.traces);
dt = data.step;
Nyq_k = 1/(2*dy); % Nyquist of data in first dimension
Nyq_f = 1/(2*dt); % Nyquist of data in second dimension
dk = 1/(dimensions(2)*dy);   % Wavenumber increment
df = 1/(dimensions(1)*dt);   % Frequency increment

k = -Nyq_k : dk : Nyq_k-dk; % wavenumber
f = -Nyq_f : df : Nyq_f-df; % frequency
%fft 

fft_out = fftshift(fft2(data.traces))*dy*dt;
fftdb_out = 20*log10(abs(fft_out)/max(abs(fft_out(:))));

end