function cutIm, overlap =  im_cut(Im,V)

if ischar(Im) == 1
    Im = imread(Im);  %read in image
end

s = size(Im);

cut = ones(s);
cut(1:V(1), 1:V(2)) = 0;
overlap = zeros(s);
cut(1:V(1), 1:V(2)) = 1;

cut = uint8(cut);
Im = uint8(Im); 
cutIm = cut.*Im;
overlap = overlap.*Im;

subplot(1,2,1); imshow(Im); subplot(1,2,2); imshow(cutIm)



