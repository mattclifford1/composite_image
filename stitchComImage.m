
vertShift = 0; horiShift = 0;
myFolder = strcat(pwd,'/images');
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

for j = 1:10
    shiftVect(j,:) = [a+2,476*2];
    shiftVect(11+j,:) = [a,0];
    shiftVect(22+j,:) = [a,476*2];
    shiftVect(33+j,:) = [a,0];
    shiftVect(44+j,:) = [a,476*2];
end
% shiftVect(1,:) = [a,476*2];
% shiftVect(2,:) = [-100,a+1];
% shiftVect(3,:) = [560,-100];
% shiftVect(4,:) = [0,478];

for i = 2:55%(length(tifFiles)) 
    it = i-1
    baseFileName2 = tifFiles(i).name;
    fullFileName2 = fullfile(myFolder, baseFileName2);
    Im2 = imread(fullFileName2);
    [joint, vertShift, horiShift] = stitch(joint, Im2, shiftVect(i-1,:), vertShift, horiShift);
%     imshow(joint);
end
imshow(joint)