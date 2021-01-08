figure
subplot(7,1,1)
imagesc(data_decim.d064_000_000_100.model.sound_speed_compression)
axis equal
title(['Max depth = 0; Thickness stats (max;min;avg): ' num2str(data_decim.d064_000_000_100.model.stats.thickness.max) ';' num2str(data_decim.d064_000_000_100.model.stats.thickness.min) ';' num2str(data_decim.d064_000_000_100.model.stats.thickness.avg)])
%set(gca,'xtick',[])
subplot(7,1,2)
imagesc(data_decim.d064_002_000_100.model.sound_speed_compression)
axis equal
title(['Max depth = 2; Thickness stats (max;min;avg): ' num2str(data_decim.d064_002_000_100.model.stats.thickness.max) ';' num2str(data_decim.d064_002_000_100.model.stats.thickness.min) ';' num2str(data_decim.d064_002_000_100.model.stats.thickness.avg)])
% set(gca,'xtick',[])
subplot(7,1,3)
imagesc(data_decim.d064_004_000_100.model.sound_speed_compression)
axis equal
title(['Max depth = 4; Thickness stats (max;min;avg): ' num2str(data_decim.d064_004_000_100.model.stats.thickness.max) ';' num2str(data_decim.d064_004_000_100.model.stats.thickness.min) ';' num2str(data_decim.d064_004_000_100.model.stats.thickness.avg)])
%set(gca,'xtick',[])
subplot(7,1,4)
imagesc(data_decim.d064_006_000_100.model.sound_speed_compression)
axis equal
title(['Max depth = 6; Thickness stats (max;min;avg): ' num2str(data_decim.d064_006_000_100.model.stats.thickness.max) ';' num2str(data_decim.d064_006_000_100.model.stats.thickness.min) ';' num2str(data_decim.d064_006_000_100.model.stats.thickness.avg)])
%set(gca,'xtick',[])
subplot(7,1,5)
imagesc(data_decim.d064_008_000_100.model.sound_speed_compression)
axis equal
title(['Max depth = 8; Thickness stats (max;min;avg): ' num2str(data_decim.d064_008_000_100.model.stats.thickness.max) ';' num2str(data_decim.d064_008_000_100.model.stats.thickness.min) ';' num2str(data_decim.d064_008_000_100.model.stats.thickness.avg)])
%set(gca,'xtick',[])
subplot(7,1,6)
imagesc(data_decim.d064_010_000_100.model.sound_speed_compression)
axis equal
title(['Max depth = 10; Thickness stats (max;min;avg): ' num2str(data_decim.d064_010_000_100.model.stats.thickness.max) ';' num2str(data_decim.d064_010_000_100.model.stats.thickness.min) ';' num2str(data_decim.d064_010_000_100.model.stats.thickness.avg)])
%set(gca,'xtick',[])
subplot(7,1,7)
imagesc(data_decim.d064_012_000_100.model.sound_speed_compression)
axis equal
title(['Max depth = 12; Thickness stats (max;min;avg): ' num2str(data_decim.d064_008_000_100.model.stats.thickness.max) ';' num2str(data_decim.d064_012_000_100.model.stats.thickness.min) ';' num2str(data_decim.d064_012_000_100.model.stats.thickness.avg)])
%set(gca,'xtick',[])