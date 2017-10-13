close all
myFolder = strcat(pwd,'/test_images2');
filePattern = fullfile(myFolder, '*.jpg');
tifFiles = dir(filePattern);
for i = 1:(length(tifFiles)-1)
    baseFileName1 = tifFiles(i).name;
    fullFileName1 = fullfile(myFolder, baseFileName1);
    row_diff1 = im_grad(fullFileName1);
    baseFileName2 = tifFiles(i+1).name;
    fullFileName2 = fullfile(myFolder, baseFileName2);
    row_diff2 = im_grad(fullFileName2);
    Image1 = imread(fullFileName1);
    Image2 = imread(fullFileName2);
    figure
    subplot(2,2,1); imshow(Image1); subplot(2,2,2); imshow(Image2);
    preProcImage3 = Pixelate(EdgeDetector(Image1,10000),[1,1]);
    preProcImage4 = Pixelate(EdgeDetector(Image2,10000),[1,1]);
    [shiftVect,Sim] = FindOverlap(preProcImage3,preProcImage4,[1,1],[0.1,0.1]);
    cutIm =  im_cut(fullFileName2,shiftVect(1,:));
    subplot(2,2,3); imshow(cutIm)
end