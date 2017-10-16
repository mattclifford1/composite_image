function fileName=findFullName(number)

%cd dataSet  

fl= dir('./images/*.tif');   %list of all files with .tif extension
%cd ..

flTotalLength=length(fl);
[finalMatrix,frameList]=readFiles();

for i =1:flTotalLength
    if frameList(i)==number
        fileName=fl(i).name;
    end
end

end