% LAMB WAVE DISPERSION CURVE EDITOR
% E = Young's Modulus 
% v = Poisson's Ratio
% D = Density
% d = Material Thickness
% mode = Number of modes 
% len = Minimum interval
% maxf = Maximum Frequency.
% cps and cpa are phase velocities of symmetric and antisymmetric modes
% respectively, similarly for cga and cgs
% LambDispersion(E,v,D,d,mode,len,maxf)
% example
% [cps,cpa,cgs,cga] = LambDispersion(7.24e+10,0.33,2780,2,5,10,20000);

E = 209e+9;
v = 0.29;
D = 7850;
d = 0.0128;
mode = 7;
len = 2;
maxf = 20000;

[cps,cpa,cgs,cga] = LambDispersion(E,v,D,d,mode,len,maxf);
