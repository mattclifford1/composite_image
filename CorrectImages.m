[FileMatrix,dontcare] = readFiles();
EM = ExposureVariable();
[Loc,frames] = findError(EM,FileMatrix);
ErrorNum = size(Loc,1);

ErrCount = 1;
diff = zeros(ErrorNum,1);
for j=1:size(FileMatrix,1)
    for i=1:size(FileMatrix,2)
            if FileMatrix(j,i) == 0
                continue
            elseif ErrCount <= ErrorNum && j == Loc(ErrCount,1) && i == Loc(ErrCount,2)
                Name = findFullName(FileMatrix(j,i));
                removed = scratches(frames(ErrCount));
                diff(ErrCount) = 2^16-1-max(max(removed));
                a = double(max(max(removed)))/(2^16-1);
                imwrite(uint16(floor(double(removed).*(1+a))),strcat('noscratch/',Name));
                ErrCount = ErrCount + 1;
            else
                Name = findFullName(FileMatrix(j,i));
                Image = imread(strcat('./images/',Name));
                imwrite(Image,strcat('noscratch/',Name));
            end
       
    end

end


ErrCount = 1;
for j=1:size(FileMatrix,1)
    for i=1:size(FileMatrix,2)
            if FileMatrix(j,i) == 0
                continue
            elseif ErrCount <= ErrorNum && j == Loc(ErrCount,1) && i == Loc(ErrCount,2)
                Name = findFullName(FileMatrix(j,i));
                Image = imread(strcat('./images/',Name));
                Corrected = NormaliseImage(FileMatrix,j,i,Image);
                imwrite(Corrected,strcat('normalised/',Name));
                ErrCount = ErrCount + 1;
            else
                Name = findFullName(FileMatrix(j,i));
                Image = imread(strcat('./noscratch/',Name));
                imwrite(Image,strcat('normalised/',Name));
            end
       
    end

end
    
