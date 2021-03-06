function [Im1, Im2] = returnOverlapReigon(im1, im2, V1)

s1 = size(im1); s2 = size(im2);
V = V1 - s2;
if V(2) > 0
    if V(1) > 0 %left above right
        Im1 = im1(V(1):end, V(2):end);
        Im2 = im2(1:(s2(1) - V(1) + 1), 1:(s2(2) - V(2) + 1));
    end
    if V(1) < 0 %right above left
        V = abs(V);
        Im1 = im1(1:(s1(1) -V(1) + 1), V(2):end);
        Im2 = im2(V(1):end, 1:(s2(2) - V(2))+ 1);
    end
    if V(1) == 0
        Im1 = im1( 1:end , s1(2) - V(2) + 1 :end );
        Im2 = im2( 1:end, 1: V(2) );
    end
end
if V(2) < 0
    V(2) = abs(V(2));
    if V(1) > 0 %left above right
        Im1 = im1(V(1):end, 1:s1(2) - V(2) + 1);
        Im2 = im2(1:(s2(1) - V(1) + 1), s2(2) -(s1(2) - V(2)):end);
    end
    if V(1) < 0 %right above left
        V = abs(V);
        Im1 = im1(1:(s1(1) -V(1) + 1), 1:s1(2) - V(2) + 1);
        Im2 = im2(V(1):end, 1:(s2(2) - V(2))+ 1);
    end
    if V(1) == 0
        Im1 = im1( 1:end , 1:s1(2) - V(2) + 1);
        Im2 = im2( 1:end, s2(2) -(s1(2) - V(2)):end);
    end
end
if V(2) == 0
    if V(1) > 0 %left above right
        Im1 = im1(V(1):end, 1:end);
        Im2 = im2(1:(s2(1) - V(1) + 1), 1:end);
    end
    if V(1) < 0 %right above left
        V = abs(V);
        Im1 = im1(1:(s1(1) -V(1) + 1), 1:end);
        Im2 = im2(V(1):end, 1:end);
    end
    if V(1) == 0
        Im1 = im1( 1:end , 1:end);
        Im2 = im2( 1:end, 1:end);
    end
end