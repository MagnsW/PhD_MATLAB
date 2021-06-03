%%
load('slowmotion_clutter.mat')
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
title('slowmotion_clutter.mat')

%% Filtered
% A simple lowpass filter:
dyn = 30; gain = -90;

figure();
for N=2:10
    b=ones(1,N); %=boxcar(N). May also use hamming(N), hanning(N), ....
    b=b/sum(b); %Normalization of filter coefficients
    iq_lp=filter(b,1,iqmm,[],2); %Filter along rows
    iq_hp=iqmm-iq_lp; %Subtract low pass component:

    Pfilt=zeros(Nfft, frames-crop+1);
    for n=1:frames-crop+1
        iqsegm=iq_hp(depthindex,n+[0:crop-1])';
        iqsegm=iqsegm.*(hamming(crop)*ones(1,length(depthindex)));
        Pfilt(:,n)=mean(abs(fftshift(fft(iqsegm,Nfft))).^2,2);
    end
    %Frequency axis
    frequencyaxis=(([0:Nfft-1]/Nfft)-0.5)*framerate;
    %Grayscale image of frequency specter in dB

    subplot(3,3,N-1)
    imagesc(timeaxis, frequencyaxis, 10*log10(Pfilt) );
    caxis([-dyn 0]-gain)

    colormap gray
    title(['High pass filtered, N=' int2str(N)])
end

%% M-mode image of highpass filtered signal

dyn = 30;
gain = -40;
N=5;
b=ones(1,N); %=boxcar(N). May also use hamming(N), hanning(N), ....
b=b/sum(b); %Normalization of filter coefficients
iq_lp=filter(b,1,iqmm,[],2); %Filter along rows
iq_hp=iqmm-iq_lp; %Subtract low pass component:

raw = abs(iqmm);
lp = abs(iq_lp);
hp = abs(iq_hp);
figure('Position',[100 100 500 900]);
subplot(3,1,1)
imagesc(t_array, 100*d_array, 10*log10(raw))
title('Raw')
caxis([-dyn 0]-gain)
xlabel('Time [s]')
ylabel('Depth [cm]')
subplot(3,1,2)
imagesc(t_array, 100*d_array, 10*log10(lp))
title(['Low pass filtered, N=' num2str(N)])
caxis([-dyn 0]-gain)
xlabel('Time [s]')
ylabel('Depth [cm]')
subplot(3,1,3)
imagesc(t_array, 100*d_array, 10*log10(hp))
title(['High pass filtered, N=' num2str(N)])
caxis([-dyn 0]-gain)
colormap gray
xlabel('Time [s]')
ylabel('Depth [cm]')