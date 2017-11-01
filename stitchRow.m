
vertShift = 0; horiShift = 0;
myFolder = strcat(pwd,'/test_images');
% myFolder = strcat(pwd,'/noGreyLines');
% filePattern = fullfile(myFolder, '*.jpg');
filePattern = fullfile(myFolder, '*.tif');
tifFiles = dir(filePattern);
baseFileName1 = tifFiles(1).name;
fullFileName1 = fullfile(myFolder, baseFileName1);
joint = imread(fullFileName1);
<<<<<<< HEAD
shiftVect = [460,570; 460,570; 460,560; 452,606; 460,570; 460,570; 460,570; 460,570; 460,570; 460,570;];
shiftVect = [460,570;460,570;460,570;460,570;460,570;460,570;460,570;460,570;477,475]; %down
shiftVect = [476*2,476*2;476*2,476*2;476*2,476*2;476*2,476*2;476*2,476*2;476*2,476*2]  %up
shiftVect = [0,476*2;0,476*2;0,476*2;0,476*2;476*2,476*2;476*2,476*2]
shiftVect = [476*2,0;476*2,476*2;0,476*2;0,476*2]
for i = 2:5%(length(tifFiles))    
=======
% shiftVect = [460,570; 460,570; 460,560; 452,606; 460,570; 460,570; 460,570; 460,570; 460,570; 460,570;]
shiftVect = VfineC;
for i = 2:(length(tifFiles))    
>>>>>>> b01d3e9cd6b7df5fe7d921964cd4d466eb22c895
    baseFileName2 = tifFiles(i).name;
    fullFileName2 = fullfile(myFolder, baseFileName2);
    Im2 = imread(fullFileName2);
    [joint, vertShift, horiShift] = stitch(joint, Im2, shiftVect(i-1,:), vertShift, horiShift);
    imshow(joint)
end
imshow(joint)