function [shifts, abstime, projected_time] = findshift(array1, array2)
%UNTITLED4 Will find shifts(differences) between numbers in array1 and
%numbers in array2. Will return sorted matrix with increasing absolute
%difference.
%   Array1 is the maximum values of the autocorrelation of the envelope
%   Array2 is the maximum values of the autocorrelation of the trace
diffmat = zeros(length(array2), length(array1));
for i = 1:length(array2)
    for j = 1:length(array1)
        diffmat(i,j) = array2(i) - array1(j);
    end
end

[M, I] = sort(abs(diffmat));
for k = 1:size(I,2)
    temp = diffmat(:,k);
    shifts(:,k) = temp(I(:,k));
end

abstime = shifts + array1;
%projected_time = abstime(:,1); %First rotation
for kk = 1:size(I,2)
    projected_time(:,kk) = abstime(:,1)*kk;
end
projected_time = projected_time(1:5,:);


end

