%%
Fs = 128; %Hz
dt = 1/Fs;
f1 = 5;
%f2 = 10;
source_mag = 1;

t_end = 1;

t = (0:dt:t_end-dt);

%freqs = [f1 f2];
randfreqs = f1*(0.5+rand(20,1));
rng(0)
randphases = pi*rand(50,1);

%%
figure;
plot(randfreqs)

%%
k = 0;
for i=1:length(randfreqs)
    freq = randfreqs(i);
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
features_table_test_04 = array2table(y,'VariableNames', features_titles);
writetable(features_table_test_04);
save('x_test_04.mat', 'x', '-v6');