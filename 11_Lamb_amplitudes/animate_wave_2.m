function animate_wave_2(data_analyzed)
[length_trace, num_traces] =  size(data_analyzed.d064_000_000_100.s_hilbert.ux.traces);

v = VideoWriter('animate_wave_avg.avi');
open(v);
figure('position', [500 100 1500 1000]) 


for i = 1:num_traces
    plot(data_analyzed.d064_000_000_100.data_decim.sensor_data.t_array, data_analyzed.d064_000_000_100.s_hilbert.ux.traces(:,i), 'b-')
    hold on
    plot(data_analyzed.d064_000_000_100.data_decim.sensor_data.t_array, data_analyzed.d064_012_000_100.s_hilbert.ux.traces(:,i), 'b:')
    plot(data_analyzed.d061_000_000_100.data_decim.sensor_data.t_array, data_analyzed.d061_000_000_100.s_hilbert.ux.traces(:,i), 'r-')
    plot(data_analyzed.d061_000_000_100.data_decim.sensor_data.t_array, data_analyzed.d061_012_000_100.s_hilbert.ux.traces(:,i), 'r:')
    
    yline(data_analyzed.d064_000_000_100.s_hilbert.ux.headers(2, i), 'b-')
    plot(data_analyzed.d064_000_000_100.data_decim.sensor_data.t_array, data_analyzed.d064_000_000_100.s_sensor_data_time.ux.traces(:,i), 'b-')
    
    yline(data_analyzed.d064_012_000_100.s_hilbert.ux.headers(2, i), 'b:')
    plot(data_analyzed.d064_000_000_100.data_decim.sensor_data.t_array, data_analyzed.d064_012_000_100.s_sensor_data_time.ux.traces(:,i), 'b:')
    
    
   
    yline(data_analyzed.d061_000_000_100.s_hilbert.ux.headers(2, i), 'r-')
    
    plot(data_analyzed.d061_000_000_100.data_decim.sensor_data.t_array, data_analyzed.d061_000_000_100.s_sensor_data_time.ux.traces(:,i), 'r-')
    
    yline(data_analyzed.d061_012_000_100.s_hilbert.ux.headers(2, i), 'r:')
    plot(data_analyzed.d061_000_000_100.data_decim.sensor_data.t_array, data_analyzed.d061_012_000_100.s_sensor_data_time.ux.traces(:,i), 'r:')
    
    set(gca, 'YLim',[-8e-8 8e-8]);
    set(gca,'xminorgrid','on','yminorgrid','on')

    title(['Trace number: ' int2str(i)])
    legend('12.8mm Uniform', '12.8mm Rough', '12.2mm Uniform', '12.2mm Rough')
    
    xlabel('time')
    ylabel('amplitude')
    drawnow
    hold off
    
    frame = getframe(gcf);
    writeVideo(v, frame)
end
close(v)
end