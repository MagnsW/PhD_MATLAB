%%
dr = 2*pi*R/T*sin(2*pi*(t_array-t0)/T);
figure
hold on
plot(t_array, r)
plot(t_array, dr)
grid on;
xlabel('Time [s]')
legend('r', 'dr')

%%
beam_x = squeeze(M_mode_matrix(:,42));
beam_y = squeeze(M_mode_matrix(:,43));

figure
plot(20*log10(abs(beam_x )))
hold on
plot(20*log10(abs(beam_y)))