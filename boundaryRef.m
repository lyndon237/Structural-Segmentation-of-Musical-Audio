function [boundary,A,B] = boundaryRef(trueSeg,tempo)
A = cell2mat(trueSeg(:,1));
B = cell2mat(trueSeg(:,2));
n = length(A);
beatLength = 60/tempo;
boundary2 = zeros(n,1);
boundary2(1) = round(A(1)/beatLength);
for k = 2:1:n
    boundary2(k) = boundary2(k-1)+round((B(k)-A(k))/beatLength);
end
boundary = boundary2;
end
