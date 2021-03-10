clear all
close all

fs = 100;
fc = 3;
f1 = fc; omega1 = 2*pi*f1;
f2 = -fc; omega2 = 2*pi*f2;

t = 0:1/fs:1;
s1 = exp( 1i*omega1*t);
s2 = exp( 1i*omega2*t);
s3 = s1+s2;

figure(1);
set( gcf, 'Position', [488 98 481 703] );
for k = 1:length( t),
    subplot(2,1,1); hold off; h1 = plot( s1(max(1,k-10) :k), 'k-x', 'DisplayName', 's1'); 
    hold on; plot( s1(k), 'ko');
%     axis equal
%     drawnow;
    
    subplot(2,1,1); hold on; h2 = plot( s2(max(1,k-10) :k), 'r-x', 'DisplayName', 's2'); 
    hold on; plot( s2(k), 'ro');
%     axis equal
    
    subplot(2,1,1); hold on; h3 = plot( real( s3(max(1,k-10) :k) ), imag( s3(max(1,k-10) :k) ), 'g-x', 'DisplayName', 's1+s2'); 
    hold on; plot( real( s3(k) ), imag( s3(k) ), 'go');
    xlim([-2 2]); ylim([-2 2]);
    xlabel('Real part'); ylabel('Imaginary part');
    set( gca, 'FontSize', 18);
%     legend([h1 h2 h3])

    subplot(2,1,2);
    plot( t(1:k), s3(1:k), 'k-x');
    xlim([min(t) max(t)]); ylim([-2 2]);
    xlabel('Time'); ylabel('Amplitude');
    set( gca, 'FontSize', 18);

    drawnow;
%     M(k) = getframe(1);
    
    pause(0.05);
end