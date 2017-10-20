function expoMatrix=exposureMatrix()
%Outputs the matrix of exposure
[finalMatrix,frameList]=readFiles();

[row,col]=size(finalMatrix);
%expoMatrix=ones(row,col);

for i=1:row
    for j=1:col
        if finalMatrix(i,j)~=0
            expoMatrix(i,j)=mean2(imread(strcat('./images/',findFullName(finalMatrix(i,j)))));
        else
            expoMatrix(i,j)=0;
        end
    end
end
