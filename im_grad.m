function row_diff = im_grad(Im)

if ischar(Im) == 1
    Im = imread(Im);  %read in image
end
% Im = Pixelate(Im,[1,1]);
row_diff = diff(Im);
col_diff = diff(Im,1,2);


