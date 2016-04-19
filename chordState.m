function ChordState = chordState(C,keyNum,m)

ChordAmp = zeros(24,m);
for i = 1:m
      ChordAmp(1,i) = C(1,i) + C(5,i) + C(8,i);
      ChordAmp(2,i) = C(5,i) + C(8,i) + C(12,i);
      ChordAmp(3,i) = C(8,i) + C(12,i) + C(3,i);
      ChordAmp(4,i) = C(12,i) + C(3,i) + C(7,i);
      ChordAmp(5,i) = C(3,i) + C(7,i) + C(10,i);
      ChordAmp(6,i) = C(7,i) + C(10,i) + C(2,i);
      ChordAmp(7,i) = C(10,i) + C(2,i) + C(5,i);
      ChordAmp(8,i) = C(2,i) + C(5,i) + C(9,i);
      ChordAmp(9,i) = C(5,i) + C(9,i) + C(12,i);
      ChordAmp(10,i) = C(9,i) + C(12,i) + C(4,i);
      ChordAmp(11,i) = C(12,i) + C(4,i) + C(7,i);
      ChordAmp(12,i) = C(4,i) + C(7,i) + C(11,i);
      
      ChordAmp(13,i) = C(7,i) + C(11,i) + C(2,i);
      
      ChordAmp(14,i) = C(11,i) + C(2,i) + C(6,i);
      ChordAmp(15,i) = C(2,i) + C(6,i) + C(9,i);
      ChordAmp(16,i) = C(6,i) + C(9,i) + C(1,i);
      ChordAmp(17,i) = C(9,i) + C(1,i) + C(4,i);
      ChordAmp(18,i) = C(1,i) + C(4,i) + C(8,i);
      ChordAmp(19,i) = C(4,i) + C(8,i) + C(11,i);
      ChordAmp(20,i) = C(8,i) + C(11,i) + C(3,i);
      ChordAmp(21,i) = C(11,i) + C(3,i) + C(6,i);
      ChordAmp(22,i) = C(3,i) + C(6,i) + C(10,i);
      ChordAmp(23,i) = C(6,i) + C(10,i) + C(1,i);
      ChordAmp(24,i) = C(10,i) + C(1,i) + C(5,i);
end

if keyNum <= 13 %adjusting the sequence of chord states according to the key of the song.
    ChordAmp = circshift(ChordAmp,(13-keyNum),2);
else
    ChordAmp = circshift(ChordAmp, (mod(keyNum,24)+13),2);
end

ChordState = zeros(1,m);
for i = 1:m
   [~,ChordState(1,i)] = max(ChordAmp(1:24,i));
end
end