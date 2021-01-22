% simple ultrasound simulator, not 100% accurate, but designed to
% illustrate the impact of fundamental parameters.

% Created 19/01/21 by Joergen Avdal

global f_demod
global actApSz
global nrCycles
global dyn
global gain
global focdepth
global fighandle
global img
global attFact

attFact = 0.5; % db/cm/MHz

img = randn( 256,256);
img(50:50:250, 50:50:250) = 200;


if ~exist( 'fighandle') && ~isempty(fighandle),
    close( fighandle)
end

setupGUI;

function setupGUI

global f_demod
global actApSz
global nrCycles
global dyn
global gain
global focdepth
global fighandle
global img
global attFact



f_demod = 5e6;
actApSz = 0.01;
nrCycles = 1;
dyn = 60;
gain = -30;
focdepth = 1.5e-2;
reCalc;

t1 = uicontrol('Parent',fighandle, 'units', 'normalized', 'Style','text','Position',[0.8,0.44,0.15,0.05],...
              'String', 'Frequency [MHz]');
e1 = uicontrol('Parent',fighandle, 'units', 'normalized', 'Style','edit','Position',[0.8,0.4,0.15,0.05],...
              'value',5, 'min',0, 'max',1, 'Callback', @freqSelect, 'String', num2str( f_demod/1e6) );

t2 = uicontrol('Parent',fighandle, 'units', 'normalized', 'Style','text','Position',[0.8,0.34,0.15,0.05],...
              'String', 'Pulse cycles');
e2 = uicontrol('Parent',fighandle, 'units', 'normalized', 'Style','edit','Position',[0.8,0.3,0.15,0.05],...
              'value',5, 'min',0, 'max',1, 'Callback', @cycSelect, 'String', num2str( nrCycles) );

t3 = uicontrol('Parent',fighandle, 'units', 'normalized', 'Style','text','Position',[0.8,0.64,0.15,0.05],...
              'String', 'Dyn. range [dB]');
e3 = uicontrol('Parent',fighandle, 'units', 'normalized', 'Style','edit','Position',[0.8,0.6,0.15,0.05],...
              'value',5, 'min',0, 'max',1, 'Callback', @dynSelect, 'String', num2str( dyn) );

t4 = uicontrol('Parent',fighandle, 'units', 'normalized', 'Style','text','Position',[0.8,0.54,0.15,0.05],...
              'String', 'Gain [dB]');
e4 = uicontrol('Parent',fighandle, 'units', 'normalized', 'Style','edit','Position',[0.8,0.5,0.15,0.05],...
              'value',5, 'min',0, 'max',1, 'Callback', @gainSelect, 'String', num2str( gain) );


t5 = uicontrol('Parent',fighandle, 'units', 'normalized', 'Style','text','Position',[0.8,0.24,0.15,0.05],...
              'String', 'Tx Focdepth[mm]');
e5 = uicontrol('Parent',fighandle, 'units', 'normalized', 'Style','edit','Position',[0.8,0.2,0.15,0.05],...
              'value',5, 'min',0, 'max',1, 'Callback', @focSelect, 'String', num2str( focdepth*1e3) );

t6 = uicontrol('Parent',fighandle, 'units', 'normalized', 'Style','text','Position',[0.8,0.14,0.15,0.05],...
              'String', 'Tx Aperture [mm]');
e6 = uicontrol('Parent',fighandle, 'units', 'normalized', 'Style','edit','Position',[0.8,0.1,0.15,0.05],...
              'value',5, 'min',0, 'max',1, 'Callback', @txApSelect, 'String', num2str( actApSz*1e3) );

t7 = uicontrol('Parent',fighandle, 'units', 'normalized', 'Style','pushbutton','Position',[0.8,0.84,0.15,0.05],...
              'String', 'Reset', 'Callback', @resetGUI);
          
end
          

function resetGUI(src, event)
setupGUI;
end

function freqSelect(src, event)
global f_demod
    try
        f_demod = str2double( get( src, 'String') )*1e6;
        reCalc;
    catch
        set( src, 'String', num2str( f_demod/1e6) );
    end
end


function fnumSelect(src, event)
global actApSz
    try
        actApSz = str2double( get( src, 'String') );
        reCalc;
    catch
        set( src, 'String', num2str( actApSz) );
    end
end

function cycSelect(src, event)
global nrCycles
    try
        nrCycles = str2double( get( src, 'String') );
        reCalc;
    catch
        set( src, 'String', num2str( nrCycles) );
    end
end


