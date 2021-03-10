
%%
figure
hold on
plot(data_circ.d064_000_000_098.analysis_ux.cropped_max_signal.s1,'r-','LineWidth',2)
plot(data_circ.d064_000_000_098.analysis_ux.cropped_max_env.s1, 'r:','LineWidth',2)
plot(data_circ.d064_000_000_098.analysis_ux.cropped_max_signal.s2,'b-','LineWidth',2)
plot(data_circ.d064_000_000_098.analysis_ux.cropped_max_env.s2,'b:','LineWidth', 2)
plot(data_circ.d064_000_000_098.analysis_ux.cropped_max_signal.s3,'g-','LineWidth',2)
plot(data_circ.d064_000_000_098.analysis_ux.cropped_max_env.s3,'g:','LineWidth', 2)
plot(data_circ.d064_000_000_098.analysis_ux.cropped_max_signal.s4,'c-','LineWidth',2)
plot(data_circ.d064_000_000_098.analysis_ux.cropped_max_env.s4,'c:','LineWidth',2)

legend('source pulse', 'source env', 'rot 1', 'env', 'rot 2','env', 'rot 3','env')
hold off
title('Reference')
grid on

figure
hold on
plot(data_circ.d064_002_000_098.analysis_ux.cropped_max_signal.s1,'r-','LineWidth',2)
plot(data_circ.d064_002_000_098.analysis_ux.cropped_max_env.s1, 'r:','LineWidth',2)
plot(data_circ.d064_002_000_098.analysis_ux.cropped_max_signal.s2,'b-','LineWidth',2)
plot(data_circ.d064_002_000_098.analysis_ux.cropped_max_env.s2,'b:','LineWidth', 2)
plot(data_circ.d064_002_000_098.analysis_ux.cropped_max_signal.s3,'g-','LineWidth',2)
plot(data_circ.d064_002_000_098.analysis_ux.cropped_max_env.s3,'g:','LineWidth', 2)
plot(data_circ.d064_002_000_098.analysis_ux.cropped_max_signal.s4,'c-','LineWidth',2)
plot(data_circ.d064_002_000_098.analysis_ux.cropped_max_env.s4,'c:','LineWidth',2)

legend('source pulse', 'source env', 'rot 1', 'env', 'rot 2','env', 'rot 3','env')
hold off
title('Rough model')
grid on
