function plot_qc(sensor_data, model, titleadd)
%UNTITLED16 Summary of this function goes here
%   Detailed explanation goes here
figure('position', [100 100 1000 1200]);
subplot(3,1,1)
imagesc(model.sound_speed_compression)
colorbar
title(strcat('Model ', titleadd))
subplot(3,1,2)
%imagesc(squeeze(sensor_data.ux(1,61:end,:))')
imagesc(squeeze(sensor_data.ux)')
title('ux')
subplot(3,1,3)
%imagesc(squeeze(sensor_data.p(1,61:end,:))')
imagesc(squeeze(sensor_data.p)')
title('p')
end

