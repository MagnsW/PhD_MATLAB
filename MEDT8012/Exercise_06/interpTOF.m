function delayedData = interpTOF(RFdata, RF_t, TOF),

delayedData = zeros( size(TOF,3)*size( TOF, 1), size( TOF, 2) );
chDataNr = 1:size( RFdata,2);
for kk = 1:size( TOF, 2),
    wrapTOF = TOF(:,kk,:);
    wrapTOF = permute( wrapTOF, [3 2 1] );
    wrapTOF = wrapTOF(:);
    delayedData(:,kk) = interp2( chDataNr, RF_t, RFdata, repmat( chDataNr.', size(TOF,1), 1), wrapTOF, 'linear', 0 );
end
delayedData = reshape( delayedData, size(TOF,3), size( TOF, 1), size( TOF, 2) );
