x = ((1:1001)-501)*2e-6;
lambda = 1540 / 8e6;
f_hash = 2;
p = sinc(x/(f_hash*lambda));
figure
plot(x, p)
hold on
f_hash2 = 1;
p2 = sinc(x/(f_hash2*lambda));
plot(x, p2)
grid on; grid minor;
legend('F# = 2', 'F# = 1');
xlabel('x [m]');
yline(0.5);