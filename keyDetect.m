function keyNum = keyDetect(C)
%trying to detect key by summing the entries in each row of C to find the total "power" of each Chroma.
%gives either the actual key or it's relative major/minor. If it does
%detect the relative major/minor instead of the original key, it doesn't
%really affect the performance of the entire segmentation algorithm
%because of the use of the circle of fifths.

%The output, keyNum is the number representing the key of the song with
%Amajor corresponding to number 1 and moving forward in the circle of fifths.

CSum = zeros(12,1);
for i = 1:1:12
   CSum(i) = sum(C(i,:));
end
%now trying to add up powers of the notes in a scale and investigate if it gives key.
%Trying to avoid inserting a full-fledged key detecting algorithm.
keydetect = zeros(24,1); %Indices of "scale powers" in keyDetect according to circle of fifths.
keydetect(1) = CSum(1)+CSum(3)+CSum(5)+CSum(6)+CSum(8)+CSum(10)+CSum(12); %Amajor scale
keydetect(18) = CSum(1)+CSum(3)+CSum(4)+CSum(6)+CSum(8)+CSum(9)+CSum(11); %Aminor
keydetect(15) = CSum(2)+CSum(4)+CSum(6)+CSum(7)+CSum(9)+CSum(11)+CSum(1); %A#major
keydetect(8) = CSum(2)+CSum(4)+CSum(5)+CSum(7)+CSum(9)+CSum(10)+CSum(12); %A#minor
keydetect(5) = CSum(3)+CSum(5)+CSum(7)+CSum(8)+CSum(10)+CSum(12)+CSum(2); %Bmajor
keydetect(22) = CSum(3)+CSum(5)+CSum(6)+CSum(8)+CSum(10)+CSum(11)+CSum(1); %Bminor
keydetect(19) = CSum(4)+CSum(6)+CSum(8)+CSum(9)+CSum(11)+CSum(1)+CSum(3); %Cmajor
keydetect(12) = CSum(4)+CSum(6)+CSum(7)+CSum(9)+CSum(11)+CSum(12)+CSum(2);%Cminor
keydetect(9) = CSum(5)+CSum(7)+CSum(9)+CSum(10)+CSum(12)+CSum(2)+CSum(4);%C#major
keydetect(2) = CSum(5)+CSum(7)+CSum(8)+CSum(10)+CSum(12)+CSum(1)+CSum(3);%C#minor
keydetect(23) = CSum(6)+CSum(8)+CSum(10)+CSum(11)+CSum(1)+CSum(3)+CSum(5);%Dmajor
keydetect(16) = CSum(6)+CSum(8)+CSum(9)+CSum(11)+CSum(1)+CSum(2)+CSum(4);%Dminor
keydetect(13) = CSum(7)+CSum(9)+CSum(11)+CSum(12)+CSum(2)+CSum(4)+CSum(6);%D#major
keydetect(6) = CSum(7)+CSum(9)+CSum(10)+CSum(12)+CSum(2)+CSum(3)+CSum(5);%D#minor
keydetect(3) = CSum(8)+CSum(10)+CSum(12)+CSum(1)+CSum(3)+CSum(5)+CSum(7);%Emajor
keydetect(20) = CSum(8)+CSum(10)+CSum(11)+CSum(1)+CSum(3)+CSum(4)+CSum(6);%Eminor
keydetect(17) = CSum(9)+CSum(11)+CSum(1)+CSum(2)+CSum(4)+CSum(6)+CSum(8);%Fmajor
keydetect(10) = CSum(9)+CSum(11)+CSum(12)+CSum(2)+CSum(4)+CSum(5)+CSum(7);%Fminor
keydetect(7) = CSum(10)+CSum(12)+CSum(2)+CSum(3)+CSum(5)+CSum(7)+CSum(9);%F#major
keydetect(24) = CSum(10)+CSum(12)+CSum(1)+CSum(3)+CSum(5)+CSum(6)+CSum(8);%F#minor
keydetect(21) = CSum(11)+CSum(1)+CSum(3)+CSum(4)+CSum(6)+CSum(8)+CSum(10);%Gmajor
keydetect(14) = CSum(11)+CSum(1)+CSum(2)+CSum(4)+CSum(6)+CSum(7)+CSum(9);%Gminor
keydetect(11) = CSum(12)+CSum(2)+CSum(4)+CSum(5)+CSum(7)+CSum(9)+CSum(11);%G#major
keydetect(4) = CSum(12)+CSum(2)+CSum(3)+CSum(5)+CSum(7)+CSum(8)+CSum(10);%G#minor
keydetect = normc(keydetect);
[~,keyNum] = max(keydetect); %keyNum is the index of the key of the song (1-24)
end