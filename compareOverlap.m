function [im1, im2] = compareOverlap(im1, im2, V)
% V is vector from im1 to im2
IM1 = im1; IM2 = im2;
[Im1, Im2] = returnOverlapReigon(im1, im2, V);  %get just overlap region
Im2 = int16(Im2); Im1 = int16(Im1);   %we will need to work with negatives

ss1 = size(Im1); ss2 = size(Im2);
Im1 = double(Im1); Im2 = double(Im2);  %needed for mean2 function
m1 = mean2(Im1); m2 = mean2(Im2);
%calculate variance of both overlaps
var1 = 0; var2 = 0;
for i = 1: ss1(1)
    for j = 1: ss1(2)
        var1 = var1 + (Im1(i,j) - m1)^2; 
    end
end
var1 = var1/(ss1(1)*ss1(2));
for i = 1: ss2(1)
    for j = 1: ss2(2)
        var2 = var2 + ((Im2(i,j) - m2)^2);
    end
end
var2 = var2/(ss2(1)*ss2(2));
sd1 = sqrt(var1); sd2 = sqrt(var2);  %standard deviation of both overlaps
% use the image with the biggest s.d.
if sd1 > sd2
    im2 = im2 - m2; %make mean 0
    im2 = im1*sd1/sd2; %transform to new sd
    im2 = im2 + m2; %take mean back
end
if sd2 > sd1
    im1 = im1 - m1; %make mean 0
    im1 = im1*sd2/sd1; %transform to new sd
    im1 = im1 + m1; %take mean back
end


Diff = Im2 - Im1;

d = mean2(Diff);  
im2 = IM2 - d;
im2 = uint16(im2); im1 = uint16(IM1);
