%%
% Sinusoid with random frequencies, phase, amplitude. Pulse instead of
% continous wave.
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
mus = 0.5*(0.5+rand(1000,1));

%%
figure;
plot(randamps)

%%
k = 0;
sigma = 0.1;
for i=1:length(min(randfreqs,randphases))
    freq = randfreqs(i);
    k = k+1;
    phase = randphases(i);
    amp = randamps(i);
    mu = mus(i);
    dist = gauss_distribution(t, mu, sigma)/4;
    y(k,1) = freq;
    y(k,2) = phase;
    y(k,3) = amp;
    y(k,4) = mu;
    x(k,:) = amp*cos(2*pi*freq*t + phase).*dist;
   
end
%y = y';
%x = x';


% %% Make normal distribution
% mu = 0.5;
% sigma = 0.1;
% %t_temp = (-1:dt:1);
% dist = gauss_distribution(t, mu, sigma)/4;
% 
% plot(t, dist)
% %hold on
% 
% x = x.*dist;


%%
figure
imagesc(x')

figure
plot(x(1,:))
hold on
plot(x(100,:))

%%
features_titles = {'Frequency', 'Phase', 'Amplitude', 'Mu'};
features_table_test_08 = array2table(y,'VariableNames', features_titles);
writetable(features_table_test_08);
save('x_test_08.mat', 'x', '-v6');

%%
function f = gauss_distribution(x, mu, s)
  p1 = -.5 * ((x - mu)/s) .^ 2;
  p2 = (s * sqrt(2*pi));
  f = exp(p1) ./ p2; 
end