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
[joint, horiShift, vertShift] = stitch(Image1, Image2,[460,560], 1, 0, 0);
close all
stitch(joint, Image3,[452,606], 1, horiShift, vertShift);
figure
stitch(Image2, Image3,[452,606], 1, 0, 0);





