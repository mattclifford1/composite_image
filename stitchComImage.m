
vertShift = 0; horiShift = 0;
myFolder = strcat(pwd,'/images/');
myFolder = strcat(pwd,'/normalised/');
% myFolder = strcat(pwd,'/uncompressed/');
% myFolder = strcat(pwd,'/noscratch/');
% myFolder = strcat(pwd,'/noSeam3/');
filePattern = fullfile(myFolder, '*.tif');
tifFiles = dir(filePattern);

shiftVect = DATA.vector;
load('frameNameLookup.mat');
for i = 1:length(tifFiles)-2
    it = i
    Im1 = imread([myFolder, frames.fileName{i}]);
    Im2 = imread([myFolder, frames.fileName{i+1}]);
    mergeType = 3;  
    if i == 1
        joint = Im1;
        Im2R = Im2;
        [Im1, Im2R, d] = compareOverlap(joint, Im2, shiftVect(i,:));   %re-adjust exposures
        [joint, Im2] = MergeGrad(Im1R, Im2R, shiftVect(i,:), mergeType);     %merge overlap
        previousIm = Im2;
    else
        Im1R = Im1 - d;   %update correction
        [Im1, Im2, d] = compareOverlap(Im1R, Im2, shiftVect(i,:));   %re-adjust exposures
        [Im1, Im2] = MergeGrad(previousIm, Im2, shiftVect(i,:), mergeType);     %merge overlap
        previousIm = Im2;
    end
    [joint, vertShift, horiShift] = stitch(joint, Im2, shiftVect(i,:), vertShift, horiShift);
    vertShift;
    horiShift;
    imshow(joint );
end
% imshow(joint)
m = max(max(joint));
m1 = (2^16) - 1;
s = m1/m;
joint1 = joint * s;
figure
imshow(joint1)
