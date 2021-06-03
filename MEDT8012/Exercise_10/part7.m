%%
load('slowmotion.mat');
iqmm = squeeze(iq(:,round(end/2),:));
x=iqmm(round(end/2),:);
x=[x,x,x,x,x];

soundsc(real(x));
figure(); plot(real(x));