function [measurement,settings] = make_measurement(input)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
measurement.trace = squeeze(mean(input.sensor_data.p));
measurement.sampling_delay = 0;
%measurement.nominal_thickness = input.model_stats.thickness.min*input.kgrid.dx*1000;
measurement.nominal_thickness = 5;
measurement.maximum_thickness = input.model_stats.thickness.max*input.kgrid.dx*1000;
measurement.temp_pipe = 20.0;
measurement.sampling_frequency = 1/input.kgrid.dt/1e6;
%measurement.reference = ;
%measurement.product_type
%measurement.default_bw1_offset = -999;
%measurement.startup_N = 
%measurement.use_corr_for_bw1 = 
measurement.temperature_coefficient = 0.000;

settings.speed_of_sound = input.model_stats.pVel.avg;

settings.temperature_offset = 20.0;
end

