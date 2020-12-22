function decimdata = decim_data(data, startn, finishn, incrementn, transradn)
%DECIM_DATA Summary of this function goes here
%   Detailed explanation goes here
meanvalues = movmean(squeeze(data), transradn, 1);
decimdata = meanvalues(startn:incrementn:finishn-incrementn,:);
end

