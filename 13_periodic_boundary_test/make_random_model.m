function outputArg1 = make_random_model(x_size,y_size, maxdepth, seed)
%make_random_model will return a matrix with 1s and 0s. The 1s will
%represent the model, the 0s will represent the background.
%The lower edge will be randomized to mimick roughness and pitting.

rng(seed);
r = randi([0 1],x_size,y_size);
r(maxdepth+1:end,:) = 1;
r(:,1:10) = 1;
r(:,end-10:end) = 1;
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
outputArg1 = flip(r);
end

