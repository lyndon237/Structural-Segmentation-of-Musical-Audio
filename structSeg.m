function [IDXkmeans, IDXhac, boundaries] = structSeg(song)
[d,sr] = audioread(song);
%Pre-processing and getting the Chroma Feature vector
%converting track to mono
d2 = d(:,1) + d(:,2);
clear d;
a = [min(d2(:,1)) max(d2(:,1))];
l = length(d2);
d2 = 2*((d2 - a(1)*ones(l,1))/(a(2)-a(1)))-ones(l,1); %normalizing the audio signal to amplitude between [-1,1]
%plot(d2(:,1))
%extracting tempo and beat
t = tempo2(d2,sr);
if round(t(3)*10)>5
    tempo = t(1);
else tempo = t(2);
end

bpm = 'bpm';
fprintf('Tempo of the song = %f%s\n',tempo,bpm); 
hop = 60/tempo; %time duration of 1 beat => since tempo = no. of beats in 1 minute, 
% hop = length of 1 beat in seconds 
hopSam = sr*hop; % hopSam = the number of samples in 1 beat
%windowing with a frame size of 3 beats
%(number of samples in one frame =hopsam*4) and hop size of 1 beat.
% L = ceil(l/(hopSam*4));
% C = cell(L,1);
hopSam = round(hopSam);
i = 1;
count = 1;
m = ceil(l/hopSam);
C = zeros(12,m);
y = zeros(12,m);
c = zeros(12,m);
while (i<length(d2))
    
        len = (i+hopSam-1);
        if len < length(d2)
            [Chat, yhat, chat] = feature_chroma_vector(d2(i:len,1), sr);
        else 
            [Chat, yhat, chat] = feature_chroma_vector(d2(i:length(d2),1), sr);
        end
        i = len;
        C(:,count) = Chat;
        y(:,count) = yhat;
        c(:,count) = chat;
        count = count + 1;
end
%C contains the chroma vectors (rows) for each of the beats (columns).

% Detecting the key using self-written keydetection funcion
keyNum = keyDetect(C);

% Assigning the chromas (in vector C) to the respective chords and obtaining Markov chain 'states'
ChordState = chordState(C,keyNum,m);

%finding the boundaries of the song.
[boundaries, S, ker] = boundaryDetect(C);


% Using histclust2
[IDXkmeans,IDXhac] = histClust2(ChordState,5,boundaries);

fprintf('Using kmeans clustering\n');
printSegs(IDXkmeans, boundaries, tempo, song);
fprintf('\n Using Hierarchichal Clustering\n');
printSegs(IDXhac, boundaries, tempo, song);
end

% figure(2)
% hold on;
% plot(boundaries*24)
% plot(ChordState)
% axis([0 506 0 24]);
% xlabel('Time (beats)'); ylabel('Markov State (Chord representing the most spectral power)');
% title('With Major and Minor chords as states');
% hold off;

