
vertShift = 0; horiShift = 0;
myFolder = strcat(pwd,'/imagesRenamed2');
filePattern = fullfile(myFolder, '*.tif');
tifFiles = dir(filePattern);
baseFileName1 = tifFiles(1).name;
fullFileName1 = fullfile(myFolder, baseFileName1);
joint = imread(fullFileName1);
% rd 476*2,476*2
% ru 0,476*2
% lu 0,0
shiftVect = zeros(55,2);
a=465; b = 300
shiftVect(11,:) = [b,a];
shiftVect(22,:) = [b,478];
shiftVect(33,:) = [b,a];
shiftVect(44,:) = [b,a];
shiftVect(55,:) = [b,a];
c = 570; d = 350;
for j = 1:10
    shiftVect(j,:) = [a,c];
    shiftVect(11+j,:) = [a,d];
    shiftVect(22+j,:) = [a,c];
    shiftVect(33+j,:) = [a,d];
    shiftVect(44+j,:) = [a,c];
end
shiftVect = VfineA
for i = 1:14%(length(tifFiles)) 
    it = i
    baseFileName1 = tifFiles(i).name; baseFileName2 = tifFiles(i+1).name;
    fullFileName1 = fullfile(myFolder, baseFileName1); fullFileName2 = fullfile(myFolder, baseFileName2);
    Im1 = imread(fullFileName1); Im2 = imread(fullFileName2);
    mergeType = 1;  
    if i == 1
        joint = Im1;
        [joint, Im2] = compareOverlap(joint, Im2, shiftVect(i,:));   %re-adjust exposures
        [joint, Im2] = MergeGrad(joint, Im2, shiftVect(i,:), mergeType);     %merge overlap
    else
        [Im1, Im2] = compareOverlap(Im1, Im2, shiftVect(i,:));   %re-adjust exposures
        [Im1, Im2] = MergeGrad(Im1, Im2, shiftVect(i,:), mergeType);     %merge overlap
    end
    [joint, vertShift, horiShift] = stitch(joint, Im2, shiftVect(i,:), vertShift, horiShift);
%     imshow(joint);
end
imshow(joint)