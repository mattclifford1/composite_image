function compareOverlap(Im1, Im2, V)
% assumes Im1 is to the left of Im2

if ischar(Im1) == 1
    Im = imread(Im);  %read in image
end
s1 = size(Im1);
s2 = size(Im2);

if V(1) > 0 
    Im1 = Im1(V(1):end, V(2):end);
    Im2 = Im2(1:(s2(1) - V(1) + 1), 1:(s2(2) - V(2) + 1));
end
if V(1) < 0
    V = abs(V);
    Im1 = Im1(1:(s1(1) -V(1) + 1), V(2):end);
    Im2 = Im2(V(1):end, 1:(s2(2) - V(2))+ 1);
end
size(Im1)
size(Im2)
Diff = Im1 - Im2;
d = mean(mean(Diff));
ImR = Im2 +d;
figure
subplot(2,2,1); imshow(Im1); subplot(2,2,2); imshow(Im2)
subplot(2,2,3); imshow(Im1); subplot(2,2,4); imshow(ImR)

