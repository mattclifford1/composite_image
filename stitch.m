function [joint, vertShift, horiShift] =  stitch(Im1, Im2, V1, Correct, ImBottom, ImEnd)
% assumes Im1 is to the left of Im2
s1 = size(Im1);
s2 = size(Im2);
V = V1 - s2;
if Correct == 1
%     Im2 = compareOverlap(Im1, Im2, V1); %if you want overlap brightness correction
end
% if ImBottom < 1
    V(1) = V(1) + ImBottom;
% end

VB = V(2) + ImEnd;
VA = V(1) + ImBottom;
if V(1) > 0 
    Im1(V(1):end, V(2):end) = 0;
    row = s1(1) + V(1) - 1;
end
if V(1) < 0
    Va = abs(V);
    row = s1(1) + Va(1) - 1;
    Im1(1:(s1(1) -Va(1) + 1), VB:end) = 0;    
end
col = s1(2) + V(2) - 1;
joint = zeros(row,col); 
joint = uint16(joint);
if V(1) > 0 
    joint(1:s1(1), 1:s1(2)) = Im1(1:end, 1:end);
    joint(V(1):end, V(2):end) = Im2(1:end, 1:end);
    imshow(joint)
end
if V(1) < 0 
    joint(Va(1):end, 1:s1(2)) = Im1(1:end, 1:end);
    imshow(joint)
    joint(1:s2(1), VB:end) = Im2(1:end, 1:end);  
    imshow(joint)
end
vertShift = V(1);
s3 = size(joint);
horiShift = s3(2) - s2(2);
% vertShift = s3(1) - s2(1);
