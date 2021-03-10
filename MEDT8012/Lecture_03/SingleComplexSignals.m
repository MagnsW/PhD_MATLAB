fs = 50;
f1 = 1; omega1 = 2*pi*f1;

modf = 2; omegamod = 2*pi*modf;

t = 0:1/fs:2;
s1 = exp( 1i*omega1*t);
% s2 = s1.*exp( 1i*pi/4);
s2 = s1.*exp( 1i*omegamod*t);


Nfft = length( t);
faxis = linspace(-0.5, 0.5-1/Nfft, Nfft);
freqresp = fftshift( 20*log10( abs( fft( s1, Nfft) ) ) );

figure(1);
set( gcf, 'Position', [488 98 481 703] );
for k = 1:length( t),
    subplot(2,1,1); hold off; plot( s1(max(1,k-5) :k), 'k-x'); 
    hold on; plot( s1(k), 'ro');
    
    subplot(2,1,1); hold on; plot( s2(max(1,k-5) :k), 'r-x'); 
    hold on; plot( s2(k), 'ro');
    
    xlim([-1 1]); ylim([-1 1]);
    xlabel('Real part'); ylabel('Imaginary part');

    subplot(2,1,2); hold off; plot( t(1:k), real(s1(1:k) ), 'k-x'); 
    
    subplot(2,1,2); hold on; plot( t(1:k), real(s2(1:k) ), 'r-x'); 
    xlabel('Time [s]'); ylabel('Real part'); 
    xlim([min(t) max(t)]); ylim([-1 1])
    
    
%     subplot(2,1,2); hold off; plot( faxis, freqresp, 'r-x'); 
%     xlabel('Frequency [Hz]'); ylabel('Amplitude [dB]')
    %     xlim([0 300]); ylim([-1 1] );
    drawnow;
    
%     M(k) = getframe(1);
    
    pause(0.01);
end