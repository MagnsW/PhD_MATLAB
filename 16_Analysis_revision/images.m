%%
figure(1);
dataset = 'd063_012_001_100';
imagesc(data_circ.(dataset).medium.sound_speed_compression);
txt = ['Input Thickness: ' num2str(data_circ.(dataset).input_param.thickness) '; Pitting depth: ' num2str(data_circ.(dataset).input_param.pitting_depth)];
txt2 = ['Max Thickness: ' num2str(data_circ.(dataset).model_stats.thickness.max) '; Min Thickness: ' num2str(data_circ.(dataset).model_stats.thickness.min) '; Avg Thickness: ' num2str(data_circ.(dataset).model_stats.thickness.mean), '; Std Thickness: ' num2str(data_circ.(dataset).model_stats.thickness.std)];
text(600,20,txt, 'Fontsize', 12)
text(600,40,txt2, 'Fontsize', 12)
truesize
% axis equal

%%
seedi = 0;
thickness = 62;
velcoeff = 1;
pitting_depth = 0;
rowno = 1;
clear trace_acum trace_acum_random;
for kk=1:numel(fn)
    if data_circ.(fn{kk}).input_param.seed == seedi && data_circ.(fn{kk}).input_param.thickness == thickness %&& data_circ.(fn{kk}).input_param.velcoeff == velcoeff
        trace_acum(rowno,:) = data_circ.(fn{kk}).trace_ux_mean;
        env_acum(rowno,:) = data_circ.(fn{kk}).analysis_ux.envelope;
        trace_autocorr(rowno,:) = data_circ.(fn{kk}).analysis_ux.autocorrelation.signal;
        env_autocorr(rowno,:) = data_circ.(fn{kk}).analysis_ux.env_autocorr.c;
        rowno = rowno+1;
        
    end
end
% trace_acum_random = trace_acum(randperm(size(trace_acum,1)),:);

%%
%Vary thickness and velcoeff
formatSpec = '%03d';
s = 2;
n = 1;
clear fieldname trace_acum env_acum trace_autocorr env_autocorr;
for thickness = 61%64:-1:61
    for pitting_depth = 0:2:12
        if pitting_depth == 0
            seedi = 0;
        else
            seedi = s;
        end
        
        for velcoeff = 1.0 %1.02:-0.01:0.98
            fieldname{n,1} = ['d' num2str(thickness, formatSpec) '_' num2str(pitting_depth, formatSpec) '_' num2str(seedi, formatSpec) '_' num2str(velcoeff*100, formatSpec)];
            n=n+1;
        end
    end
end

for nn=1:numel(fieldname)
        trace_acum(nn,:) = data_circ.(fieldname{nn}).trace_ux_mean;
        env_acum(nn,:) = data_circ.(fieldname{nn}).analysis_ux.envelope;
        trace_autocorr(nn,:) = data_circ.(fieldname{nn}).analysis_ux.autocorrelation.signal;
        env_autocorr(nn,:) = data_circ.(fieldname{nn}).analysis_ux.env_autocorr.c;
        
        thickness_avg(nn,s+1) = data_circ.(fieldname{nn}).model_stats.thickness.mean;
        thickness_std(nn,s+1) = data_circ.(fieldname{nn}).model_stats.thickness.std;
        
end





%%
figure('position', [100 100 800 900]);
subplot(2,2,1)
imagesc(trace_acum')
title('Traces')
colormap jet
grid on; grid minor;
xlabel('Measurement number')
subplot(2,2,2)
imagesc(env_acum')
title('Envelopes')
colormap jet
% colorbar
% caxis([0 5]*1e-8)
grid on; grid minor;
xlabel('Measurement number')
subplot(2,2,3)
imagesc(trace_autocorr')
title('Trace autocorrelation')
colormap jet
grid on; grid minor;
xlabel('Measurement number')
subplot(2,2,4)
imagesc(env_autocorr')
title('Envelope autocorrelation')
colormap jet
% colorbar
% caxis([0 2]*1e-11)
grid on; grid minor;
xlabel('Measurement number')
sgtitle('Pitting development')
% sgtitle('Thickness reduction')
% sgtitle('Material velocity decrease')

%%
figure('position', [100 100 500 800])
subplot(2,1,1)
plot(0.2*thickness_avg)
grid on;
legend({'Seed 0', 'Seed 1', 'Seed 2'})
ylabel('Thickness mean [mm]')

subplot(2,1,2)
plot(0.2*thickness_std)
grid on;
legend({'Seed 0', 'Seed 1', 'Seed 2'}, 'Location', 'southeast')
ylabel('Thickness std [mm]')
sgtitle('Slow time development')
