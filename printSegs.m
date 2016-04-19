function IDD = printSegs(IDX, boundaries, tempo, filename)
IDD = char(IDX + 'A' -1);
beatLength = 60/tempo;
boundTime = boundaries*(beatLength);
fprintf('Segments for %s\n',filename);
fprintf('Start Time \t End Time \t \t Label\n');
fprintf('%f',0.00);
fprintf('\t %f \t \t %c \n',boundTime(1),IDD(boundaries(1)-1));
for i = 2:length(boundaries);
    fprintf('%f',boundTime(i-1));
    if boundTime(i) <= 100
       fprintf('\t %f \t \t %c \n',boundTime(i),IDD(boundaries(i)-1));
    else
       fprintf('\t %f \t %c \n',boundTime(i),IDD(boundaries(i)-1));
    end
end
end


