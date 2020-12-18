p = sensor_data.p;
ux = sensor_data.ux;
uy = sensor_data.uy;

figure
imagesc(squeeze(p(1,:,:))')
colormap jet
title('p')

figure
imagesc(squeeze(ux(1,:,:))')
colormap jet
title('ux')

figure
imagesc(squeeze(uy(1,:,:))')
colormap jet
title('uy')

