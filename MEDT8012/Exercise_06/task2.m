%%
realigned_data = interpTOF(RFdata, RF_t, TOF);

figure
imagesc(squeeze(realigned_data(:,:,128))')
bf_RFdata = squeeze(sum(realigned_data));
figure
imagesc(bf_RFdata)

envelope = abs( hilbert( bf_RFdata) );

%%
dyn = 50;
gain = -110;
figure
imagesc(20*log10(envelope));
caxis([-dyn 0]-gain);
colorbar
colormap gray
xlabel('x')
ylabel('z')
title('Beamformed image using envelope')

%%
weighting1 = hamming(length(elPosX));
weighting2 = zeros(size(elPosX)); weighting2(48:79) = hamming(32);
weighting3 = zeros(size(elPosX)); weighting3(1:32) = hamming(32);
figure
hold on
plot(weighting1)
plot(weighting2)
plot(weighting3)
hold off
title('Hamming windows')
legend('All channels', 'Middle 32', 'First 32')

data1 = realigned_data .* weighting1;
bf_RFdata1 = squeeze(sum(data1));
envelope1 = abs( hilbert( bf_RFdata1) );

data2 = realigned_data .* weighting2;
bf_RFdata2 = squeeze(sum(data2));
envelope2 = abs( hilbert( bf_RFdata2) );

data3 = realigned_data .* weighting3;
bf_RFdata3 = squeeze(sum(data3));
envelope3 = abs( hilbert( bf_RFdata3) );


%%
dyn = 50;
gain = -110;
figure
imagesc(20*log10(envelope1));
caxis([-dyn 0]-gain);
colorbar
colormap gray
xlabel('x')
ylabel('z')
title('Hamming window on all channels')

dyn = 50;
gain = -110;
figure
imagesc(20*log10(envelope2));
caxis([-dyn 0]-gain);
colorbar
colormap gray
xlabel('x')
ylabel('z')
title('Hamming window on middle 32 channels. Zero weighting on the rest')

dyn = 50;
gain = -100;
figure
imagesc(20*log10(envelope3));
caxis([-dyn 0]-gain);
colorbar
colormap gray
xlabel('x')
ylabel('z')
title('Hamming window on first 32 channels. Zero weighting on the rest')
