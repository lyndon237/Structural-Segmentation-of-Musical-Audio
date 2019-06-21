function [boundaries, H, peaks, boundIDX, ff] = boundaryDetect(C)

%C is the matrix containing the sequence of chroma feature vectors for each
%beat
%tempo is the tempo of the song extracted using the beat detection
%algorithm
n = size(C,2);
S = zeros(n); %Initializing the self-similarity matrix S
C = C/max(max(C)); %normalizing C
kc = 96; %size of Gaussian kernel for the novelty measure
for i = 1:n
    for j = 1:n
        S(i,j) = norm(C(:,i)-C(:,j));
    end
end

%ker = fspecial('gaussian', kc, 500); %creating the Gaussian Kernel

sigma = kc/6; %standard deviation for the gaussian tapering of the checkerboard kernel
% 
[X,Y] = meshgrid(-(kc/2)+1:kc/2, -(kc/2)+1:kc/2); %creating the Gaussian kernel
kersmooth = exp(-(X.^2 + Y.^2)/(2*sigma.^2));
kersmooth = kersmooth/max(max(kersmooth)); %The Gaussian tapering matrix
ker = kron([1 -1; -1 1],ones(kc/2,kc/2)); %The checkerboard kernel
ker = kersmooth.*ker;
%mesh(ker);

N = zeros(1,n); %Initializing the vector of novelty measures
for i = 1:n
 for j = ((-1*kc/2)+1):1:(kc/2)
    for k = ((-1*kc/2)+1):1:(kc/2)
%         if (i+j)<=0&&(i+k)<=0
%             N(i) = ker((kc/2)+j,(kc/2)+k)*S(n+j+i,n+k+i);
%         elseif (i+j)<=0 && (i+k)>0
%             N(i) = ker((kc/2)+j,(kc/2)+k)*S(n+j+i,i+k);
%         elseif (i+j)>0 && (i+k)<=0
%             N(i) = ker((kc/2)+j,(kc/2)+k)*S(i+j,n+k+i);
        if (i+j)<=0
            w1 = n+i+j;
        elseif (i+j)>n
            w1 = (i+j)-n;
        else
            w1 = i+j;
        end
        if (i+k) <=0
            w2 = n+i+k;
        elseif (i+k)>n
            w2 = (i+k)-n;
        else
            w2 = i+k;
        end
        N(i) = N(i)+ker((kc/2)+j,(kc/2)+k)*S(w1,w2);
    end
 end
end


w = 16; %length of moving average window

f1 = 1;
f2 = (1/w)*ones(1,w);
H = filter(f1,f2,N);
H = H/sum(H);
[p1, p1IDX] = findpeaks(H,'MinPeakDistance',16);
boundIDX = zeros(1,n);
for i = 1:length(p1IDX)
    boundIDX(p1IDX(i)) = 1;
end

thresh = mean(p1) - std(p1);

for i = 1:length(p1)
    if (p1(i) < thresh)
        p1(i) = 0;
        p1IDX(i) = 0;
    end
end

ff = nnz(p1);
peaks = zeros(1,ff);
peaksIDX = zeros(1,ff);
j = 1;
for i = 1:length(p1)
    if p1(i) ~= 0;
        peaks(j) = p1(i);
        peaksIDX(j) = p1IDX(i);
        j = j+1;
    end
end

beatNum = (1:n);
plot(beatNum, H); 
hold on;
for i=1:length(peaksIDX) 
    plot(beatNum(peaksIDX(i)), peaks(i), '*'); 
end
xlabel('beats');
ylabel('Novelty measure');
% thresh = 0.6*max(H);
% for i = 1:n
%     if H(i) >= thresh;
%         boundIDX(i) = 1; % smoothing using amplitude threshold
%     end
% end




% bThresh = ; % choosing 16 beats as value for Tclose in the paper
% for i = 1:n
%     for j = 1:bThresh
%        if (i+j<=n)
%            if boundIDX(i)&&boundIDX(i+j)
%             if H(i) < H(i+j)
%                 boundIDX(i) = 0;
%             else
%                 boundIDX(i+j) = 0;
%             end
%            end      
%        end
%     end
% end

boundaries = peaksIDX;

% id =1;
% ff = find(boundIDX,1);
% boundaries = zeros(1,length(ff));
% for i = 1:n
%     if boundIDX(i) == 1
%         boundaries(id) = i;
%         id = id+1;
%     end

