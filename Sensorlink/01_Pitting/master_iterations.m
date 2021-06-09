formatSpec = '%04d';
for pittingdepth = 3:1:40
%     display(pittingdepth*0.04)
    fieldname = ['model_' num2str(pittingdepth, formatSpec)];
    models.(fieldname) = make_random_model(400, 800, pittingdepth, [400], 0, 0);
    fieldname2 = ['output_' num2str(pittingdepth, formatSpec)];
    outputs.(fieldname2) = wave_simulate(400, models.(fieldname));
    outputs.(fieldname2) = output_analysis(outputs.(fieldname2));
    
end