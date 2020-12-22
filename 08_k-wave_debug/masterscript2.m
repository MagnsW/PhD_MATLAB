% [data_full_64_8_1, data_decim_64_8_1] = model_and_process(64, 8, 1);
% [data_full_64_8_2, data_decim_64_8_2] = model_and_process(64, 8, 2);
% [data_full_64_8_3, data_decim_64_8_3] = model_and_process(64, 8, 3);
% [data_full_64_4_1, data_decim_64_4_1] = model_and_process(64, 4, 1);
% [data_full_64_4_2, data_decim_64_4_2] = model_and_process(64, 4, 2);
% [data_full_64_4_3, data_decim_64_4_3] = model_and_process(64, 4, 3);
% [data_full_64_2_1, data_decim_64_2_1] = model_and_process(64, 2, 1);
% [data_full_64_2_2, data_decim_64_2_2] = model_and_process(64, 2, 2);
% [data_full_64_2_3, data_decim_64_2_3] = model_and_process(64, 2, 3);
[d64_0_0, data_decim.d64_0_0] = model_and_process(64, 0, 0);
save('data_full.mat', 'd64_0_0')
clear d64_0_0
[d64_8_1, data_decim.d64_8_1] = model_and_process(64, 8, 1);
save('data_full.mat', 'd64_8_1', '-append')
clear d64_8_1

