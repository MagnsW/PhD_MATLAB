%%
% output_00 = wave_simulate(400, model_00);
% output_01 = wave_simulate(400, model_01);
%%
output_00.model_stats = model_stats(output_00.medium);
output_01.model_stats = model_stats(output_01.medium);
output_02.model_stats = model_stats(output_02.medium);
output_03.model_stats = model_stats(output_03.medium);
output_04.model_stats = model_stats(output_04.medium);
output_05.model_stats = model_stats(output_05.medium);

%%
figure
plot(output_00.kgrid.t_array, squeeze(mean(output_00.sensor_data.p)))
hold on
plot(output_01.kgrid.t_array, squeeze(mean(output_01.sensor_data.p)))

%%
[output_00.measurement, output_00.settings] = make_measurement(output_00);
[output_01.measurement, output_01.settings] = make_measurement(output_01);
[output_02.measurement, output_02.settings] = make_measurement(output_02);
[output_03.measurement, output_03.settings] = make_measurement(output_03);
[output_04.measurement, output_04.settings] = make_measurement(output_04);
[output_05.measurement, output_05.settings] = make_measurement(output_05);

%%
output_00.result = wall_thickness_contact(output_00.measurement, output_00.settings);
output_01.result = wall_thickness_contact(output_01.measurement, output_01.settings);
output_02.result = wall_thickness_contact(output_02.measurement, output_02.settings);
output_03.result = wall_thickness_contact(output_03.measurement, output_03.settings);
output_04.result = wall_thickness_contact(output_04.measurement, output_04.settings);
output_05.result = wall_thickness_contact(output_05.measurement, output_05.settings);

%%
plot_model(output_00)
plot_model(output_01)
plot_model(output_02)
plot_model(output_03)
plot_model(output_04)
plot_model(output_05)
plot_model(output_06)

%%
output_06 = output_analysis(output_06);

