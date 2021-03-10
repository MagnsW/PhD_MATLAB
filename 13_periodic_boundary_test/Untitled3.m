%%
figure
hold on
plot(analyzed_ref.cropped_max_signal.s1,'r-','LineWidth',1)
plot(analyzed_ref.cropped_max_env.s1, 'r:','LineWidth',2)
plot(analyzed_ref.cropped_max_signal.s2,'b-','LineWidth',1)
plot(analyzed_ref.cropped_max_env.s2,'b:','LineWidth', 2)
plot(analyzed_ref.cropped_max_signal.s3,'g-','LineWidth',1)
plot(analyzed_ref.cropped_max_env.s3,'g:','LineWidth', 2)
plot(analyzed_ref.cropped_max_signal.s4,'c-','LineWidth',1)
plot(analyzed_ref.cropped_max_env.s4,'c:','LineWidth',2)

hold off

grid on

%%
figure
hold on
plot(analyzed_rough.cropped_max_signal.s1,'r-','LineWidth',1)
plot(analyzed_rough.cropped_max_env.s1, 'r:','LineWidth',2)
plot(analyzed_rough.cropped_max_signal.s2,'b-','LineWidth',1)
plot(analyzed_rough.cropped_max_env.s2,'b:','LineWidth', 2)
plot(analyzed_rough.cropped_max_signal.s3,'g-','LineWidth',1)
plot(analyzed_rough.cropped_max_env.s3,'g:','LineWidth', 2)
plot(analyzed_rough.cropped_max_signal.s4,'c-','LineWidth',1)
plot(analyzed_rough.cropped_max_env.s4,'c:','LineWidth',2)

hold off

grid on

