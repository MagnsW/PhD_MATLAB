function [thickness, pVel, sVel] = model_stats(model)
%UNTITLED8 Summary of this function goes here
%   Detailed explanation goes here

model_def = model.sound_speed_compression > 2000;
thicknesses = sum(model_def, 1);
thickness.max = max(thicknesses);
thickness.min = min(thicknesses);
thickness.avg = mean(thicknesses);

pvel_def = model.sound_speed_compression.*model_def;
svel_def = model.sound_speed_shear.*model_def;

pVel.max = max(max(pvel_def(pvel_def>0)));
pVel.min = min(min(pvel_def(pvel_def>0)));
pVel.avg = mean(mean(pvel_def(pvel_def>0)));

sVel.max = max(max(svel_def(pvel_def>0)));
sVel.min = min(min(svel_def(pvel_def>0)));
sVel.avg = mean(mean(svel_def(pvel_def>0)));

end

