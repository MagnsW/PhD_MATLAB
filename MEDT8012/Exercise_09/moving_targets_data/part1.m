
%%
t_array = (0:s.iq.FramesIQ-1)*1/s.Framerate_fps;
d_array = (0:s.iq.SamplesIQ-1)*s.iq.DepthIncrementIQ_m + s.iq.StartDepthIQ_m;

figure
M_mode_matrix = abs(squeeze(iq(:,4,:)));
imagesc(t_array, d_array, 20*log10(M_mode_matrix));
colormap gray
dyn = 70;
gain = -90;
caxis([-dyn 0]-gain)
colorbar

hold on
R = 0.0070;
T = 0.9;
L = 0.1;
t0 = 0.072;

r = -R*cos(2*pi*(t_array-t0)/T)+L;
plot(t_array, r, 'LineWidth', 2)