function greyLines()

%Before running, make sure you have a folder called: 'noGreyLines' in
%current directory

%this fct takes all images, gets rid of the grey lines by copying the row
%below and then saves the new images into a folder called noGreyLines

fl= dir('./images/*.tif');   %list of all files with .tif extension
fl(112)=[]; %This removes frame 4 from the list because it the same as frame 2
maxImage=length(fl);




for image=1:maxImage
    imageMatrix=imread(strcat('./images/',fl(image).name));
    [row,col]=size(imageMatrix);
    for i=3:-1:1
        for j=1:col
            imageMatrix(i,j)=imageMatrix(i+1,j)-300;%arbitrary -300, otherwise, they are lighter than the copied rows
        end
    end
    imwrite(imageMatrix,strcat('noGreyLines/',fl(image).name),'tif')
end

end