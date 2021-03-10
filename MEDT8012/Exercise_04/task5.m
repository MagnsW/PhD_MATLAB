%%

load('z_axis_12dB.mat')

Intensity = sum(RF.^2);
IntensitydB = 10*log10(Intensity);
IntensitydBnorm = IntensitydB - max(IntensitydB);

figure
plot(Position(3,:)*1000, IntensitydBnorm) 
ylabel('dB')
xlabel('mm')
title('Intensity along beam axis')
grid on; grid minor;

