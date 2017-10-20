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
% im1 = Im1(:); im2 = Im2(:);
% 
% mean1 = mean(im1); mean2 = mean(im2);
% std1 = std(im1); std2 = std(im2);
% 
% if std1 > std2
%     im2 = im2 - mean2; %make mean 0 
%     mean(im2)
% end
% if std2 > std1
%     im1 = im1 - mean1; %make mean 0 
%     mean(im1)
% end

Diff = Im2 - Im1;
d = mean2(Diff);  %%% histeq

ImR = ImR - d;
ImR = uint16(ImR);
