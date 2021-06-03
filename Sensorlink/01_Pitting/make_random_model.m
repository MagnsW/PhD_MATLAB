function outputArg1 = make_random_model(x_size,y_size, maxdepth, numpits, fact, seed)
%make_random_model will return a matrix with 1s and 0s. The 1s will
%represent the model, the 0s will represent the background.
%The lower edge will be randomized to mimick roughness and pitting.

rng(seed);
r = randi(100,x_size,y_size);
r = r>fact;
r(maxdepth+1:end,:) = 1;
r(:,1:100) = 1;
r(:,end-100:end) = 1;
for idx = 2:x_size
    for idy = 1:y_size
        if r(idx-1, idy) == 1
            r(idx, idy) = 1;
        end
    end
end

for idx2 = x_size-1:-1:1
    for idy2 = 1:y_size
        if idy2 == 1
            if r(idx2+1, idy2) == 0
                r(idx2, idy2:idy2+1) = 0;
            end
        elseif idy2 == y_size
            if r(idx2+1, idy2) == 0
                r(idx2, idy2-1:idy2) = 0;
            end 
        else
            if r(idx2+1, idy2) == 0
                r(idx2, idy2-1:idy2+1) = 0;
            end
        end
    end
end

pitlocations = randi([maxdepth y_size-maxdepth], numpits, 1);
r(maxdepth, pitlocations) = 0;
for idy3 = 1:y_size
    if r(maxdepth,idy3) == 0
        r(maxdepth,idy3-randi([3 6]):idy3) = 0; 
    end
end
for idx3 = maxdepth:-1:1
    for idy4 = 1:y_size
        if r(idx3+1, idy4) == 0
            r(idx3, idy4-randi([0 1]):idy4+randi([0 1])) = 0;
        end
    end
end

outputArg1 = flip(r);
end

