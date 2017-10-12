Image1 = imread('Frame 74 X -21886924 nm & Y 528845 nm.tif');
%%
Image2 = imread('Frame 76 X -21888920 nm & Y 528854 nm.tif');
%%
Image3 = imread('Frame 50 X -21888919 nm & Y 530854 nm.tif');
%%
histogram(testImage(:),max(max(testImage))-min(min(testImage)));
%%
x = hist(testImage(:),double(min(min(testImage))):1:double(max(max(testImage))));
y = max(x);
% y represents the most dominant grey scale value. possibly useful for
% intensity corrections.
%%
Gx = [1,0,-1;2,0,-2;1,0,-1];
Gy = [-1,-2,-1;0,0,0;1,2,1];
% Gx and Gy are sobel operators for detecting vertical and horizontal edges
% respectively.
%%
testImageGx = conv2(double(testImage),Gx);
testImageGx = testImageGx(2:end-1,2:end-1);
testImageGy = conv2(double(testImage),Gy);
testImageGy = testImageGy(2:end-1,2:end-1);
testImageG = floor((testImageGx.^2+testImageGy.^2).^0.5);
%%
clear testImageGx testImageGy
%%
testImage256 = testImage.*(256/(2^16));
% Temporarily abandonded...
%%
pixelSize = [2,2];
testImagePix = zeros(size(testImage)./pixelSize);
for     i = 1:pixelSize(1)
    for     j = 1:pixelSize(2)
        testImagePix = testImagePix+testImage(i:2:end+i-2,j:2:end+j-2);
    end
end
testImagePix = testImagePix./prod(pixelSize);
%%




%%
Image3 = imread('Frame 298 X -21882921 nm & Y 514852 nm.tif');
Image4 = imread('Frame 302 X -21880926 nm & Y 514846 nm.tif');
%%
preProcImage3 = Pixelate(EdgeDetector(Image3,10000),[4,4]);
preProcImage4 = Pixelate(EdgeDetector(Image4,10000),[4,4]);
%%
[v,Sim] = FindOverlap(preProcImage3,preProcImage4,[4,4],[0.1,0.1]);
%%
[t1,t2] = CheckMapping(Image3,Image4,v,5);