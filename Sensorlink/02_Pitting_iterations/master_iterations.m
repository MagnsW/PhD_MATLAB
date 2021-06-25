function [FeaturesTable, iterations] = master_iterations(numiterations)
    %% Makes table with iterations
    %numiterations = 1000;
    formatSpec = '%04d';
    %%
    rng(0)
    thicknesses = 400-randi(125, numiterations,1);
    pittingdepths = randi(125, numiterations, 1);
    pittingpositions = 400 + randi([-200 200], numiterations, 1); % change last number to 1 if only one pit.
    roughnesses = randi([30 70], numiterations, 1);
    seeds = randi(3, numiterations, 1);

    features_names = {'Thickness', 'PittingDepth', 'PittingPosition', 'Roughness'};
    FeaturesTable = table(thicknesses, pittingdepths, pittingpositions, roughnesses, 'VariableNames', features_names);
    
    TableFileName = 'features_table.csv';
    TableFileNameBackup = 'X:\Magnus\PhD\Matlab_data\Sensorlink\02_Pitting_iterations\features_table.csv';
    
    writetable(FeaturesTable, TableFileName);
    writetable(FeaturesTable, TableFileNameBackup);

    %% Prepare table

    for i =1:numiterations
        fieldname = ['model_' num2str(i, formatSpec)];
        iterations.(fieldname).input_params.thickness = thicknesses(i);
        iterations.(fieldname).input_params.pittingdepth = pittingdepths(i);
        iterations.(fieldname).input_params.pittingposition = pittingpositions(i,:);
        iterations.(fieldname).input_params.roughness = roughnesses(i);
        iterations.(fieldname).input_params.seed = seeds(i);
        iterations.(fieldname).model = make_random_model(thicknesses(i), 800, pittingdepths(i), pittingpositions(i,:), roughnesses(i), seeds(i));
    end
    %% Run simulations
    FileName = 'pitting_iterations_data.mat';
    FileNameBackup = 'X:\Magnus\PhD\Matlab_data\Sensorlink\02_Pitting_iterations\pitting_iterations_data.mat';
    
    fn = fieldnames(iterations);
    for k = 1:length(fn)
        disp(['Simulation start for iteration: ' fn{k}]);
        iterations.(fn{k}).simulation_results = wave_simulate(iterations.(fn{k}).input_params.thickness, iterations.(fn{k}).model);
        disp(['Simulation done for iteration: ' fn{k}]);
        iterations.(fn{k}).model_stats = model_stats(iterations.(fn{k}).simulation_results.medium);
        temp_signal = squeeze(mean(iterations.(fn{k}).simulation_results.sensor_data.p));
        temp_hilbert = abs(hilbert(temp_signal));
        temp_xcorr = xcorr(temp_signal);
        temp_hilbert_xcorr = xcorr(temp_hilbert);
        iterations.(fn{k}).trace.trace = temp_signal;
        iterations.(fn{k}).trace.trace_hilbert = temp_hilbert;
        iterations.(fn{k}).trace.trace_autocorr = temp_xcorr(floor(length(temp_xcorr)/2)+1:end);
        iterations.(fn{k}).trace.trace_hilbert_autocorr = temp_hilbert_xcorr(floor(length(temp_hilbert_xcorr)/2)+1:end);

        if exist(FileName, 'file')
            save(FileName, '-struct', 'iterations', fn{k}, '-append');
        else
            save(FileName, '-struct', 'iterations' , fn{k}) ;
            disp(['Creating file ' FileName]); 
        end
        
        

        if exist(FileNameBackup, 'file')
            save(FileNameBackup, '-struct', 'iterations', fn{k}, '-append');
        else
            save(FileNameBackup, '-struct', 'iterations' , fn{k}) ;
            disp(['Creating file ' FileNameBackup]); 
        end
        
        
        

        disp('Saving done');
    end

end
