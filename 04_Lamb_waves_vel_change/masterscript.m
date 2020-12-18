% Constant echo time scenarios:
[sensor_data_nx62_vc6264, vc_6264] = lamb_simulate_velchange(62, 62/64);
save('sensor_data_nx62_vc6264.mat', 'sensor_data_nx62_vc6264', '-v7.3');
[sensor_data_nx63_vc6364, vc_6364] = lamb_simulate_velchange(63, 63/64);
save('sensor_data_nx63_vc6364.mat', 'sensor_data_nx63_vc6364', '-v7.3');
[sensor_data_nx64_vc6464, vc_6464] = lamb_simulate_velchange(64, 64/64);
save('sensor_data_nx64_vc6464.mat', 'sensor_data_nx64_vc6464', '-v7.3');
[sensor_data_nx65_vc6564, vc_6564] = lamb_simulate_velchange(65, 65/64);
save('sensor_data_nx65_vc6564.mat', 'sensor_data_nx65_vc6564', '-v7.3');
[sensor_data_nx66_vc6664, vc_6664] = lamb_simulate_velchange(66, 66/64);
save('sensor_data_nx66_vc6664.mat', 'sensor_data_nx66_vc6664', '-v7.3');

%Constant thickness scenarios
[sensor_data_nx64_vc6264, vc_6264] = lamb_simulate_velchange(64, 62/64);
save('sensor_data_nx64_vc6264.mat', 'sensor_data_nx64_vc6264', '-v7.3');
[sensor_data_nx64_vc6364, vc_6364] = lamb_simulate_velchange(64, 63/64);
save('sensor_data_nx64_vc6364.mat', 'sensor_data_nx64_vc6364', '-v7.3');
%[sensor_data_nx64_vc6464, vc_6464] = lamb_simulate_velchange(64, 64/64);
%save('sensor_data_nx64_vc6464.mat', 'sensor_data_nx64_vc6464', '-v7.3');
[sensor_data_nx64_vc6564, vc_6564] = lamb_simulate_velchange(64, 65/64);
save('sensor_data_nx64_vc6564.mat', 'sensor_data_nx64_vc6564', '-v7.3');
[sensor_data_nx64_vc6664, vc_6664] = lamb_simulate_velchange(64, 66/64);
save('sensor_data_nx64_vc6664.mat', 'sensor_data_nx64_vc6664', '-v7.3');

%Constant velocity scenarios
[sensor_data_nx62_vc6464, vc_6464] = lamb_simulate_velchange(62, 64/64);
save('sensor_data_nx62_vc6464.mat', 'sensor_data_nx62_vc6464', '-v7.3');
[sensor_data_nx63_vc6464, vc_6464] = lamb_simulate_velchange(63, 64/64);
save('sensor_data_nx63_vc6464.mat', 'sensor_data_nx63_vc6464', '-v7.3');
%[sensor_data_nx64_vc6464, vc_6464] = lamb_simulate_velchange(64, 64/64);
%save('sensor_data_nx64_vc6464.mat', 'sensor_data_nx64_vc6464', '-v7.3');
[sensor_data_nx65_vc6464, vc_6464] = lamb_simulate_velchange(65, 64/64);
save('sensor_data_nx65_vc6464.mat', 'sensor_data_nx65_vc6464', '-v7.3');
[sensor_data_nx66_vc6464, vc_6464] = lamb_simulate_velchange(66, 64/64);
save('sensor_data_nx66_vc6464.mat', 'sensor_data_nx66_vc6464', '-v7.3');
