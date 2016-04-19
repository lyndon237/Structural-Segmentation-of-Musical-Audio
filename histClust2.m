function [smoothIDXkmeans,smoothIDXhacEu] = histClust2(X,k,boundaries)
n = length(X);
kk = length(boundaries);
zz = 7;
% if nargin < 4
%         metric = 'emd';
% end

%creating X_hat
for i1 = 1:(boundaries(1)-zz)
      X_hat(i1,:) = X(i1:i1+zz);
      beat(i1,:) = i1:i1+zz;
end
   
for j = 1:kk-1
    for i2 = boundaries(j):(boundaries(j+1)-zz)
      X_hat(i2,:) = X(i2:i2+zz);
      beat(i2,:) = i2:i2+zz;
    end
end
for i3 = boundaries(kk):(n-zz)
     X_hat(i3,:) = X(i3:i3+zz);
     beat(i3,:) = i3:i3+zz;
end

%removing any zeros from X_hat and beat
 X_hat =X_hat(any(X_hat,2),:);
 beat = beat(any(beat,2),:);
 [m,~] = size(X_hat);  
 
%Now creating a vector containing the histogram of states for eacch
%grouping of zz beats
  nChordState = zeros(length(X_hat),24);
  for i = 1:m
    for j = 1:zz+1
        if X_hat(i,j)~= 0
            nChordState(i,X_hat(i,j))= nChordState(i,X_hat(i,j))+1;
        end
    end
  end

%doing kmeans clustering 
%if strcmp(metric,'euclidean')  
[IDXkmeans, centers, ~, D] = kmeans(nChordState,k);
%else if strcmp(metric, 'emd')
    %insert code for EMD clustering
    %end
%end
IDXbeatkmeans = zeros(1,length(X));

for i = 1:length(IDXkmeans)
    for j = 1:size(beat,2)
        IDXbeatkmeans(beat(i,j))=IDXkmeans(i);
    end
end
smoothIDXkmeans = boundSmooth(IDXbeatkmeans,boundaries);
 figure(4)
 title('Cluster indices with boundary smoothing for k-means');
 hold on;
 for i = 1:length(IDXbeatkmeans)
     scatter(i,smoothIDXkmeans(i),'b','filled');
 end
 hold off;


%EP-means clustering
%  IDXepmeans = epmeans(nChordState,k);
%  IDXbeatepmeans = zeros(1,length(X));
%  for i = 1:length(IDXepmeans)
%      for j = 1:size(beat,2)
%          IDXbeatepmeans(beat(i,j))=IDXepmeans(i);
%      end
%  end
%  smoothIDXepmeans = IDXbeatepmeans;
% % %smoothIDXepmeans = smoothCommonest(IDXbeatepmeans,boundaries,'noboundary',7);
% % %smoothIDXepmeans = boundSmooth(IDXbeatepmeans,boundaries);
%  figure(5)
%   title('Cluster indices for EP-means');
%   hold on;
%   for i = 1:length(IDXbeatepmeans)
%       scatter(i,smoothIDXepmeans(i),'b','filled');
%   end
%   hold off;


%doing HAC clustering using Euclidean distance
IDXhacEu = hAC(nChordState,k,'euclidean');
IDXbeathacEu = zeros(1,length(X));
for i = 1:length(IDXhacEu)
    for j = 1:size(beat,2)
        IDXbeathacEu(beat(i,j))=IDXhacEu(i);
    end
end
smoothIDXhacEu = boundSmooth(IDXbeathacEu,boundaries);
figure(5)
 title('Cluster indices with boundary smoothing for Euclidean HAC');
 hold on;
 for i = 1:length(IDXbeathacEu)
     scatter(i,smoothIDXhacEu(i),'b','filled');
 end
 hold off;

% %doing HAC clustering using Earth Mover's Distance
% IDXhacEmd = hAC(nChordState,k,'emd');
% IDXbeathacEmd = zeros(1,length(X));
% for i = 1:length(IDXhacEmd)
%     for j = 1:size(beat,2)
%         IDXbeathacEmd(beat(i,j))=IDXhacEmd(i);
%     end
% end
% smoothIDXhacEmd = boundSmooth(IDXbeathacEmd,boundaries);
% figure(7)
%  title('Cluster indices with boundary smoothing for EMD-HAC');
%  hold on;
%  for i = 1:length(IDXbeathacEmd)
%      scatter(i,smoothIDXhacEmd(i),'b','filled');
%  end
%  hold off;



% figure(4)
% title('Cluster indices without smoothing');
% hold on;
% for i = 1:length(IDXbeatkmeans)
%     scatter(i,IDXbeatkmeans(i),'b','filled');
% end
% hold off;
%smoothIDX = smoothCommonest(IDX,boundaries,'boundary',0); 
end