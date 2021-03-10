platemodel = make_random_model(64, 1280, 12, 0);
platemodel_ref = make_random_model(64, 1280, 0, 0);
[sensor_data, medium, dt, dx, dy] = lamb_simulate(64, 1, platemodel)
[sensor_data_ref, medium_ref, dt, dx, dy] = lamb_simulate(64, 1, platemodel_ref)
t_array = (1:length(sensor_data.ux))*dt;

%%

trace_ref = mean(sensor_data_ref.ux);
trace_rough = mean(sensor_data.ux);

%%
figure
hold on
plot(t_array*1e6, trace_ref)
plot(t_array*1e6, trace_rough)
grid on
xlabel('microseconds')
legend('nominal plate', 'rough plate')
title('Single channel recording')

%%
analyzed_ref = trace_analyse(trace_ref, dt);
analyzed_rough = trace_analyse(trace_rough, dt);

%%
figure
hold on
plot(analyzed_ref.env_autocorr.pks_locs_time_diff*1e6)
plot(analyzed_rough.env_autocorr.pks_locs_time_diff*1e6)
legend('Reference', 'Rough')
grid(gca,'minor')
grid on
title('Envelope revolution time (group velocity)')
ylabel('time [ms]')
xlabel('pass number')
ylim([80 90]);

%%
figure
hold on
plot(analyzed_ref.env_max.pks_locs_time_diff*1e6)
plot(analyzed_rough.env_max.pks_locs_time_diff*1e6)
legend('Reference', 'Rough')
grid(gca,'minor')
grid on
title('Envelope revolution time (group velocity)')
ylabel('time [ms]')
xlabel('pass number')
ylim([80 90]);