function decimdata = decim_data(data, startn, finishn, incrementn, transradn)
%DECIM_DATA Summary of this function goes here
%   Detailed explanation goes here
meanvalues = movmean(squeeze(data), 2*transradn, 1); 
%M = movmean(A,k) returns an array of local k-point mean values, where each mean is calculated over a sliding window of length k across neighboring elements of A.
decimdata = meanvalues(startn:incrementn:finishn-incrementn,:);
end

