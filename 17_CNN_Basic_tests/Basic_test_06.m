%%
% Sinusoid with random frequencies, phase, amplitude
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
randamps = source_mag * rand(1000,1);

%%
figure;
plot(randamps)

%%
k = 0;
for i=1:length(min(randfreqs,randphases))
    freq = randfreqs(i);
    k = k+1;
    phase = randphases(i);
    amp = randamps(i);
    y(k,1) = freq;
    y(k,2) = phase;
    y(k,3) = amp;
    x(k,:) = amp*cos(2*pi*freq*t + phase);
   
end
%y = y';
%x = x';
%%
figure
imagesc(x')

figure
plot(x(1,:))
hold on
plot(x(100,:))

%%
features_titles = {'Frequency', 'Phase', 'Amplitude'};
features_table_test_06 = array2table(y,'VariableNames', features_titles);
writetable(features_table_test_06);
save('x_test_06.mat', 'x', '-v6');