fs = 1e8;
fc = 5e6;
bw = 0.5;

t = -1e-6:1/fs:1e-6;

sig = gauspuls(t, fc, bw);
figure(1); plot( t, sig, 'k-', 'LineWidth', 2);

%%
sig_hilb = hilbert(sig);

figure(2);
for kk = 6:length( sig)
    subplot(2,1,1), hold off; plot( sig);
    subplot(2,1,1), hold on, plot( abs( sig_hilb), 'r-' )
    hold on, plot( kk, sig(kk), 'rx');
    title('Envelope detection using hilbert transform')
    subplot(2,1,2); hold off; plot( sig_hilb(kk-5:kk), 'k-x');
    xlim([-1 1]);
    ylim([-1 1])
    drawnow;
    pause(0.02);
end

%%
