function stitch(Im1, Im2, V)
% assumes Im1 is to the left of Im2

Im2 = compareOverlap(Im1, Im2, V); %if 
s1 = size(Im1);
s2 = size(Im2);
if V(1) > 0 
%     Im1(V(1):end, V(2):end) = 0;
end
if V(1) < 0
    Va = abs(V);
    Im1(1:(s1(1) -Va(1) + 1), Va(2):end) = 0;    
end

col = s1(1) + Va(1);
row = s1(2) + V(2);
joint = zeros(col,row);
joint = uint16(joint);
% joint = uint8(joint);
if V(1) > 0 
    joint(1:s1(1), 1:s1(2)) = Im1(1:end,1:end);

    imshow(joint)
end
if V(1) < 0 
    joint(Va(1):end-1, 1:s1(2)) = Im1(1:end, 1:end);
    joint(1:s2(1), V(2):end-1) = Im2(1:end, 1:end);
    
    imshow(joint)
end
