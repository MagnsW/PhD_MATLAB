figure('position', [100 100 1200 200])
imagesc(model.sound_speed_compression)
title('Rough model')
axis equal
colorbar

figure('position', [100 100 1200 200])
imagesc(model_ref.sound_speed_compression)
title('Reference model')
axis equal
colorbar 

figure('position', [100 100 1200 200])
imagesc(model.density)
title('Rough model')
axis equal
colorbar