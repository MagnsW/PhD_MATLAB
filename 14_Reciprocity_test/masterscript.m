platemodel = make_random_model(64, 1280, 12, 0);
platemodel_flip = flip(platemodel, 2);
[sensor_data_halfway_velgrad, medium_velgrad, dt, dx, dy] = lamb_simulate(64, 1, platemodel)
[sensor_data_halfway_velgrad_flip, medium_velgrad_flip, dt, dx, dy] = lamb_simulate(64, 1, platemodel_flip)

[sensor_data_velgrad, medium_velgrad, dt, dx, dy] = lamb_simulate(64, 1, platemodel)
[sensor_data_velgrad_flip, medium_velgrad_flip, dt, dx, dy] = lamb_simulate(64, 1, platemodel_flip)

t_array = (1:length(sensor_data.ux))*dt;

trace_ref = mean(sensor_data_ref.ux);
trace_rough = mean(sensor_data.ux);

trace_velgrad_flip = squeeze(mean(sensor_data_velgrad_flip.ux));
trace_velgrad = squeeze(mean(sensor_data_velgrad.ux));

%%
figure
hold on
plot(t_array*1e6, trace_ref)
plot(t_array*1e6, trace_rough)
grid on
xlabel('microseconds')
legend('nominal plate', 'rough plate')
title('Single channel recording')