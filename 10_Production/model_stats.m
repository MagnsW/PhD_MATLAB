function stats = model_stats(model)
%UNTITLED8 Summary of this function goes here
%   Detailed explanation goes here

model_def = model.sound_speed_compression > 2000;
thicknesses = sum(model_def, 1);
stats.thickness.max = max(thicknesses);
stats.thickness.min = min(thicknesses);
stats.thickness.mean = mean(thicknesses);
stats.thickness.median = median(thicknesses);
stats.thickness.std = std(thicknesses);
stats.thickness.var = var(thicknesses);

pvel_def = model.sound_speed_compression.*model_def;
svel_def = model.sound_speed_shear.*model_def;

stats.pVel.max = max(max(pvel_def(pvel_def>0)));
stats.pVel.min = min(min(pvel_def(pvel_def>0)));
stats.pVel.avg = mean(mean(pvel_def(pvel_def>0)));

stats.sVel.max = max(max(svel_def(pvel_def>0)));
stats.sVel.min = min(min(svel_def(pvel_def>0)));
stats.sVel.avg = mean(mean(svel_def(pvel_def>0)));

end

