[FileMatrix,dontcare] = readFiles();
EM = exposureMatrix();
[Loc,frames] = findError(EM);
ErrorNum = size(Loc,1);

ErrCount = 1;
for j=1:size(FileMatrix,1)
    for i=1:size(FileMatrix,2)
            if FileMatrix(j,i) == 0
                continue
            elseif j == Loc(ErrCount,1) && i == Loc(ErrCount,2)
                Corrected = NormaliseImage(FileMatrix,j,i);
                Name = findFullName(FileMatrix(j,i));
                imwrite(Corrected,strcat('normalised/',Name));
                ErrCount = ErrCount + 1;
            else
                Name = findFullName(FileMatrix(j,i));
                Image = imread(strcat('./images/',Name));
                imwrite(Image,strcat('normalised/',Name));
            end
       
    end

end
    
