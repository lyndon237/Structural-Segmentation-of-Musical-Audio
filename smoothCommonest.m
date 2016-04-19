function IDX2 = smoothCommonest(IDX,b,arg,dml)
l = length(b);
m = length(IDX);
IDX2 = zeros(m,1);
z = dml/2;
if strcmp(arg,'boundary')
    for j = 1:z
        IDX2(j) = mode(IDX(1):IDX(dml));
    end
    for j = (z+1):(b(1)-z)
        IDX2(j) = mode(IDX(j-(z-1)):IDX(j+z));
    end
    for j = (b(1)-z+1):b(1)
        IDX2(j) = mode(IDX(b(1)-(dml-1)):IDX(b(1)));
    end
    
 for k = 2:l
    for j = (b(k-1)+1):(b(k-1)+z)
         IDX2(j) = mode(IDX(b(k-1)+1):IDX(b(k-1)+dml));
    end
    for j = (b(k-1)+z+1):(b(k)-z)
        IDX2(j) = mode(IDX(j-(z-1)):IDX(j+z));
    end
    for j = (b(k)-z+1):b(k)
        IDX2(j) = mode(IDX(b(k)-dml+1):IDX(b(k)));
    end
 end
 
    if (b(l)+dml)<m
        for j = b(l)+1:m
        IDX2(j) = mode(IDX(b(1)):IDX(dml));
        end
        for j = (b(l)+(z+1)):(m-z)
        IDX2(j) = mode(IDX(j-(z-1)):IDX(j+z));
        end
        for j = (m-z+1):m
        IDX2(j) = mode(IDX(m-(dml-1)):IDX(m));
        end
    else
        for j = b(l):m
            IDX2(j) = mode(IDX(b(l)):IDX(m));
        end
    end
  
  
else
    if isinteger(dml/2)
        j = dml/2;
        for i = j:(m-dml/2)
            IDX2(i) = mode(IDX(j-((dml/2)-1):j+(dml/2)));
        end
    else
        j = dml/2 + 0.5;
        for i = j:(m-(dml/2+0.5));
            IDX2(i) = mode(IDX(j-(dml/2-0.5):j+(dml/2-0.5)));
        end  
    end
end
end
    
    