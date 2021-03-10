%%
% figure
% plot(t, Z)
% numfft = 512;
% t_array = t(1:end-1); %t(1001:3000);
Z_diff_array = diff(Z(1001:3000)); %Z(1001:3000);
% plot(t_s(1:end-1), Z_diff_array);
% figure
% f_array = linspace(-0.5, 0.5, numfft+1)*fs; f_array(end) = [];
f_array = linspace(-0.5, 0.5, length(Z_diff_array)+1)*1/dt; f_array(end) = [];
% fft_array = fft(Z_diff_array, 1000);
% fft_array2 = fft(Z_diff_array);
p_Z_diff_array = 20*log10(abs(fftshift(fft(Z_diff_array))));
plot(f_array, p_Z_diff_array);
plot(abs(fftshift(fft(Z_diff_array))));
plot(pwelch(Z_diff_array));

p_h = 20*log10(abs(fftshift(fft(h))));

f_array2 = linspace(-0.5, 0.5, length(h)+1)*1/dt; f_array2(end) = [];
plot(f_array2, p_h);