%% Parameters (play with these)

f0 = 5e6;               %center frequency, default 5e6
BW = 0.3;               %pulse bandwidth, default 0.4
velInNyq = 0.65;        %velocity in Nyquist, default 0.2
nfirings = 64;          %number of firings, default 64

dt = 1e-9;              %1e-9 is recommended
showfirings = 27:38;    %fast time signals displayed, default 27:38
figno = 6;

%% Dependent parameters
t = -2e-6:dt:2e-6;

lookind = round( length(t)/2);
kktab = 1:nfirings;
nrshowfirings = length( showfirings);
sig = zeros( length( t), length(kktab) );
hsig = complex( zeros( length( t), length(kktab) ) );


%%
figure(figno), subplot( 1, 3, 1); hold off
for kk = 1:nfirings,
    sig(:,kk) = gauspuls(t+(kk-nfirings/2)*velInNyq/f0/2, f0, BW);
    hsig(:,kk) = hilbert( sig(:,kk));
end
for kk = 1:nrshowfirings
    plot( t, sig(:,showfirings(kk) )/3+showfirings(kk), 'k-' ); hold on
end

hold on, plot( t(lookind), sig(lookind,showfirings)/3+kktab(showfirings), 'kx', 'LineWidth', 1.5 );

set( gca, 'ytick', 1:nfirings);
set( gca, 'xtick', []);
set( gca, 'ydir', 'reverse');
grid on
ylim([min( showfirings)-0.5 max( showfirings)-0.5]);
xlim([-2e-6 2e-6]);
ylabel('Slow time (Firing nr)');
xlabel('Fast time');
title(['v = ' num2str( velInNyq) ' vNyq'] );

figure(figno); subplot( 2, 3, 2);
plot( sig(lookind,:), 'k-x');
title('RF slow time signal');
xlabel('Slow time')

figure(figno); subplot( 2, 3, 5);
plot( hsig(lookind,:), 'k-x');
xlim([-1 1]); ylim([-1 1] );
xlabel('Real part'); ylabel('Imag part')
title('IQ slow time signal');

Nfft = 128;
wfunc = hamming( nfirings).';
vaxis = linspace( -1, 1, Nfft+1); vaxis( end ) = [];
figure(figno); subplot( 2, 3, 6);
plot( vaxis, 20*log10( abs( fftshift( fft( wfunc.*hsig(lookind, :), Nfft ) ) ) ), 'k-' );
xlim([-1 1]); ylim([-60 40]);
title(['Power spectrum (' num2str(nfirings) ' firings)']);
xlabel('Velocity [vNyq]'); ylabel('Amplitude [dB]');