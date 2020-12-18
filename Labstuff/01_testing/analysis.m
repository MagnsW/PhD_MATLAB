t_sample = cast(t_sample, 'double');
t = 0:t_sample*4e-9:12249*t_sample*4e-9;
a_first = a(1:100,:);
a_last = a(901:end,:);
stack_full = mean(a);
stack_first = mean(a_first);
stack_last = mean(a_last);
dc_correction = mean(stack_full(1:200))
stack_first_dccorr = stack_first-dc_correction;
stack_last_dccorr = stack_last-dc_correction;
figure
plot(t, stack_first_dccorr)
hold on
plot(t, stack_last_dccorr)
legend('first', 'last')
hold off
xlim([0, 1e-4])