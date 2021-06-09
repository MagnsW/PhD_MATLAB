function plot_model(input)
figure
imagesc(input.kgrid.y_vec*1000, input.kgrid.x_vec*1000, input.medium.sound_speed_compression)
stats = input.model_stats.thickness;
dx = input.kgrid.dx*1000;
txt = {['Max: ' num2str(stats.max*dx)], 
       ['Min: ' num2str(stats.min*dx)], 
       ['Mean: ' num2str(stats.mean*dx)], 
       ['Median: ' num2str(stats.median*dx)],
       ['Std: ' num2str(stats.std*dx)],
       ['Measured uncomp: ' num2str(input.result.thickness_uncomp)],
       ['Measured comp: ' num2str(input.result.thickness_comp)]};
       
text(-15, -4,txt);

end
