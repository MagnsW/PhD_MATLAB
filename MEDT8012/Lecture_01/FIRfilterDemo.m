% designs a standard FIR filter and annotates important filter properties
% Created: 13/01-2020, Joergen Avdal


fs = 30e6;          % sample frequency
filterorder = 30;   % filter order
cutoffFreq = 5e6;   % passband cutoff frequency
sb_cut = -50;

b = fir1( filterorder, cutoffFreq/(fs/2), 'low'); % filter coefficients

%% display filter coefficients
figure(1), hold off, stem( b, 'k-', 'LineWidth', 2);
xlabel('Sample nr');
ylabel('Value')
title('FIR filter coefficients (impulse response)');
set( gca, 'FontSize', 18);
set( gcf, 'Position', [489 287 705 475] );
%pause();

%% example signals
sig1 = zeros(1,50); sig1(20) = 1;
sig2 = zeros(1,50); sig2(20) = 1; sig2(21) = -1;

sig1_f = filter( b, 1, sig1);
sig2_f = filter( b, 1, sig2);

figure(2),
set( gcf, 'Position', [244 193 985 522] );
subplot(2,2,1), stem( sig1, 'k-', 'Linewidth', 2); title('Sig 1')
ylim([-1 1]);
subplot(2,2,2), stem( sig1_f, 'k-', 'Linewidth', 2); title('Sig 1 filtered')
subplot(2,2,3), stem( sig2, 'k-', 'Linewidth', 2); title('Sig 2')
subplot(2,2,4), stem( sig2_f, 'k-', 'Linewidth', 2); title('Sig 2 filtered')
%pause();

%% filter frequency response
Nfft = 512;
freqtab = linspace(-0.5, 0.5, Nfft+1)*fs/1e6; freqtab(end) = []; % frequency axis
powSpec = 20*log10( abs( fftshift( fft( b, Nfft) ) ) );

figure(3), hold off; plot( freqtab, powSpec, 'k-', 'Linewidth', 2);
set( gcf, 'Position', [109 162 1287 433] );
ylim([-100 30]);
grid on
title('Filter frequency response (Fourier transform of impulse response)')
xlabel('Frequency [MHz]');
ylabel('Amplitude [dB]');
set( gca, 'FontSize', 18);
drawnow
%pause();

%% find passband limits and display
pb_lim1 = freqtab( find( powSpec > -6, 1, 'first') );
pb_lim2 = freqtab( find( powSpec > -6, 1, 'last') );
figure(3);
yl = ylim;
xl = xlim;
hold on, h1 = plot( [1 1]*pb_lim1, yl, 'r--', 'LineWidth', 2);
hold on, h2 = plot( [1 1]*pb_lim2, yl, 'r--', 'LineWidth', 2);
hold on, h3 = plot( xl, [1 1]*-6, 'r--', 'Linewidth', 2);
title( 'Display passband, -6 dB cutoff');
pause();

delete(h1);
delete(h2);
delete(h3);
drawnow
title('')


%% display stopband

sb_lim1 = freqtab( find( powSpec > sb_cut, 1, 'first') );
sb_lim2 = freqtab( find( powSpec > sb_cut, 1, 'last') );
figure(3);
yl = ylim;
xl = xlim;
hold on, h1 = plot( [1 1]*sb_lim1, yl, 'b--', 'LineWidth', 2);
hold on, h2 = plot( [1 1]*sb_lim2, yl, 'b--', 'LineWidth', 2);
hold on, h3 = plot( xl, [1 1]*sb_cut, 'r--', 'Linewidth', 2);
title(['Display stopband, ' num2str( sb_cut) ' dB cutoff']);
pause();

delete(h1);
delete(h2);
delete(h3);

drawnow
title('')


%% display transition band
sb_lim1 = freqtab( find( powSpec > sb_cut, 1, 'first') );
sb_lim2 = freqtab( find( powSpec > sb_cut, 1, 'last') );
figure(3);
yl = ylim;
hold on, h1 = plot( [1 1]*pb_lim1, yl, 'r--', 'LineWidth', 2);
hold on, h2 = plot( [1 1]*pb_lim2, yl, 'r--', 'LineWidth', 2);
hold on, h3 = plot( [1 1]*sb_lim1, yl, 'r--', 'LineWidth', 2);
hold on, h4 = plot( [1 1]*sb_lim2, yl, 'r--', 'LineWidth', 2);
title('Display transition bands');
pause();

delete(h1);
delete(h2);
delete(h3);
delete(h4);
title('');

%% phase response
estDelay = mean( grpdelay(b, Nfft) );
estPhase = 2*pi*estDelay/fs*1e6; %radians/MHz
phaseResp = angle( fftshift( fft( b, Nfft) ) );
figure(4),
set( gcf, 'Position', [77 93 1299 653] );
subplot(2,1,1), hold off, plot( freqtab, phaseResp, 'k-', 'LineWidth', 2);

ylim([-pi pi]*2);
yl = ylim;
xl = xlim;
hold on, h1 = plot( [1 1]*pb_lim1, yl, 'r--', 'LineWidth', 2);
hold on, h2 = plot( [1 1]*pb_lim2, yl, 'r--', 'LineWidth', 2);
hold on, h3 = plot( [1 1]*sb_lim1, yl, 'b--', 'LineWidth', 2);
hold on, h4 = plot( [1 1]*sb_lim2, yl, 'b--', 'LineWidth', 2);
title('Filter phase response')
xlabel('Frequency [MHz]');
ylabel('Phase [radians]');
set( gca, 'FontSize', 18);
legend([h1 h3], {'Passband limits'; 'Stopband limits'})
subplot(2,1,2); hold off, stem( b, 'k-', 'LineWidth', 2);
xlabel('Sample nr');
ylabel('Value')
set( gca, 'FontSize', 18);
drawnow;
pause();
subplot(2,1,1);
title(['Estimated phase gradient: ' num2str(estPhase, '%.2f') ' radians/MHz'] );
pause();
title(['Corresponding group delay: ' num2str(estDelay, '%.1f') ' samples'] );
subplot(2,1,2), 
yl = ylim;
hold on, h11 = plot( [1 1]*(estDelay+1), yl, 'r--', 'LineWidth', 2);
legend(h11, 'Group delay');
ylim(yl);
pause();

%%
figure(5), subplot(2,1,1), hold off;
sig2_f_corr = sig2_f( estDelay+1:end);
h1 = stem( sig2_f_corr, 'r-', 'Linewidth', 2 );
hold on, h2 = stem( sig2, 'b-', 'Linewidth', 2 );
legend([h2 h1], {'Sig2'; 'Sig2 filtered, corrected for group delay'} ); 
subplot( 2,1,2);
hold off, plot( freqtab, 20*log10( abs( fftshift( fft( sig2, Nfft) ) ) ), 'k-', 'Linewidth', 2);
hold on, plot( freqtab, 20*log10( abs( fftshift( fft( sig2_f, Nfft) ) ) ), 'r-', 'Linewidth', 2);
hold on, plot( freqtab, powSpec, 'g-', 'Linewidth', 2);
set( gcf, 'Position', [109 162 1287 565] );
ylim([-100 30]);
grid on
title('Relation between original and filtered frequency content')
xlabel('Frequency [MHz]');
ylabel('Amplitude [dB]');
set( gca, 'FontSize', 18);
ylim([-130 20])
legend({'Sig 2'; 'Sig 2 filtered'; 'Filter frequency response'}, 'Location', 'S')
drawnow

