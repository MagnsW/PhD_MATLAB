records = fieldnames(T);
%stack_all_dc = zeros(1, length(T.record_0000.a));
%figure
for k=1:numel(records)
    %display(T.(records{k}).datetime)
%     plot(T.(records{k}).stack_first_100-T.(records{k}).dc_correction);
%     hold on
    %stack_all_dc = [stack_all_dc; T.(records{k}).stack_first_100-T.(records{k}).dc_correction];
    stack_all_first_100(k,:) = T.(records{k}).stack_first_100;
    stack_all_first_500(k,:) = T.(records{k}).stack_first_500;    
    stack_all_first_100_dc(k,:) = T.(records{k}).stack_first_100-T.(records{k}).dc_correction;
    stack_all_first_500_dc(k,:) = T.(records{k}).stack_first_500-T.(records{k}).dc_correction;
    
    stack_all_last_100(k,:) = T.(records{k}).stack_last_100;
    stack_all_last_500(k,:) = T.(records{k}).stack_last_500;    
    stack_all_last_100_dc(k,:) = T.(records{k}).stack_last_100-T.(records{k}).dc_correction;
    stack_all_last_500_dc(k,:) = T.(records{k}).stack_last_500-T.(records{k}).dc_correction;
end
% hold off

%First and second echo
createfigure([stack_all_first_100_dc(:,1300:2800); stack_all_last_100_dc(:,1300:2800)]')
title({'First and second Echo', 'First 100 traces stacked for 64 measurements, then the last 100 traces stacked for 64 measurements. DC removed.'});

createfigure([stack_all_first_500_dc(:,1300:2800); stack_all_last_500_dc(:,1300:2800)]')
title({'First and second Echo', 'First 500 traces stacked for 64 measurements, then the last 500 traces stacked for 64 measurements. DC removed'});

createfigure([stack_all_first_100(:,1300:2800); stack_all_last_100(:,1300:2800)]')
title({'First and second Echo', 'First 100 traces stacked for 64 measurements, then the last 100 traces stacked for 64 measurements'});

createfigure([stack_all_first_500(:,1300:2800); stack_all_last_500(:,1300:2800)]')
title({'First and second Echo', 'First 500 traces stacked for 64 measurements, then the last 500 traces stacked for 64 measurements'});

%First echo trace length
createfigure([stack_all_first_100_dc(:,1300:1600); stack_all_last_100_dc(:,1300:1600)]')
title({'First Echo', 'First 100 traces stacked for 64 measurements, then the last 100 traces stacked for 64 measurements. DC removed.'});

createfigure([stack_all_first_500_dc(:,1300:1600); stack_all_last_500_dc(:,1300:1600)]')
title({'First Echo', 'First 500 traces stacked for 64 measurements, then the last 500 traces stacked for 64 measurements. DC removed'});

createfigure([stack_all_first_100(:,1300:1600); stack_all_last_100(:,1300:1600)]')
title({'First Echo', 'First 100 traces stacked for 64 measurements, then the last 100 traces stacked for 64 measurements'});

createfigure([stack_all_first_500(:,1300:1600); stack_all_last_500(:,1300:1600)]')
title({'First Echo', 'First 500 traces stacked for 64 measurements, then the last 500 traces stacked for 64 measurements'});

%Second echo trace length
createfigure([stack_all_first_100_dc(:,2400:2700); stack_all_last_100_dc(:,2400:2700)]')
title({'Second Echo', 'First 100 traces stacked for 64 measurements, then the last 100 traces stacked for 64 measurements. DC removed.'});

createfigure([stack_all_first_500_dc(:,2400:2700); stack_all_last_500_dc(:,2400:2700)]')
title({'Second Echo', 'First 500 traces stacked for 64 measurements, then the last 500 traces stacked for 64 measurements. DC removed'});

createfigure([stack_all_first_100(:,2400:2700); stack_all_last_100(:,2400:2700)]')
title({'Second Echo', 'First 100 traces stacked for 64 measurements, then the last 100 traces stacked for 64 measurements'});

createfigure([stack_all_first_500(:,2400:2700); stack_all_last_500(:,2400:2700)]')
title({'Second Echo', 'First 500 traces stacked for 64 measurements, then the last 500 traces stacked for 64 measurements'});

