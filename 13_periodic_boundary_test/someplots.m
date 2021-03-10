%%
env_ref = trace_analyse(trace_ref, dt);
env_rough = trace_analyse(trace_rough, dt);

%%
figure
hold on
plot(env_ref.cropped.s1,'r-','LineWidth',2)
plot(env_ref.cropped.env1, 'r:','LineWidth',2)
plot(env_ref.cropped.s2,'b-','LineWidth',2)
plot(env_ref.cropped.env2,'b:','LineWidth', 2)
plot(env_ref.cropped.s3,'g-','LineWidth',2)
plot(env_ref.cropped.env3,'g:','LineWidth', 2)
plot(env_ref.cropped.s4,'c-','LineWidth',2)
plot(env_ref.cropped.env4,'c:','LineWidth',2)

legend('source pulse', 'source env', 'rot 1', 'env', 'rot 2','env', 'rot 3','env')
hold off
title('Reference')
grid on

figure
hold on
plot(env_rough.cropped.s1,'r-','LineWidth',2)
plot(env_rough.cropped.env1, 'r:','LineWidth',2)
plot(env_rough.cropped.s2,'b-','LineWidth',2)
plot(env_rough.cropped.env2,'b:','LineWidth',2)
plot(env_rough.cropped.s3,'g-','LineWidth',2)
plot(env_rough.cropped.env3,'g:','LineWidth',2)
plot(env_rough.cropped.s4,'c-','LineWidth',2)
plot(env_rough.cropped.env4,'c:','LineWidth',2)

legend('source pulse', 'source env', 'rot 1', 'env', 'rot 2','env', 'rot 3','env')
hold off
title('Rough model')
grid on
