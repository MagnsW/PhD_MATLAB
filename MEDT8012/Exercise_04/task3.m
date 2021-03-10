clear all; close all

profile_AZ_Full = load('profile_AZ_7cm_Full.mat');
profile_EL_Full = load('profile_EL_7cm_Full.mat');

figure
subplot(2,1,1)
imagesc(profile_AZ_Full.RF)
subplot(2,1,2)
imagesc(profile_EL_Full.RF)

profile_AZ_Full.Intensity = sum(profile_AZ_Full.RF.^2);
profile_EL_Full.Intensity = sum(profile_EL_Full.RF.^2);

profile_AZ_Full.IntensitydB = 10*log10(profile_AZ_Full.Intensity);
profile_EL_Full.IntensitydB = 10*log10(profile_EL_Full.Intensity);

profile_AZ_Full.IntensitydBnorm = profile_AZ_Full.IntensitydB - max(profile_AZ_Full.IntensitydB);
profile_EL_Full.IntensitydBnorm = profile_EL_Full.IntensitydB - max(profile_EL_Full.IntensitydB);

figure
subplot(2,1,1)
hold on
plot(profile_AZ_Full.Position(1,:)*1000, profile_AZ_Full.IntensitydBnorm)
yline(-6, 'r')
ylabel('dB')
xlabel('mm')
title('Azimutal Intensity')
grid on; grid minor;
hold off
subplot(2,1,2)
hold on
plot(profile_EL_Full.Position(2,:)*1000, profile_EL_Full.IntensitydBnorm)
yline(-6, 'r')
ylabel('dB')
xlabel('mm')
title('Elevation Intensity')
grid on; grid minor;
hold off

%% Sinc function
lambda = 1540 / 2e6;
x_az = profile_AZ_Full.Position(1,:);
F_az = 7 / 1.853;
Df_az = 1.2*F_az*lambda*1000; %rule of thumb beam width (mm)

x_el = profile_EL_Full.Position(2,:);
F_el = 7 / 1.2;
Df_el = 1.2*F_el*lambda*1000; %rule of thumb beam width (mm)

sinc_az = sinc(x_az/(F_az*lambda));
sinc_el = sinc(x_el/(F_el*lambda));


sinc_az_powdb = 10*log10(sinc_az.^2); %using sinc(x/F# * lambda)
sinc_el_powdb = 10*log10(sinc_el.^2);

figure
subplot(2,1,1)
hold on
plot(x_az*1000, sinc_az)
xlabel('mm')
title('Azimutal Sinc')
grid on; grid minor;
hold off

subplot(2,1,2)
hold on
plot(x_el*1000, sinc_el)
ylabel('dB')
xlabel('mm')
title('Elevation Sinc')
grid on; grid minor;
hold off

figure
subplot(2,1,1)
hold on
plot(x_az*1000, sinc_az_powdb)
yline(-6, 'r')
ylabel('dB')
xlabel('mm')
title('Azimutal Intensity Sinc')
grid on; grid minor;
hold off

subplot(2,1,2)
hold on
plot(x_el*1000, sinc_el_powdb)
yline(-6, 'r')
ylabel('dB')
xlabel('mm')
title('Elevation Intensity Sinc')
grid on; grid minor;
hold off