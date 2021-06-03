%%
load('fastmotion.mat')
t_array = (0:s.iq.FramesIQ-1)*1/s.Framerate_fps;
d_array = (0:s.iq.SamplesIQ-1)*s.iq.DepthIncrementIQ_m + s.iq.StartDepthIQ_m;

frames = s.iq.FramesIQ;
depthindex = 1:s.iq.SamplesIQ;
framerate = s.Framerate_fps;
timeaxis = t_array;
dyn = 30; gain = -90;

% Tip: This is an excerpt of the code, you must fill in the rest
%----------------------------------------------------------
iqmm = squeeze(iq(:,round(end/2),:));
Nfft=64; %Zeropadding to length 64
crop=16;
P=zeros(Nfft, frames-crop+1);
for n=1:frames-crop+1
    iqsegm=iqmm(depthindex,n+[0:crop-1])';
    iqsegm=iqsegm.*(hamming(crop)*ones(1,length(depthindex)));
    P(:,n)=mean(abs(fftshift(fft(iqsegm,Nfft))).^2,2);
end
%Frequency axis
frequencyaxis=(([0:Nfft-1]/Nfft)-0.5)*framerate;
%Grayscale image of frequency specter in dB
figure(), imagesc(timeaxis, frequencyaxis, 10*log10(P) );
caxis([-dyn 0]-gain)

colormap gray
title('Doppler spectrum of fastmotion.mat')

%%
P = [P;P;P];
frequencyaxis=([0:Nfft-1]/Nfft)-0.5;
frequencyaxis=[frequencyaxis-1, frequencyaxis, frequencyaxis+1]*framerate;

figure(), imagesc(timeaxis, frequencyaxis, 10*log10(P) );
caxis([-dyn 0]-gain)

colormap gray