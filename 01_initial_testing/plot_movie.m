figure
for n=1:40
    imagesc(squeeze(p(n,:,:))')
    colormap jet
    disp(n)
end