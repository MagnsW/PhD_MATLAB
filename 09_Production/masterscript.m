formatSpec = '%03d';
FileName = 'X:\Magnus\PhD\Matlab_data\09_Production\data_full.mat';
for thickness = 64:-1:63
    for velcoeff=0.96:0.02:1.04
        fieldname = ['d' num2str(thickness, formatSpec) '_' num2str(0, formatSpec) '_' num2str(0, formatSpec) '_' num2str(velcoeff*100, formatSpec)];
    %     A_decim.(fieldname) = 52;
    %     A_full.(fieldname) = 123;
        [data_full.(fieldname), data_decim.(fieldname)] = model_and_process(thickness, 0, 0, velcoeff)
        %model zero pitting
        if exist(FileName, 'file')
            save(FileName, '-struct', 'data_full', fieldname, '-append');
        else
            save(FileName, '-struct', 'data_full', fieldname);
            disp(['Creating file ' FileName]);
        end
        clear data_full
        for pitting_depth = 2:2:4
            for seedi = 0:1:2
                fieldname = ['d' num2str(thickness, formatSpec) '_' num2str(pitting_depth, formatSpec) '_' num2str(seedi, formatSpec) '_' num2str(velcoeff*100, formatSpec)];
    %             disp(fieldname);
    %             A_decim.(fieldname) = 42;
    %             A_full.(fieldname) = 351;
                [data_full.(fieldname), data_decim.(fieldname)] = model_and_process(thickness, pitting_depth, seedi, velcoeff)
    %             model
    %             save
                save(FileName, '-struct', 'data_full', fieldname, '-append');
                clear data_full
            end
        end
    end
end
       