%%
load('simdata.mat')
%%

c = 1540; %Speed of sound
z0 = 0.01;

TOF_midchan = sqrt(elPosX.^2 + z0^2)/c + z0/c;
figure
plot(elPosX, TOF_midchan)
set(gca,'Ydir','reverse')

%%
dyn = 50;
gain = -70;
figure
imagesc([], RF_t, 20*log10(abs(RFdata)));
caxis([-dyn 0]-gain);
colormap gray
xlabel('Channel number')
ylabel('Time(s)')
hold on
plot(TOF_midchan, 'r:', 'LineWidth', 3)
hold off

%%
x = linspace( -2e-2, 2e-2, 256); %x-coordinates
z = linspace( 0, 4.5e-2, 512); %z-coordinates
[X, Z] = meshgrid( x, z); %make X and Z matrices
% initialize TOF-matrix
TOF = zeros( length(z), length(x), length(elPosX) );

for k=1:length(elPosX)
    TOF(:,:,k) = sqrt((X-elPosX(k)).^2 + Z.^2)/c + Z/c;
end
