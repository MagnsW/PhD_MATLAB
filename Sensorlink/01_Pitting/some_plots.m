%%
figure
plot(output3.kgrid.t_array, squeeze(mean(sensor_data.p)))
hold on
%plot(output3.kgrid.t_array, squeeze(mean(sensor_data2.p)))
plot(output3.kgrid.t_array, squeeze(mean(output3.sensor_data.p)))
plot(output3.kgrid.t_array, squeeze(mean(output4.sensor_data.p)))
grid on;
grid minor;
%legend('no roughness', 'mild', 'severe', 'uniform thinning')
legend('no roughness', 'severe', 'uniform thinning')
%%
figure
imagesc(output3.kgrid.ky_vec, output3.kgrid.kx_vec, medium.sound_speed_compression)