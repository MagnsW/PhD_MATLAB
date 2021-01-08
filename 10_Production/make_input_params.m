formatSpec = '%03d';

for thickness = 64:-1:61 %complete 64:-1:63
    for velcoeff=0.96:0.02:1.04
        fieldname = ['d' num2str(thickness, formatSpec) '_' num2str(0, formatSpec) '_' num2str(0, formatSpec) '_' num2str(velcoeff*100, formatSpec)];
        data_full.(fieldname).input_param.datasetname = (fieldname); %experimental. Delete if doesn't work
        data_full.(fieldname).input_param.thickness = thickness;
        data_full.(fieldname).input_param.velcoeff = velcoeff;
        data_full.(fieldname).input_param.pitting_depth = 0;
        data_full.(fieldname).input_param.seed = 0;
        
        
        for pitting_depth = 2:2:12 % complete 2:2:4
            for seedi = 0:1:2
                fieldname = ['d' num2str(thickness, formatSpec) '_' num2str(pitting_depth, formatSpec) '_' num2str(seedi, formatSpec) '_' num2str(velcoeff*100, formatSpec)];
                
                data_full.(fieldname).input_param.datasetname = (fieldname); %experimental. Delete if doesn't work
                data_full.(fieldname).input_param.thickness = thickness;
                data_full.(fieldname).input_param.velcoeff = velcoeff;
                data_full.(fieldname).input_param.pitting_depth = pitting_depth;
                data_full.(fieldname).input_param.seed = seedi;
                
                
                
            end
        end
    end
end