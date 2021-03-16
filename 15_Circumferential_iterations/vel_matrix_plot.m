function vel_matrix_plot(dataset)

figure
colormap('jet')
subplot(3,1,1)
pcolor(dataset.analysis_ux.ph_velocity_matrix.s2)
colorbar
title('Hypothetic phase velocities from source to first pass')
caxis([0 5000])
subplot(3,1,2)
pcolor(dataset.analysis_ux.ph_velocity_matrix.s2)
colorbar
title('Hypothetic phase velocities from first to second pass')
caxis([0 5000])
subplot(3,1,3)
pcolor(dataset.analysis_ux.ph_velocity_matrix.s3)
colorbar
title('Hypothetic phase velocities from second to third pass')
caxis([0 5000])