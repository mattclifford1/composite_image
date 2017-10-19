close all
myFolder = strcat(pwd,'/test_images');
filePattern = fullfile(myFolder, '*.jpg');
filePattern = fullfile(myFolder, '*.tif');
tifFiles = dir(filePattern);
for i = 1:(length(tifFiles)-2)
    baseFileName1 = tifFiles(i).name;
    fullFileName1 = fullfile(myFolder, baseFileName1);
%     row_diff1 = im_grad(fullFileName1);
    baseFileName2 = tifFiles(i+1).name;
    fullFileName2 = fullfile(myFolder, baseFileName2);
%     row_diff2 = im_grad(fullFileName2);
    baseFileName3 = tifFiles(i+2).name;
    fullFileName3 = fullfile(myFolder, baseFileName3);
    Image1 = imread(fullFileName1);
    Image2 = imread(fullFileName2);
    Image3 = imread(fullFileName3);
%     figure
%     subplot(2,2,1); imshow(Image1); subplot(2,2,2); imshow(Image2);
%     preProcImage1 = Pixelate(EdgeDetector(Image1,10000),[1,1]);
%     preProcImage2 = Pixelate(EdgeDetector(Image2,10000),[1,1]);
%     [shiftVect,Sim] = FindOverlap(preProcImage1,preProcImage2,[1,1],[0.1,0.1]);
%    shiftVect
%     cutIm =  im_cut(fullFileName2,shiftVect(1,:));
%     subplot(2,2,3); imshow(cutIm)
end
shiftVect1 = [460,560]; 
shiftVect2 = [452,606];

[joint, vertShift, horiShift] = stitch(Image1, Image2, shiftVect1, 1, 0, 0);
close all
[joint, vertShift, horiShift] = stitch(joint, Image3, shiftVect2, 1, vertShift, horiShift);
subplot(2,1,1); imshow(joint);

[Render1,Render2] = MergeGrad(Image1, Image2,shiftVect1);
[joint, vertShift, horiShift] = stitch(Render1, Render2, shiftVect1, 1, 0, 0);
[RenderJoint, Render3] = MergeGrad(Image2, Image3, shiftVect2);
[joint, vertShift, horiShift] = stitch(joint, Render3, shiftVect2, 1, vertShift, horiShift);
subplot(2,1,2); imshow(joint);





