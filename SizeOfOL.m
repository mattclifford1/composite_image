function A = SizeOfOL(v,pixelSize,imageSizes)
% INPUTS:       v           - A 1-2 vector representing the relative
%                           position of the lower-right most pixel in
%                           the neighbour image to the upper-left most
%                           pixel in the reference image.
%               pixelSize   - A 1-2 vector representing the dimensions of
%                           the pixelation in the overlap region.
%               imageSizes  - A 2-2 matrix representing the dimensions of
%                           the reference image (first row) and the
%                           dimensions of the second image (second row).
% OUTPUTS:      A           - A 1-2 vector representing the size of the
%                           overlap defined by INPUT:'v' in terms of pixels
%                           between images of sizes INPUT:'imageSizes'(1,:)
%                           and INPUT:'imageSizes'(2,:).
A = [min(v(:,1)*pixelSize(1),imageSizes(1,1))-...
    max(1,v(:,1)*pixelSize(1)-imageSizes(2,1)+1),...
    min(v(:,2)*pixelSize(2),imageSizes(1,2))-...
    max(1,v(:,2)*pixelSize(2)-imageSizes(2,2)+1)]+1;