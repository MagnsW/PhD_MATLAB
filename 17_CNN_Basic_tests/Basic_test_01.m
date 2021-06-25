%%
Fs = 128; %Hz
dt = 1/Fs;
f1 = 5;
f2 = 10;
source_mag = 1;

t_end = 1;

t = (0:dt:t_end-dt);

freqs = [f1 f2];
rng(0)
randphases = pi*rand(200,1);

%%
figure;
plot(randphases)

%%
k = 0;
for i=1:length(freqs)
    freq = freqs(i);
    for j=1:length(randphases)
        k = k+1;
        phase = randphases(j);
        y(k,1) = freq;
        y(k,2) = phase;
        x(k,:) = source_mag*cos(2*pi*freq*t + phase);
    end    
end
%y = y';
%x = x';
%%
figure
imagesc(x')

%%
features_titles = {'Frequency', 'Phase'};
features_table_test_01 = array2table(y,'VariableNames', features_titles);
writetable(features_table_test_01);
save('x_test_01.mat', 'x', '-v6');