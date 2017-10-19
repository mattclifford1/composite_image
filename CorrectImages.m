FileMatrix = readFiles();
EM = exposureMatrix();
Loc = findError(EM);
ErrorNum = size(Loc,1);

for i=1:ErrorNum
    row = Loc(i,1);
    col = Loc(i,2);
    Corrected = NormaliseImage(FileMatrix,row,col);
    figure;
    Name = findFullName(FileMatrix(row,col))
    imshow(Corrected);
end


