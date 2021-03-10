close all

fs = 100;

f = 5;
omega = 2*pi*f;

t = -1:1/fs:1;
s = exp( 1i*omega*t);

fmod = 5;
omegamod = 2*pi*fmod;

A = hamming( length( t) ).'; %2*normpdf( t*4);

s2 = s.*exp( 1i*omegamod*t); %frequency modulation
% s2 = s.*A; %amplitude modulation

Nfft = length( t);
faxis = linspace(-0.5, 0.5-1/Nfft, Nfft)*fs;

figure(200),
for kk = 6:length(t),
    subplot(3,1,1); 
    hold off, plot( s(kk-5:kk), 'k-x');
    hold on, plot( s(kk), 'ro');
    
    hold on, plot( s2(kk-5:kk), 'r-x');
    hold on, plot( s2(kk), 'ro');
    
    xlim([-1 1]); ylim([-1 1]);
    xlabel('Real part'); ylabel('Imaginary part');
    
    subplot(3,1,2); hold off; plot( t(1:kk), real( s(1:kk) ), 'k-');
    hold on; plot( t(1:kk), real( s2(1:kk) ), 'r-');
    xlim([min(t) max(t)]);
    
    xlabel('Time [s]'); ylabel('Real part');
    
    
    subplot(3,1,3); hold off;
    plot( faxis, fftshift( 20*log10( abs( fft( s, Nfft) ) ) ) );
    hold on, plot( faxis, fftshift( 20*log10( abs( fft( s2, Nfft) ) ) ), 'r' );
    ylim([-100 50]);
    xlabel('Frequency [Hz]'); ylabel('Power [dB]');
    
    pause(0.01);
    
    drawnow
end