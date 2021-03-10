clear all

load simdata
% load invivoData
c0 = 1540;

%% delay validation
x = 0;
z = 1e-2;
TOF = ( z+sqrt( (x-elPosX ).^2 + z.^2) )/c0;

figure(1), imagesc( 1:size( RFdata,2), RF_t, 20*log10( abs( RFdata) ) );
hold on, plot( 1:size(RFdata, 2), squeeze( TOF ), 'k-x');
xlabel('Channel Nr');
ylabel('Time [s]');
title('Channel data and TOF curve')


%% beamforming

x = linspace( -2e-2, 2e-2, 256);
z = linspace( 0, 4.5e-2, 512);

[X, Z] = meshgrid( x, z);
TOF = zeros( length(z), length(x), length( elPosX) );

for kk = 1:length( elPosX),
    TOF(:,:, kk) = ( Z+sqrt( (X-elPosX(kk) ).^2 + Z.^2) )/c0;
end

delayedData = interpTOF( RFdata, RF_t, TOF);

bf_data = zeros( length( z), length( x) );
fnumber = 1.4;

% visualize expanding aperture apodization for x = 0
apodCenter = generateApod(elPosX, 0, z, fnumber);
figure(2), imagesc( 1:length(elPosX), z, apodCenter.')
xlabel('Chaannel number')
ylabel('Depth')
title('Expanding aperture apodization')

% do apodization for beamforming

for xind = 1:length( x),
    xpos = x(xind);

% uncomment the apodization of choice    
%     apod = repmat( ones(128,1) , 1, length( z) );
%     apod = repmat( hamming( 128), 1, length( z) );
%     apod = repmat( [hamming(32); zeros( 96,1)], 1, length( z) );
%     apod = repmat( [zeros( 48,1); hamming(32); zeros( 48,1)], 1, length( z) );
    apod = generateApod(elPosX, xpos, z, fnumber);

    bf_data(:,xind) = squeeze( sum( delayedData(:,:,xind).*apod, 1 ) );
end

gain = -105;
dyn = 60;
env_data = hilbert( bf_data);
figure(3); imagesc( x, z, 20*log10( abs( env_data ) ) ); caxis([-dyn 0]-gain)
colormap( gray)
axis equal tight
xlabel('Lateral position [m]');
ylabel('Depth [m]');
title('Beamformed image')