
dt = 10e-9;
dx = 0.2e-3;

[p_timeshift_0, ux_timeshift_0, v_p_0, v_ux_0] = velestim(sensor_data_pittingdepth_0, dx, dt);
[p_timeshift_2v1, ux_timeshift_2v1, v_p_2v1, v_ux_2v1] = velestim(sensor_data_pittingdepth_2_v1, dx, dt);
[p_timeshift_2v2, ux_timeshift_2v2, v_p_2v2, v_ux_2v2] = velestim(sensor_data_pittingdepth_2_v2, dx, dt);
% [p_timeshift_2v3, ux_timeshift_2v3, v_p_2v3, v_ux_2v3] = velestim(sensor_data_pittingdepth_2_v3, dx, dt);
% [p_timeshift_4v1, ux_timeshift_4v1, v_p_4v1, v_ux_4v1] = velestim(sensor_data_pittingdepth_4_v1, dx, dt);
% [p_timeshift_4v2, ux_timeshift_4v2, v_p_4v2, v_ux_4v2] = velestim(sensor_data_pittingdepth_4_v2, dx, dt);
% [p_timeshift_4v3, ux_timeshift_4v3, v_p_4v3, v_ux_4v3] = velestim(sensor_data_pittingdepth_4_v3, dx, dt);
% [p_timeshift_8v1, ux_timeshift_8v1, v_p_8v1, v_ux_8v1] = velestim(sensor_data_pittingdepth_8_v1, dx, dt);
% [p_timeshift_8v2, ux_timeshift_8v2, v_p_8v2, v_ux_8v2] = velestim(sensor_data_pittingdepth_8_v2, dx, dt);
% [p_timeshift_8v3, ux_timeshift_8v3, v_p_8v3, v_ux_8v3] = velestim(sensor_data_pittingdepth_8_v3, dx, dt);
% [p_timeshift_16v1, ux_timeshift_16v1, v_p_16v1, v_ux_16v1] = velestim(sensor_data_pittingdepth_16_v1, dx, dt);
% [p_timeshift_16v2, ux_timeshift_16v2, v_p_16v2, v_ux_16v2] = velestim(sensor_data_pittingdepth_16_v2, dx, dt);
% [p_timeshift_16v3, ux_timeshift_16v3, v_p_16v3, v_ux_16v3] = velestim(sensor_data_pittingdepth_16_v3, dx, dt);
