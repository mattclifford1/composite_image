function cutIm =  im_cut(Im,V)

if ischar(Im) == 1
    Im = imread(Im);  %read in image
end

s = size(Im);
cut = zeros(s);
cut((s(1)-V(1)):end,(s(1)-V(1)):end) = 1;
size(Im)

cut = uint8(cut);
Im = uint8(Im); 
cutIm = cut.*Im;



