%%

profile_AZ_reduced = load('profile_AZ_7cm_reduced.mat');
profile_EL_reduced = load('profile_EL_7cm_reduced.mat');

figure
subplot(2,1,1)
imagesc(profile_AZ_reduced.RF)
subplot(2,1,2)
imagesc(profile_EL_reduced.RF)

profile_AZ_reduced.Intensity = sum(profile_AZ_reduced.RF.^2);
profile_EL_reduced.Intensity = sum(profile_EL_reduced.RF.^2);

profile_AZ_reduced.IntensitydB = 10*log10(profile_AZ_reduced.Intensity);
profile_EL_reduced.IntensitydB = 10*log10(profile_EL_reduced.Intensity);

profile_AZ_reduced.IntensitydBnorm = profile_AZ_reduced.IntensitydB - max(profile_AZ_reduced.IntensitydB);
profile_EL_reduced.IntensitydBnorm = profile_EL_reduced.IntensitydB - max(profile_EL_reduced.IntensitydB);

figure
subplot(2,1,1)
hold on
yline(-6, 'r')
plot(profile_AZ_reduced.Position(1,:)*1000, profile_AZ_reduced.IntensitydBnorm)
ylabel('dB')
xlabel('mm')
title('Azimutal Intensity')
grid on; grid minor;
hold off
subplot(2,1,2)
hold on
yline(-6, 'r')
plot(profile_EL_reduced.Position(2,:)*1000, profile_EL_reduced.IntensitydBnorm)
ylabel('dB')
xlabel('mm')
title('Elevation Intensity')
grid on; grid minor;
hold off