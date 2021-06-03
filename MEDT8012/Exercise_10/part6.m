%%
load('Dopplerdata.mat');
frames = length(iq);
framerate = prf;
timeaxis = (0:frames-1)*1/framerate;
fasttimeaxis = (0:size(iq, 1))*1/fs;
dyn = 30; gain = -40;
figure(1);
imagesc(timeaxis, 1e6*fasttimeaxis, 10*log10(abs(iq)));
caxis([-dyn 0]-gain)

colormap gray
title('M-Mode image of Dopplerdata.mat')
xlabel('Slow time [s]');
ylabel('Fast time [mikroseconds]');

%%
dyn = 30; gain = -60;

Nfft=256; %Zeropadding to length 256
figure(2);

N=10;
b=ones(1,N); %=boxcar(N). May also use hamming(N), hanning(N), ....
b=b/sum(b); %Normalization of filter coefficients
iq_lp=filter(b,1,iq,[],2); %Filter along rows
iq_hp=iq-iq_lp; %Subtract low pass component:
iq_hp;
% iq_hp = iq;

kk=1;
for crop=[8 16 32 64]
    % crop=16;
    P=zeros(Nfft, frames-crop+1);
    depthindex=[70:80];
    for n=1:frames-crop+1
        iqsegm=iq_hp(depthindex,n+[0:crop-1])';
        iqsegm=iqsegm.*(hamming(crop)*ones(1,length(depthindex)));
        P(:,n)=mean(abs(fftshift(fft(iqsegm,Nfft))).^2,2);
    end
    %Frequency axis
    frequencyaxis=(([0:Nfft-1]/Nfft)-0.5)*framerate;
    %Grayscale image of frequency specter in dB
    P = [P;P;P];
    frequencyaxis=([0:Nfft-1]/Nfft)-0.5;
    frequencyaxis=[frequencyaxis-1, frequencyaxis, frequencyaxis+1]*framerate;

    subplot(2,2,kk)
    imagesc(timeaxis, frequencyaxis, 10*log10(P) );
    caxis([-dyn 0]-gain)

    colormap gray

    title(['crop=' num2str(crop) ', N=' num2str(N)])
%     title(['crop=' num2str(crop) ', N=Not filtered'])
    kk = kk+1;
end