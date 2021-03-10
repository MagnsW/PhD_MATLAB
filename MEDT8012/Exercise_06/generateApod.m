function apod = generateApod(elPosX, xpos, z, fnumber)
pitch = elPosX(2)-elPosX(1);
leftedge = elPosX(1)-pitch/2;

apsize = max( z/fnumber, 5e-3); %mininum aperture size
leftx = xpos-apsize/2;
rightx = xpos+apsize/2;

firstel = max( floor( (leftx-leftedge)/pitch), 1);
lastel = min( floor( (rightx-leftedge)/pitch), length(elPosX) );

apod = zeros( 128, length(z) );
for zind = 1:length(z),
    apod( firstel(zind):lastel(zind), zind ) = hamming( lastel(zind)-firstel(zind)+1);
end