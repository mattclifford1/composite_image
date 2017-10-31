
vertShift = 0; horiShift = 0;
myFolder = strcat(pwd,'/test_images');
% myFolder = strcat(pwd,'/noGreyLines');
% filePattern = fullfile(myFolder, '*.jpg');
filePattern = fullfile(myFolder, '*.tif');
tifFiles = dir(filePattern);
baseFileName1 = tifFiles(1).name;
fullFileName1 = fullfile(myFolder, baseFileName1);
joint = imread(fullFileName1);
% shiftVect = [460,570; 460,570; 460,560; 452,606; 460,570; 460,570; 460,570; 460,570; 460,570; 460,570;]
shiftVect = VfineC;
for i = 2:(length(tifFiles))    
    baseFileName2 = tifFiles(i).name;
    fullFileName2 = fullfile(myFolder, baseFileName2);
    Im2 = imread(fullFileName2);
    [joint, vertShift, horiShift] = stitch(joint, Im2, shiftVect(i-1,:), 1, vertShift, horiShift);
end
imshow(joint)