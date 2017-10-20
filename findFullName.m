function fileName=findFullName(number)

%cd dataSet  

fl= dir('./images/*.tif');   %list of all files with .tif extension
fl(112)=[]; %This removes frame 4 from the list because it the same as frame 2


flTotalLength=length(fl);
[finalMatrix,frameList]=readFiles();

for i =1:flTotalLength
    if frameList(i)==number
        fileName=fl(i).name;
    end
end

end