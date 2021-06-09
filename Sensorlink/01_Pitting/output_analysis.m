function output = output_analysis(output)
%UNTITLED8 Summary of this function goes here
%   Detailed explanation goes here
output.model_stats = model_stats(output.medium);
[output.measurement, output.settings] = make_measurement(output);
output.result = wall_thickness_contact(output.measurement, output.settings);
end

