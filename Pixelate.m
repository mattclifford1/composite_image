function P = Pixelate(image,pixelSize)
% INPUTS:       image       - A single image.
%               pixelSize   - A 1-2 vector representing the dimensions of
%                           the pixels in the new image (in terms of
%                           original pixels).
% OUTPUTS:      P           - A pixelated image of the same size as
%                           INPUT:'image', with pixel dimensions as
%                           specified in INPUT:'pixelSize', stored as a
%                           uint16 matrix.
if      sum(mod(size(image)./pixelSize,1))~=0
    errorMessage = 'Dimensions of image are not divisible by pixel size.';
    error(errorMessage);
end
imageCon = zeros(size(image)./pixelSize);
for     i = 1:pixelSize(1)
    for     j = 1:pixelSize(2)
        imageCon = imageCon+double(image(...
                i:pixelSize(1):end+i-pixelSize(1),...
                j:pixelSize(2):end+j-pixelSize(2)));
    end
end
imageCon = imageCon./prod(pixelSize);
imagePix = zeros(size(image));
for     i = 1:pixelSize(1)
    for     j = 1:pixelSize(2)
        imagePix(i:pixelSize(1):end+i-pixelSize(1),...
                j:pixelSize(2):end+j-pixelSize(2)) = imageCon;
    end
end
P = uint16(imagePix);