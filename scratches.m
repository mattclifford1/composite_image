function removed = scratches(imageNB)
fl= dir('./images/*.tif');   %list of all files with .tif extension
fl(112)=[]; %This removes frame 4 from the list because it the same as frame 2
maxImage=length(fl);



originalImage=imread(strcat('./images/',findFullName(imageNB)));

im=originalImage; %we will now be working with im
imMean=mean2(im);

[rowMax,colMax]=size(im);



%binarise image
for row=1:rowMax
    for col=1:colMax
        if im(row,col)<imMean+15000
            im(row,col)=0;
        else 
            im(row,col)=80000;
        end
    end
end



% figure
% imshow(originalImage);
% title('Before')


[maxElemR,maxElemC]= find(originalImage == max(originalImage(:)));
done=0;

beginRow=maxElemR;

%left
col=maxElemC;
row=maxElemR;
while im(row,col)~=0 
    
    col=col-1;
    if col<1
        break
    end
end
beginCol=col+1;

%right, useless for the moment
while im(row,col)~=0
    col=col+1;
    if col>colMax
        break
    end
end
%up or down
if im(maxElemR-1,maxElemC)~=0%up
    beginRow=maxElemR-1;
    endRow=maxElemR;
    row=maxElemR-1;
    col=maxElemC;
elseif im(maxElemR+1,maxElemC)~=0%down
    endRow=maxElemR+1;
    row=maxElemR+1;
    col=maxElemC;
else
    done=1;
    endRow=beginRow;
end

%left
if done==0
    while im(row,col)~=0 
        col=col-1;
        if col<1
            break
        end
    end
    if col<beginCol
        beginCol=col;
    end
    
    %right, useless for the moment
    while im(row,col)~=0
        col=col+1;
        if col>colMax
            break
        end
    end
    
end

for fRow=beginRow:endRow
    for fCol=beginCol:colMax
        originalImage(fRow,fCol)=originalImage(fRow-1,fCol);
    end
end

% figure 
% imshow(originalImage);
% title('After')
removed = originalImage;




