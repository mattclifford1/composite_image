close all
myFolder = strcat(pwd,'/test_images');
% myFolder = strcat(pwd,'/noGreyLines');
% filePattern = fullfile(myFolder, '*.jpg');
filePattern = fullfile(myFolder, '*.tif');
tifFiles = dir(filePattern);

    baseFileName1 = tifFiles(1).name;
    fullFileName1 = fullfile(myFolder, baseFileName1);
    baseFileName2 = tifFiles(2).name;
    fullFileName2 = fullfile(myFolder, baseFileName2);

    Image1 = imread(fullFileName1);
    Image2 = imread(fullFileName2);

shiftVect1 = [460, 570];
shiftVect2 = [460,560]; 
shiftVect3 = [452,606];

% [joint1, vertShift, horiShift] = stitch(Image1, Image2, shiftVect1, 1, 0, 0);
% % % close all
% % % imshow(joint);
% [joint1, vertShift, horiShift] = stitch(joint1, Image3, shiftVect2, 1, vertShift, horiShift);
% % subplot(2,1,1);
% [joint1, vertShift, horiShift] = stitch(joint1, Image4, shiftVect3, 1, vertShift, horiShift);
% imshow(joint1);
% 
% [Render1,Render2] = MergeGrad(Image1, Image2,shiftVect1);
% [joint, vertShift, horiShift] = stitch(Render1, Render2, shiftVect1, 1, 0, 0);
% [RenderJoint, Render3] = MergeGrad(Image2, Image3, shiftVect2);
% [joint, vertShift, horiShift] = stitch(joint, Render3, shiftVect2, 1, vertShift, horiShift);
% [RenderJoint, Render4] = MergeGrad(Image3, Image4, shiftVect3);
% [joint, vertShift, horiShift] = stitch(joint, Render4, shiftVect3, 1, vertShift, horiShift);
% % subplot(2,1,2); 
% imshow(joint);



threshold = 10000;
E1 = EdgeDetector(Image1,threshold);
E2 = EdgeDetector(Image2,threshold);





