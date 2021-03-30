E = 210000;
rho = 7850;
porat = 0.3;
h = 64*0.2/1000;
f = 50000;

c_ph = sqrt(pi*f*h*sqrt(E/(3*rho*(1-porat^2))));

gamma = 0.841;
c_s = 3230;

a = 1/c_ph + 1/(gamma*c_s)^3;
c_ph_fn_cub = 1/a;
c_ph_fn = c_ph_fn_cub^(1/3);