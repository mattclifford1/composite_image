FileMatrix = readFiles();
EM = exposureMatrix();
Loc = findError(EM);
ErrorNum = size(Loc,1);
for i=1:ErrorNum
    Corrected = NormaliseImage(FileMatrix,Loc(i,1),Loc(i,2));
    figure;
    Name = findFullName(FileMatrix(Loc(i,1),Loc(i,2)));
    title(Name);
    imshow(Corrected);
end


