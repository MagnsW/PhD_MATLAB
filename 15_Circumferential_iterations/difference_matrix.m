function [output] = difference_matrix(array1, array2)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here


jmax = length(array1);
kmax = length(array2);
output = zeros(kmax, jmax);
for j=1:jmax
    for k=1:kmax
        output(k,j) = array1(j) - array2(k);
    end
end

end

