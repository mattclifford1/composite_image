function OL = Overlap(v,image,pixelSize,imageSizes,n)
% INPUTS:       v           - A 1-2 vector representing the relative
%                           position of the lower-right most pixel in
%                           the neighbour image to the upper-left most
%                           pixel in the reference image.
%               image      - Matrix of pixel values.
%               pixelSize   - A 1-2 vector representing the dimensions of
%                           the pixelation in INPUT:'image'.
%               n           - Image subscript, INPUT:'n' = 1 for reference
%                           image, INPUT:'n' = 2 for neighbour image.
% OUTPUTS:      OL          - A matrix of pixel values in the overlap of
%                           INPUT:'image' INPUT:'n', defined by INPUT:'v'.
if      n==1
    OL = image(max(1,v(1)*pixelSize(1)-imageSizes(2,1)+1):...
            min(v(1)*pixelSize(1),end),...
            max(1,v(2)*pixelSize(2)-imageSizes(2,2)+1):...
            min(v(2)*pixelSize(2),end)); 
elseif  n==2
    OL = image(max(1,end-v(1)*pixelSize(1)+1):...
            min(end,end+imageSizes(1,1)-v(1)*pixelSize(1)),...
            max(1,end-v(2)*pixelSize(2)+1):...
            min(end,end+imageSizes(1,2)-v(2)*pixelSize(2)));
else
    errorMessage = 'Invalid image label.';
    error(errorMessage);
end 