function dynSelect(src, event)
global dyn
    try
        inpval = str2double( get( src, 'String') );
        if inpval > 0,
            dyn = inpval;
            reCalc;
        else
            set( src, 'String', num2str( dyn) );
        end
    catch
        set( src, 'String', num2str( dyn) );
    end
end

function gainSelect(src, event)
global gain
    try
        gain = str2double( get( src, 'String') );
        reCalc;
    catch
        set( src, 'String', num2str( gain) );
    end
end

function focSelect(src, event)
global focdepth
    try
        focdepth = str2double( get( src, 'String') )/1e3;
        reCalc;
    catch
        set( src, 'String', num2str( focdepth*1e3) );
    end
end

function txApSelect(src, event)
global actApSz
    try
        actApSz = str2double( get( src, 'String') )/1e3;
        reCalc;
    catch
        set( src, 'String', num2str( actApSz*1e3) );
    end
end




function reCalc()
global f_demod
global actApSz
global nrCycles
global dyn
global gain
global focdepth
global fighandle
global img
global attFact

axBW = 1/nrCycles;
c = 1540;

lambda5 = 1540/5e6; %f_demod;
dx = lambda5/2;
dz = lambda5/2;

lambda = 1540/f_demod;
x = linspace(-0.5, 0.5, size( img, 2) )*dx*(size( img, 2)-1);
z = (0:size( img,1)-1 )*dz;

imgTGC = img.*(10.^(-attFact/20*z.'*100*f_demod/1e6*2) );
imgTGC = imgTGC + randn( size( imgTGC) )*0.05;
imgTGC = imgTGC.*(10.^(attFact/20*z.'*100*f_demod/1e6*2) );




Ftx = focdepth/(actApSz);
DOF = 2*Ftx.^2*lambda;
Frx = Ftx;
focW = Ftx*lambda;
lim1 = focdepth-DOF/2;
lim2 = focdepth+DOF/2;
stWidth = max( actApSz, focW);
beamW_part1 = stWidth*abs( (lim1-z)/lim1 )+focW*z/lim1;
beamW_part2 = stWidth*abs( (lim2-z)/lim2 )+focW*z/lim2;
beamW_part3 = ones( size( z) )*Inf;
beamW_part3( (z>lim1) & (z<lim2) ) = focW;
beamW_est = min( min( beamW_part1, beamW_part2), beamW_part3);

Ftx_depth = beamW_est/focW*Ftx;
Ftxrx = ( (Ftx).^(-1)+Frx.^(-1) ).^(-1); %dev
Frx = 2; %Ftx_depth/2; Frx( Frx > 4) = 4;
Ftxrx_depth = ( (Ftx_depth).^(-1)+Frx.^(-1) ).^(-1); %dev

angspan = atan(1./(4*Ftxrx));

kx = linspace(-0.5, 0.5, size( imgTGC, 2)+1 )/dx; kx(end) = [];
kz = linspace(-0.5, 0.5, size( imgTGC, 1)+1 )/dz +2*f_demod/c; kz(end) = [];

[KX, KZ] = meshgrid( kx, kz);

avals = -atan2( KZ, KX)+pi/2;
kvals = sqrt( KX.^2 + KZ.^2);

% avalmid = -atan2( 2*f_demod/c, KX)+pi/2;
avalmid = (-atan2( 2*f_demod/c, KX)+pi/2).*(Ftxrx_depth.'/Ftxrx );
kvalmid = KZ;


currangle = 0;
currscale = 1;
avaltab = (-angspan:0.01:angspan)+currangle; %4:0.01:6;
kvaltab = ( (1-axBW/2:0.01:1+axBW/2)+(currscale-1) )*2*f_demod/c;
awind = hamming( length( avaltab) );
kwind = hamming( length( kvaltab) );
amask = interp1( avaltab, awind, avalmid, 'linear', 0);
kmask = interp1( kvaltab, kwind, kvalmid, 'linear', 0);

currfft = fftshift( fftshift( fft2( imgTGC ) ) );

% u_img = ifft2( currfft.*amask.*kmask );
u_img = ifft( currfft.*kmask, [], 1 );
u_img = ifft( u_img.*amask, [], 2 );

m=5; n=5;
spinds = ( (1:m-1)+m*(0:n-1).'); spinds = spinds(:);
fighandle = figure(10); subplot(m,n,spinds); hold off, imagesc( x*1e3,z*1e3,20*log10( abs( u_img) ) );
xlabel('[mm]');
ylabel('[mm]');
title('Ultrasound Lab Exercise, Corona Version')
set( gca, 'FontSize', 12);
colormap( gray)
caxis([-dyn 0]-gain);
axis equal tight
end