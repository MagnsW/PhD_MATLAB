function T = loadtraces()
for idx = 0:63
    formatSpec = 'imasonic_burst_nostack_%04.0f.mat';
    filename = sprintf(formatSpec, idx);
    formatfield = 'record_%04.0f';
    fieldname = sprintf(formatfield, idx);
    T.(fieldname) = load(filename);
    T.(fieldname).stack_full = mean(T.(fieldname).a);
    T.(fieldname).dc_correction = mean(T.(fieldname).stack_full(1:200));
    a_first_100 = T.(fieldname).a(1:100,:);
    a_last_100 = T.(fieldname).a(901:end,:);
    a_first_500 = T.(fieldname).a(1:500,:);
    a_last_500 = T.(fieldname).a(501:end,:);
    T.(fieldname).stack_first_100 = mean(a_first_100);
    T.(fieldname).stack_last_100 = mean(a_last_100);
    T.(fieldname).stack_first_500 = mean(a_first_500);
    T.(fieldname).stack_last_500 = mean(a_last_500);
    num_samples = length(T.(fieldname).a);
    t_sample = cast(T.(fieldname).t_sample, 'double');
    T.(fieldname).t = 0:t_sample*1e-9:(num_samples-1)*t_sample*1e-9;
    
end