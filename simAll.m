threshold = 10000;
vertShift = 0; horiShift = 0;
myFolder = strcat(pwd,'/images/');
myFolder = strcat(pwd,'/normalised/');
% myFolder = strcat(pwd,'/uncompressed/');
% myFolder = strcat(pwd,'/noscratch/');
% myFolder = strcat(pwd,'/noSeam3/');
filePattern = fullfile(myFolder, '*.tif');
tifFiles = dir(filePattern);
figure
% shiftVect = DATA.vector;
load('frameNameLookup.mat');
joint = imread([myFolder, frames.fileName{1}]);
shiftVect1 = [400,400]; %first guess 
for i = 1:length(tifFiles)-2
    it = i
    Im1 = imread([myFolder, frames.fileName{i}]);
    Im2 = imread([myFolder, frames.fileName{i+1}]); 
    E1 = EdgeDetector(Im1,threshold);
    E2 = EdgeDetector(Im2,threshold);
%     if i ==1 
        shiftVectGuess = simAnneal(E1, E2, [476,476])
%         shiftVect1 = shiftVectGuess;
        shiftVect1 = gradAscent(E1, E2, shiftVectGuess)
%     else
%         shiftVect1 = find_Overlap2(E1, E2, shiftVect1)
%     end
%     shiftVect = shiftVectGuess;
    [joint, vertShift, horiShift] = stitch(joint, Im2, shiftVect1, vertShift, horiShift);
    imshow(joint);
end
% imshow(joint)
m = max(max(joint));
m1 = (2^16) - 1;
s = m1/m;
joint1 = joint * s;
figure
imshow(joint1)
