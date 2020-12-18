% display('------------modeling 1----------------')
% [sensor_data_pittingdepth_0, model_pittingdepth_0] = lamb_simulate(64, 1, make_random_model(64, 1280, 0));
% display('------------modeling 2----------------')
% [sensor_data_pittingdepth_2_v1, model_pittingdepth_2_v1] = lamb_simulate(64, 1, make_random_model(64, 1280, 2));
display('------------modeling 3----------------')
[sensor_data_pittingdepth_2_v2, model_pittingdepth_2_v2] = lamb_simulate(64, 1, make_random_model(64, 1280, 2));
display('------------modeling 4----------------')
[sensor_data_pittingdepth_2_v3, model_pittingdepth_2_v3] = lamb_simulate(64, 1, make_random_model(64, 1280, 2));
display('------------modeling 5----------------')
[sensor_data_pittingdepth_4_v1, model_pittingdepth_4_v1] = lamb_simulate(64, 1, make_random_model(64, 1280, 4));
display('------------modeling 6----------------')
[sensor_data_pittingdepth_4_v2, model_pittingdepth_4_v2] = lamb_simulate(64, 1, make_random_model(64, 1280, 4));
display('------------modeling 7----------------')
[sensor_data_pittingdepth_4_v3, model_pittingdepth_4_v3] = lamb_simulate(64, 1, make_random_model(64, 1280, 4));
display('------------modeling 8----------------')
[sensor_data_pittingdepth_8_v1, model_pittingdepth_8_v1] = lamb_simulate(64, 1, make_random_model(64, 1280, 8));
display('------------modeling 9----------------')
[sensor_data_pittingdepth_8_v2, model_pittingdepth_8_v2] = lamb_simulate(64, 1, make_random_model(64, 1280, 8));
display('------------modeling 10----------------')
[sensor_data_pittingdepth_8_v3, model_pittingdepth_8_v3] = lamb_simulate(64, 1, make_random_model(64, 1280, 8));


% dt = 10e-9;
% dx = 0.2e-3;
% [p_align_grad_lat, ux_align_grad_lat, v_p_grad_lat, v_ux_grad_lat] = velestim(sensor_data_nx64_vc6464_grad_lateral, dx, dt);
% [p_align_grad_lat_flip, ux_align_grad_lat_flip, v_p_grad_lat_flip, v_ux_grad_lat_flip] = velestim(sensor_data_nx64_vc6464_grad_lateral_flip, dx, dt);
% [p_align_grad_no, ux_align_grad_no, v_p_grad_no, v_ux_grad_no] = velestim(sensor_data_nx64_vc6464_grad_no, dx, dt);
% 
% [p_align_grad_lat_gv, ux_align_grad_lat_gv, gv_p_grad_lat, gv_ux_grad_lat] = velestim_group(sensor_data_nx64_vc6464_grad_lateral, dx, dt);
% [p_align_grad_lat_flip_gv, ux_align_grad_lat_flip_gv, gv_p_grad_lat_flip, gv_ux_grad_lat_flip] = velestim_group(sensor_data_nx64_vc6464_grad_lateral_flip, dx, dt);
% [p_align_grad_no_gv, ux_align_grad_no_gv, gv_p_grad_no_gv, gv_ux_grad_no] = velestim_group(sensor_data_nx64_vc6464_grad_no, dx, dt);