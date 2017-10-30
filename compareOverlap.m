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
ss1 = size(Im1); ss2 = size(Im2);

Im1 = double(Im1); Im2 = double(Im2);
m1 = mean2(Im1); m2 = mean2(Im2);
var1 = 0; var2 = 0;
for i = 1: ss1(1)
    for j = 1: ss1(2)
        var1 = var1 + (Im1(i,j) - m1)^2; 
    end
end
var1 = var1/(ss1(1)*ss1(2));
for i = 1: ss2(1)
    for j = 1: ss2(2)
        var2 = var2 + ((Im2(i,j) - m2)^2);
    end
end
var2 = var2/(ss2(1)*ss2(2));
sd1 = sqrt(var1); sd2 = sqrt(var2);
if sd1 > sd2
    Im2 = Im2 - m2; %make mean 0
    Im1 = Im1*sd1/sd2; %transform to new sd
    Im2 = Im2 + m2; %take mean back
end
if sd2 > sd1
    Im1 = Im1 - m1; %make mean 0
    Im1 = Im1*sd2/sd1; %transform to new sd
    Im1 = Im1 + m1; %take mean back
end
Diff = Im2 - Im1;

d = mean2(Diff);  %%% histeq

ImR = ImR - d;
ImR = uint16(ImR);
