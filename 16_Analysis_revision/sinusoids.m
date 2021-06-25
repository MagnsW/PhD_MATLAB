

%%
t_end = 350e-6;
dt = 10e-9*100;
source_freq = 5e4;
source_mag = 0.5e-7;
t = (0:dt:t_end-dt);

%%
rng(0);
randfreqs = source_freq*(0.5+rand(20,1));
randphases = pi*rand(50,1);

%%
figure;
plot(randphases)

%%
k = 0;
for i=1:length(randfreqs)
    freq = randfreqs(i);
    for j=1:length(randphases)
        k = k+1;
        phase = randphases(j);
        y(1,k) = freq;
        y(2,k) = phase;
        x(k,:) = source_mag*cos(2*pi*source_freq*t + phase);
    end    
end
y = y';
x = x';

features_titles = {'Frequency', 'Phase'};
features_table_sinusoidal = array2table(y,'VariableNames', features_titles);
%%
writetable(features_table_sinusoidal);


%%

figure
imagesc(x');

%phi = pi/2;
%x = source_mag*cos(2*pi*source_freq*t + phi);


%%

%%
figure;
plot(t,x);
xlabel('time (in seconds)');
title('Signal versus Time');