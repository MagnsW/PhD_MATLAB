figure 
subplot(1,2,1)
imagesc(squeeze(sensor_data_halfway.ux).')
title('Halfway')
subplot(1,2,2)
imagesc(squeeze(sensor_data.ux).')
title('Full way')
caxis([-6, 6]*1e-8)

figure 
subplot(1,2,1)
imagesc(squeeze(sensor_data_halfway_flip.ux).')
title('Halfway')
subplot(1,2,2)
imagesc(squeeze(sensor_data_flip.ux).')
title('Full way')
caxis([-6, 6]*1e-8)

%%
figure
subplot(2,1,1)
imagesc(medium_velgrad.sound_speed_compression);
caxis([5000 7000]);
title('Nominal')
colorbar;

subplot(2,1,2)
imagesc(medium_velgrad_flip.sound_speed_compression);
caxis([5000 7000])
title('Flipped')
colorbar;

%%
figure
subplot(1,2,1)
plot(t_array, trace_halfway_velgrad)
hold on
plot(t_array, trace_halfway_velgrad_flip)
hold off
grid on
title('Halfway')
legend('Nominal', 'Flipped model')
ylim([-5, 5]*1e-8);

subplot(1,2,2)
plot(t_array, trace_velgrad)
hold on
plot(t_array, trace_velgrad_flip)
hold off
grid on
title('Full way')
legend('Nominal', 'Flipped model')
ylim([-5, 5]*1e-8);