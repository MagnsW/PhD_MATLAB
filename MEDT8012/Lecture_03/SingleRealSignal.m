fs = 50;
f1 = 2; omega1 = 2*pi*f1;
f2 = -2; omega2 = 2*pi*f2;

t = 0:1/fs:2;
s1 = cos( omega1*t);
% s2 = exp( 1i*omega2*t);

figure(1);
set( gcf, 'Position', [488 98 481 703] );
for k = 1:length( t),
    subplot(2,1,1); hold off; plot( real( s1(1:k) ), 'k-x'); 
    xlim([0 length(t)]); ylim([-1 1] );
    xlabel('Sample nr'); ylabel('Amplitude');

    subplot(2,1,2); hold off; plot( real( s1(max(1,k-5) :k) ), imag( s1(max(1,k-5) :k) ), 'k-x'); 
    hold on; plot( real( s1(k) ), imag( s1(k) ), 'ro');
    xlim([-1 1]); ylim([-1 1]);
    xlabel('Real part'); ylabel('Imaginary part')
%     axis equal
    drawnow;
    

    drawnow;
    
    pause(0.01);
end