function ImR = compareOverlap(Im1, Im2, V)
% assumes Im1 is to the left of Im2
V = V - size(Im2);
ImR = Im2;

s1 = size(Im1); s2 = size(Im2);


if V(1) > 0 
    Im1 = Im1(V(1):end, V(2):end);
    Im2 = Im2(1:(s2(1) - V(1) + 1), 1:(s2(2) - V(2) + 1));
end
if V(1) < 0
    V = abs(V);
    Im1 = Im1(1:(s1(1) -V(1) + 1), V(2):end);
    Im2 = Im2(V(1):end, 1:(s2(2) - V(2))+ 1);
end
Im2 = int16(Im2); Im1 = int16(Im1); 
Diff = Im2 - Im1;
d = mean2(Diff);  %%% histeq
ImR = ImR - d;
% figure
% subplot(2,2,1); imshow(Im1); subplot(2,2,2); imshow(Im2)
% subplot(2,2,3); imshow(Im1); subplot(2,2,4); imshow(ImR)

