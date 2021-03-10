%%
profile_AZ_full = load('profile_AZ_7cm_Full.mat');
profile_EL_full = load('profile_EL_7cm_Full.mat');
profile_AZ_reduced = load('profile_AZ_7cm_reduced.mat');
profile_EL_reduced = load('profile_EL_7cm_reduced.mat');

profile_AZ_full.Intensity = sum(profile_AZ_full.RF.^2);
profile_EL_full.Intensity = sum(profile_EL_full.RF.^2);

profile_AZ_full.IntensitydB = 10*log10(profile_AZ_full.Intensity);
profile_EL_full.IntensitydB = 10*log10(profile_EL_full.Intensity);

profile_AZ_full.IntensitydBnorm = profile_AZ_full.IntensitydB - max(profile_AZ_full.IntensitydB);
profile_EL_full.IntensitydBnorm = profile_EL_full.IntensitydB - max(profile_EL_full.IntensitydB);

profile_AZ_reduced.Intensity = sum(profile_AZ_reduced.RF.^2);
profile_EL_reduced.Intensity = sum(profile_EL_reduced.RF.^2);

profile_AZ_reduced.IntensitydB = 10*log10(profile_AZ_reduced.Intensity);
profile_EL_reduced.IntensitydB = 10*log10(profile_EL_reduced.Intensity);

profile_AZ_reduced.IntensitydBnorm = profile_AZ_reduced.IntensitydB - max(profile_AZ_reduced.IntensitydB);
profile_EL_reduced.IntensitydBnorm = profile_EL_reduced.IntensitydB - max(profile_EL_reduced.IntensitydB);

figure
subplot(2,1,1)
hold on
yline(-6, 'r--')
plot(profile_AZ_full.Position(1,:)*1000, profile_AZ_full.IntensitydBnorm)
plot(profile_AZ_reduced.Position(1,:)*1000, profile_AZ_reduced.IntensitydBnorm)
title('Azimuth direction')
legend('-6dB', 'Full aperture', 'Reduced aperture')
ylabel('dB')
xlabel('mm')
hold off
grid on; grid minor;

subplot(2,1,2)
hold on
yline(-6, 'r--')
plot(profile_EL_full.Position(2,:)*1000, profile_EL_full.IntensitydBnorm)
plot(profile_EL_reduced.Position(2,:)*1000, profile_EL_reduced.IntensitydBnorm)
title('Elevation direction')
legend('-6dB', 'Full aperture', 'Reduced aperture')
ylabel('dB')
xlabel('mm')
hold off
grid on; grid minor;