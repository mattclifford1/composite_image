<<<<<<< HEAD
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

=======
function fileName=findFullName(number)

cd dataSet  

fl= dir('*.tif');   %list of all files with .tif extension
cd ..

flTotalLength=length(fl);
[finalMatrix,frameList]=readFiles();

for i =1:flTotalLength
    if frameList(i)==number
        fileName=fl(i).name;
    end
end

>>>>>>> 901cfe53ee09bafc8da78bab70893f9bdd0bfaa0
end