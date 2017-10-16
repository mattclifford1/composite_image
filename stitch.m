function stitch(Im1, Im2, V1)
% assumes Im1 is to the left of Im2
V = V1 - size(Im2);

% Im2 = compareOverlap(Im1, Im2, V1); %if you want overlap brightness correction

s1 = size(Im1);
s2 = size(Im2);
if V(1) > 0 
    Im1(V(1):end, V(2):end) = 0;
    col = s1(1) + V(1) - 1;
end
if V(1) < 0
    Va = abs(V);
    col = s1(1) + Va(1) - 1;
    Im1(1:(s1(1) -Va(1) + 1), Va(2):end) = 0;    
end

row = s1(2) + V(2) - 1;
joint = zeros(col,row); joint = uint16(joint);
if V(1) > 0 
    joint(1:s1(1), 1:s1(2)) = Im1(1:end, 1:end);
    joint(V(1):end, V(2):end) = Im2(1:end, 1:end);
    imshow(joint)
end
if V(1) < 0 
    joint(Va(1):end, 1:s1(2)) = Im1(1:end, 1:end);
    joint(1:s2(1), V(2):end) = Im2(1:end, 1:end);  
    imshow(joint)
end
