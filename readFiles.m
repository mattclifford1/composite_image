function [finalMatrix,NotSortedFrameList]=readFiles()


%{
Brief explanation of the process:

-we assign all the images to the variable called fl (file list).
-extract frame number, x coord and y coord (by looping through every row of fl)
and assign them to 3 lists (frameList, Xcoord and Ycoord)
-clean these 3 lists from anything that isnt a number (spaces, symbols etc..)
-Make Prefinal matrix (based on the Y coordinate), if there's a sudden change
in the Y, it means the microscope went up, so we go the next row
-Make finalMatrix: sort the prefinal matrix


Note:

The X coordinate of each image is useless but it is still saved in case we
ever need it in the future
%}


%You need the images to be in current directory, 
%so cd into the appropriate directory :
%make sure this matlab file is in the same directory as the dataSet folder
%cd dataSet  
%dataSet is a folder which contains all 250 images 
%make sure this matlab file (readFiles.m) is in the same directory as the dataSet folder

fl= dir('./images/*.tif');  %list of all files with .tif extension

fl(112)=[]; %This removes frame 4 from the list because it the same as frame 2



flTotalLength=length(fl);
mySwitchX=0;
mySwitchY=0;
frameList=[];

%extract all information from the file names by making 3 lists:
%Frame number list, Xcoordinate list and Y corrdinate list
for i=1:flTotalLength
    flRowLength=length(fl(i).name);
    mySwitchX=0;
    mySwitchY=0;
    
    for j= 1:flRowLength  %in the row
        %Frame Number:
        if fl(i).name(j)=='e'
            mySwitchX=2;
        end
        
        if mySwitchX==2 && fl(i).name(j)>47 && fl(i).name(j)<58
            frameList(i,j)=fl(i).name(j);
        end
        
        %Xcoordinates:
        
        if mySwitchX==1 && fl(i).name(j)~= 'n'
            Xcoord(i,j)=fl(i).name(j);
        end
        
        if fl(i).name(j)=='X'
            mySwitchX=1;
        end
        
        if fl(i).name(j)== 'n'
            mySwitchX=0;
        end
        
        %Ycoordinates:
        
        if mySwitchY==1 && fl(i).name(j)~= 'n'
            Ycoord(i,j)=fl(i).name(j);
        end
        
        if fl(i).name(j)=='Y'
            mySwitchY=1;
        end
        
        if fl(i).name(j)== 'n'
            mySwitchY=0;
        end
    end
end

%now that we have the relevant information, we need to get rid of the
%spacings, i.e:  ___21890824_____ becomes:  21890824

%Initialisation
[Xrow,Xcol]=size(Xcoord);
[Yrow,Ycol]=size(Ycoord);
[Framerow,Framecol]=size(frameList);
XFcoord=[];
YFcoord=[];
frameListF=[];

%Clean frameList
for i=1:Framerow
    k=0;
    for j=1:Framecol
        if frameList(i,j)>47 && frameList(i,j)<58  %ASCII table from 47 to 58 are only numbers
            k=k+1;                                  %So this gets rid of everything but numbers
            frameListF(i,k)=frameList(i,j);
        end
    end
end

%Clean Xcoord
for i=1:Xrow
    k=0;
    for j=1:Xcol
        if Xcoord(i,j)>47 && Xcoord(i,j)<58
            k=k+1;
            XFcoord(i,k)=Xcoord(i,j);
        end
    end
end
%Clean Ycoord
for i=1:Yrow
    k=0;
    for j=1:Ycol
        if Ycoord(i,j)>47 && Ycoord(i,j)<58
            k=k+1;
            YFcoord(i,k)=Ycoord(i,j);
        end
    end
end



%SORTING
myXFcoord=str2num(char(XFcoord));
myYFcoord=str2num(char(YFcoord));
XFcoordSorted=sort(str2num(char(XFcoord)),'descend');
YFcoordSorted=sort(str2num(char(YFcoord)),'descend');
NotSortedFrameList=str2num(char(frameListF));
frameListF=sort(str2num(char(frameListF)));


%Creating PreFinal matrix:
preFinalMatrix=[];
Col=1;
Row=1;
for i=1:Yrow
    if i==Yrow
        preFinalMatrix(Row,Col)=frameListF(i);
        break
    end
    if abs(YFcoordSorted(i)-YFcoordSorted(i+1))>1000
        preFinalMatrix(Row,Col)=frameListF(i);
        Row=Row+1;
        Col=1;
    else
        preFinalMatrix(Row,Col)=frameListF(i);
        Col=Col+1;
    end
    
end

%Now the prefinal matrix has to be changed to the final matrix

%finalMatrix Row initialisation
[finalRow,finalCol]=size(preFinalMatrix);
finalMatrix=ones(finalRow,finalCol);
kk=finalRow;

%finalMatrix Row changing
for i=1:finalRow
        finalMatrix(kk,:)=preFinalMatrix(i,:);
        kk=kk-1;
end
%finalMatrix Col initialisation

if mod(finalRow,2)==0
    jj=1;
else
    jj=0;
end
%final Matrix Col changing
for i=1:finalRow
        if mod(i,2)==jj
            finalMatrix(i,:)=sort(finalMatrix(i,:),'descend');
        end
end

%plot(myXFcoord,-1*myYFcoord,'.')

        

end