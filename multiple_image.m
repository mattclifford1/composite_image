
myFolder = strcat(pwd,'/test_images');
filePattern = fullfile(myFolder, '*.tif');
tifFiles = dir(filePattern);

for i = 1:(length(tifFiles)-1)
  baseFileName1 = tifFiles(i).name;
  fullFileName1 = fullfile(myFolder, baseFileName1);
  row_diff1 = im_grad(fullFileName1);
  baseFileName2 = tifFiles(i+1).name;
  fullFileName2 = fullfile(myFolder, baseFileName2);
  row_diff2 = im_grad(fullFileName2);
  row_diff1 = imread(fullFileName1);
  row_diff2 = imread(fullFileName2)
  shiftVect = FindOverlap(row_diff1,row_diff2,[1,1],[20,20]);
  shiftVect
  cutIm =  im_cut(fullFileName2,shiftVect)
  imshow(cutIm)
end