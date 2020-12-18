
dt = 10e-9;
dx = 0.2e-3;
[p_align_grad_lat, ux_align_grad_lat, v_p_grad_lat, v_ux_grad_lat] = velestim(sensor_data_nx64_vc6464_grad_lateral, dx, dt);
[p_align_grad_lat_flip, ux_align_grad_lat_flip, v_p_grad_lat_flip, v_ux_grad_lat_flip] = velestim(sensor_data_nx64_vc6464_grad_lateral_flip, dx, dt);
[p_align_grad_no, ux_align_grad_no, v_p_grad_no, v_ux_grad_no] = velestim(sensor_data_nx64_vc6464_grad_no, dx, dt);

[p_align_grad_lat_gv, ux_align_grad_lat_gv, gv_p_grad_lat, gv_ux_grad_lat] = velestim_group(sensor_data_nx64_vc6464_grad_lateral, dx, dt);
[p_align_grad_lat_flip_gv, ux_align_grad_lat_flip_gv, gv_p_grad_lat_flip, gv_ux_grad_lat_flip] = velestim_group(sensor_data_nx64_vc6464_grad_lateral_flip, dx, dt);
[p_align_grad_no_gv, ux_align_grad_no_gv, gv_p_grad_no_gv, gv_ux_grad_no] = velestim_group(sensor_data_nx64_vc6464_grad_no, dx, dt);