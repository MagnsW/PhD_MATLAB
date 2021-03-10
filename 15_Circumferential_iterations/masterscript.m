formatSpec = '%03d';
FileName = 'data_circumferential.mat';
FileNameBackup = 'X:\Magnus\PhD\Matlab_data\15_Circumferential_iterations\data_circumferential.mat';
circ_nodes = 1280;

%% creating the struct
for thickness = 64:-1:61 
    for velcoeff=0.98:0.01:1.02
        fieldname = ['d' num2str(thickness, formatSpec) '_' num2str(0, formatSpec) '_' num2str(0, formatSpec) '_' num2str(velcoeff*100, formatSpec)];
%         disp(fieldname)
        data_circ.(fieldname).input_param.datasetname = (fieldname);
        data_circ.(fieldname).input_param.thickness = thickness;
        data_circ.(fieldname).input_param.velcoeff = velcoeff;
        data_circ.(fieldname).input_param.pitting_depth = 0;
        data_circ.(fieldname).input_param.seed = 0;
        data_circ.(fieldname).model = make_random_model(thickness, circ_nodes, 0, 0);
        for pitting_depth = 2:2:12 
            for seedi = 0:1:2
                fieldname = ['d' num2str(thickness, formatSpec) '_' num2str(pitting_depth, formatSpec) '_' num2str(seedi, formatSpec) '_' num2str(velcoeff*100, formatSpec)];
%                 disp(fieldname)
                data_circ.(fieldname).input_param.datasetname = (fieldname); 
                data_circ.(fieldname).input_param.thickness = thickness;
                data_circ.(fieldname).input_param.velcoeff = velcoeff;
                data_circ.(fieldname).input_param.pitting_depth = pitting_depth;
                data_circ.(fieldname).input_param.seed = seedi;
                data_circ.(fieldname).model = make_random_model(thickness, circ_nodes, pitting_depth, seedi);
                
            end
        end
                
    end
end

%% The simulation itself and saving
fn = fieldnames(data_circ);
for k=83:120 %numel(fn)
    disp([num2str(k) '-dataset name: ' data_circ.(fn{k}).input_param.datasetname]);
    [data_circ.(fn{k}).sensor_data, data_circ.(fn{k}).medium, data_circ.(fn{k}).dt, data_circ.(fn{k}).dx, data_circ.(fn{k}).dy] = lamb_simulate(data_circ.(fn{k}).input_param.thickness, data_circ.(fn{k}).input_param.velcoeff, data_circ.(fn{k}).model);
    disp('Simulation done');
    data_circ.(fn{k}).t_array = (1:length(data_circ.(fn{k}).sensor_data.ux))*data_circ.(fn{k}).dt;
    
    if exist(FileName, 'file')
        save(FileName, '-struct', 'data_circ', data_circ.(fn{k}).input_param.datasetname, '-append');
    else
        save(FileName, '-struct', 'data_circ' , data_circ.(fn{k}).input_param.datasetname) ;
        disp(['Creating file ' FileName]); 
    end
    
    if exist(FileNameBackup, 'file')
        save(FileNameBackup, '-struct', 'data_circ', data_circ.(fn{k}).input_param.datasetname, '-append');
    else
        save(FileNameBackup, '-struct', 'data_circ', data_circ.(fn{k}).input_param.datasetname);
        disp(['Creating file ' FileNameBackup]);
    end
    disp('Saving done');
end

%%
data_circ = load('data_circumferential.mat');
%% Post processing
fn = fieldnames(data_circ);
for j=1:numel(fn)
    if( isfield(data_circ.(fn{j}), 'sensor_data') )
        data_circ.(fn{j}).trace_ux_mean = mean(data_circ.(fn{j}).sensor_data.ux);
        data_circ.(fn{j}).analysis_ux = trace_analyse(data_circ.(fn{j}).trace_ux_mean, data_circ.(fn{j}).dt);
        disp(['Processing done on simulation no: ', num2str(j), ', Datasetname: ', data_circ.(fn{j}).input_param.datasetname]);       
    end
end