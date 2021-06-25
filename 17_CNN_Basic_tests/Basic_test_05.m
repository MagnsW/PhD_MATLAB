%%
Fs = 128; %Hz
dt = 1/Fs;
f1 = 5;
%f2 = 10;
source_mag = 1;

t_end = 1;

t = (0:dt:t_end-dt);

%freqs = [f1 f2];
randfreqs = f1*(0.5+rand(1000,1));
rng(0)
randphases = pi*rand(1000,1);

%%
figure;
plot(randfreqs)

%%
k = 0;
for i=1:length(min(randfreqs,randphases))
    freq = randfreqs(i);
    k = k+1;
    phase = randphases(i);
    y(k,1) = freq;
    y(k,2) = phase;
    x(k,:) = source_mag*cos(2*pi*freq*t + phase);
   
end
%y = y';
%x = x';
%%
figure
imagesc(x')

%%
features_titles = {'Frequency', 'Phase'};
features_table_test_05 = array2table(y,'VariableNames', features_titles);
writetable(features_table_test_05);
save('x_test_05.mat', 'x', '-v6');