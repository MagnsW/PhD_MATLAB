t_sample = cast(t_sample, 'double');
t = 0:t_sample*4e-9:12249*t_sample*4e-9;
a_first = a(1:500,:);
a_last = a(501:end,:);
stack_full = mean(a);
stack_first = mean(a_first);
stack_last = mean(a_last);
dc_correction = mean(stack_full(1:200))
stack_first_dccorr = stack_first-dc_correction;
stack_last_dccorr = stack_last-dc_correction;
subplot(2,1,1);
plot(t, stack_first_dccorr)
hold on
plot(t, stack_last_dccorr)
legend('first', 'last')
hold off
xcorr_first = xcorr(stack_first_dccorr, stack_first_dccorr);
xcorr_last = xcorr(stack_last_dccorr, stack_last_dccorr);
t2=-fliplr(t);
nl=min(t)+min(t2);
nh=max(t)+max(t2);
t_xcorr=nl:t_sample*4e-9:nh;
subplot(2,1,2);
plot(t_xcorr, xcorr_first)
hold on
plot(t_xcorr, xcorr_last)