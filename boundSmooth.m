function smoothIDX = boundSmooth(IDX,boundaries)
n = length(IDX);
smoothIDX = zeros(1,n);
j = 1;
for i = 1:length(boundaries)
    smoothIDX(j:boundaries(i)-1) = mode(IDX(j:boundaries(i)-1));
    j = boundaries(i);
end
smoothIDX(boundaries(end):n) = mode(IDX(boundaries(end):n));
end