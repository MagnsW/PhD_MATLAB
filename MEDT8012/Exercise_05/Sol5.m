% load phantomRFdata2.mat
load cardiacRFdata.mat

%%
c = 1540;
t = (0:size(rf,1)-1).'/p.frs_Hz+p.startdepth_m*2/c;

lp_f = fir1(100, 0.1, 'low').'; %fundamental
iq_f = rf.* exp(-1i*2*pi*p.f0_Hz*t); % fundamental

lp_h = fir1(100, 0.01, 'low').'; % harmonic
iq_h = rf.* exp(-1i*2*pi*(2*p.f0_Hz)*t); % harmonic


iq_f_filt = filter2( lp_f, iq_f);
iq_h_filt = filter2( lp_h, iq_h);

Nfft = 8192;
freqtab = linspace(-0.5, 0.5, Nfft+1); freqtab(end) = [];

figure
hold on 
plot( freqtab, 20*log10( abs( fftshift( fft( lp_f, Nfft ) ) ) ) )
plot( freqtab, 20*log10( abs( fftshift( fft( lp_h, Nfft ) ) ) ) )

figure
hold on 
plot( freqtab, 20*log10( abs( fftshift( fft( iq_f(:,64), Nfft ) ) ) ) )
plot( freqtab, 20*log10( abs( fftshift( fft( iq_h(:,64), Nfft ) ) ) ) )

figure
hold on 
plot( freqtab, 20*log10( abs( fftshift( fft( iq_f_filt(:,64), Nfft ) ) ) ) )
plot( freqtab, 20*log10( abs( fftshift( fft( iq_h_filt(:,64), Nfft ) ) ) ) )

figure
hold on, plot( t, rf(:,64) );
hold on, plot( t, 2*abs( iq_f_filt(:,64) ) ); % envelope will not match for harmonic

figure
hold on, plot( t, rf(:,64) );
hold on, plot( t, 2*abs( iq_h_filt(:,64) ) ); % envelope will not match for harmonic

r = t*c/2;
theta = (0:size( iq_f, 2)-1)*p.angleincrement_rad + p.startangle_rad;

[iq_sc_f, x, z] = scanconvert(iq_f, r, theta.');
figure 
imagesc( x*1e3, z*1e3, 20*log10( abs( iq_sc_f) ) );

[iq_sc_h, x, z] = scanconvert(iq_h, r, theta.');
figure
imagesc( x*1e3, z*1e3, 20*log10( abs( iq_sc_h) ) );