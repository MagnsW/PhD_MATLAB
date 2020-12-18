[p_align_nx62_vc6264_gv, ux_align_nx62_vc6264_gv, vg_p_nx62_vc6264, vg_ux_nx62_vc6264] = velestim_group(sensor_data_nx62_vc6264, dx, dt);
[p_align_nx63_vc6364_gv, ux_align_nx63_vc6364_gv, vg_p_nx63_vc6364, vg_ux_nx63_vc6364] = velestim_group(sensor_data_nx63_vc6364, dx, dt);
[p_align_nx64_vc6464_gv, ux_align_nx64_vc6464_gv, vg_p_nx64_vc6464, vg_ux_nx64_vc6464] = velestim_group(sensor_data_nx64_vc6464, dx, dt);
[p_align_nx65_vc6564_gv, ux_align_nx65_vc6564_gv, vg_p_nx65_vc6564, vg_ux_nx65_vc6564] = velestim_group(sensor_data_nx65_vc6564, dx, dt);
[p_align_nx66_vc6664_gv, ux_align_nx66_vc6664_gv, vg_p_nx66_vc6664, vg_ux_nx66_vc6664] = velestim_group(sensor_data_nx66_vc6664, dx, dt);
[p_align_nx64_vc6264_gv, ux_align_nx64_vc6264_gv, vg_p_nx64_vc6264, vg_ux_nx64_vc6264] = velestim_group(sensor_data_nx64_vc6264, dx, dt);
[p_align_nx64_vc6364_gv, ux_align_nx64_vc6364_gv, vg_p_nx64_vc6364, vg_ux_nx64_vc6364] = velestim_group(sensor_data_nx64_vc6364, dx, dt);
[p_align_nx64_vc6564_gv, ux_align_nx64_vc6564_gv, vg_p_nx64_vc6564, vg_ux_nx64_vc6564] = velestim_group(sensor_data_nx64_vc6564, dx, dt);
[p_align_nx64_vc6664_gv, ux_align_nx64_vc6664_gv, vg_p_nx64_vc6664, vg_ux_nx64_vc6664] = velestim_group(sensor_data_nx64_vc6664, dx, dt);
[p_align_nx62_vc6464_gv, ux_align_nx62_vc6464_gv, vg_p_nx62_vc6464, vg_ux_nx62_vc6464] = velestim_group(sensor_data_nx62_vc6464, dx, dt);
[p_align_nx63_vc6464_gv, ux_align_nx63_vc6464_gv, vg_p_nx63_vc6464, vg_ux_nx63_vc6464] = velestim_group(sensor_data_nx63_vc6464, dx, dt);
[p_align_nx65_vc6464_gv, ux_align_nx65_vc6464_gv, vg_p_nx65_vc6464, vg_ux_nx65_vc6464] = velestim_group(sensor_data_nx65_vc6464, dx, dt);
[p_align_nx66_vc6464_gv, ux_align_nx66_vc6464_gv, vg_p_nx66_vc6464, vg_ux_nx66_vc6464] = velestim_group(sensor_data_nx66_vc6464, dx, dt);

thicknesses = [62, 63, 64, 65, 66]*dx;
vel_ratios = [62, 63, 64, 65, 66] / 64;

vg_p_const_vel = [vg_p_nx62_vc6464, vg_p_nx63_vc6464, vg_p_nx64_vc6464, vg_p_nx65_vc6464, vg_p_nx66_vc6464; thicknesses];
vg_ux_const_vel = [vg_ux_nx62_vc6464, vg_ux_nx63_vc6464, vg_ux_nx64_vc6464, vg_ux_nx65_vc6464, vg_ux_nx66_vc6464; thicknesses];

vg_p_const_thick = [vg_p_nx64_vc6264, vg_p_nx64_vc6364, vg_p_nx64_vc6464, vg_p_nx64_vc6564, vg_p_nx64_vc6664; vel_ratios];
vg_ux_const_thick = [vg_ux_nx64_vc6264, vg_ux_nx64_vc6364, vg_ux_nx64_vc6464, vg_ux_nx64_vc6564, vg_ux_nx64_vc6664; vel_ratios];

vg_p_both_vary = [vg_p_nx62_vc6264, vg_p_nx63_vc6364, vg_p_nx64_vc6464, vg_p_nx65_vc6564, vg_p_nx66_vc6664; thicknesses];
vg_ux_both_vary = [vg_ux_nx62_vc6264, vg_ux_nx63_vc6364, vg_ux_nx64_vc6464, vg_ux_nx65_vc6564, vg_ux_nx66_vc6664; thicknesses];
