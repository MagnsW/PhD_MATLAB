%%
% Dataformat: iq(packetindex, sampleindex, beamindex, frameindex)
% Task 1
load('carotid.mat');
%%
gain = -35;
dyn = 40;
iq2d = squeeze(iq(6,:,:,1));
imagelog(abs(iq2d).^2, gain, dyn)

%%
% Task 2

N = 4;
frameno = 5;


% Filter data with current order N.
% y=regressionfilter(squeeze(iq(:,:,:,frameno)),N);

%%
gain = -10;
dyn = 40;
frameno = 5;
packetno = 6;
iq1=iq(:,:,:,frameno);
figure()
for N=-1:4,
    subplot(2,3,N+2); % Create subplot.
    y=regressionfilter(iq1,N); % Filter frame with order N.
    y=squeeze(y(packetno,:,:)); % Remove singular dimension.
    imagelog(abs(y).^2,gain,dyn); % Show image.
    title(['N=',num2str(N)]); % Set title.
end
%%
% Task 3

frameno = 5;
iq1=squeeze(iq(:,:,:,frameno));
N=3;
y=regressionfilter(iq1,N);

packetsize=size(iq,1);
% Make two matrices with lag 1.
y1 = y(1:packetsize-1,:,:);
y2 = y(2:packetsize,:,:);
R1=conj(y1).*y2;
R1=squeeze(mean(R1));

%Spatial averaging of R ranges and B beams using a basic neighborhood 
%lowpass filter with all weights to 1/(RB).
R=10; B=3;
b=ones(R,B)/(R*B);
R1=filter2(b,R1);


%Find the phase angle.
phaseangle= angle(R1);
%Make an image of the phaseshift using default colormap.

%%
figure(8);colormap('default');
imagesc(phaseangle);
% Show colorbar.
colorbar;
title('Phaseangle');

%%
P=squeeze(mean(abs(y).^2));
% Spatial averaging.
P=filter2(b,P);
% Normalization.
P=P/max(P(:));

beta=10.^(-16/10);% 16 dB dynamic range
index=find(P<beta);% Get indexes.
phaseangle(index)=0;

%%
figure(9);colormap('default');
imagesc(phaseangle);
% Show colorbar.
colorbar;
title('Phaseangle');

%%
% Convert phase angle to velocity component along the beam direction and
% make an image of velocities with power thresholds
% The angle between the artery and the beam is about 5*pi/12 radians


