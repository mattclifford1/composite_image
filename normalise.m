%% Load images

dataDir = dir('./images');
fileNames = extractfield(dataDir, 'name');


im1 = imread(strcat('./images/', char(fileNames(:,51))));
im2 = imread(strcat('./images/', char(fileNames(:,54))));
im3 = imread(strcat('./images/', char(fileNames(:,55))));
im4 = imread(strcat('../data/', char(fileNames(:,56))));
im5 = imread(strcat('../data/', char(fileNames(:,57))));
im6 = imread(strcat('../data/', char(fileNames(:,58))));
im7 = imread(strcat('../data/', char(fileNames(:,59))));
im8 = imread(strcat('../data/', char(fileNames(:,60))));

orow = [im1,im2,im3,im4,im5,im6,im7,im8];
drow = [im1,im2,im3,im4,im5,im7,im8];
fixed = im2uint16(NormaliseImage(im6, drow));
nrow = [im1,im2,im3,im4,im5,fixed,im7,im8];
figure; 
subplot(2,1,1); imshow(orow); title('Original neighbourhood'); 
subplot(2,1,2); imshow(nrow); title('Corrected');

%%