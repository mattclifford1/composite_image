function compareOverlap(Im1, Im2, V)
% assumes Im1 is to the left of Im2

if ischar(Im1) == 1
    Im = imread(Im);  %read in image
end
V = abs(V)

s2 = size(Im2);

Im1 = Im1(V(1):end, V(2):end);
Im2 = Im2(1:(s2(1) - V(1)), 1:(s2(2) - V(2)));

subplot(1,2,1); imshow(Im1); subplot(1,2,2); imshow(Im2)