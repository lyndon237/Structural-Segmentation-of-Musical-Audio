function IDXhac = hAC(X, k, metric)
if strcmp(metric,'euclidean')
    Y = pdist(X);
    Z = linkage(Y,'complete');
    IDXhac = cluster(Z, 'maxclust', k);
else
    %normalize X so that the histogram reflects probability
    Xnorm = zeros(size(X));
    for i = 1:size(X,1)
      for j = 1:size(X,2)
        Xnorm(i,j) = X(i,j)/sum(X(i,:));
      end
    end
    D = pdist2(Xnorm,Xnorm,'emd');
    %converting D from a matrix to a vector, Y in the format used in the
    %linkage function
    n = size(X,1);
    Y = zeros(n*(n-1)/2,1);
    k = 1;
    for i = 1:(n-1);
        for j = (i+1):n
          Y(k) = D(j,i);
          k = k+1;
        end
    end
    Z = linkage(Y,'complete');
    IDXhac = cluster(Z,'maxclust',k);
end
end
