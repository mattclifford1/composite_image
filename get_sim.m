function sim = get_sim(im1, im2, V1)

s1 = size(im1); s2 = size(im2);
V = V1 - s2;
% if V(1) < 0  %right above left
%     A = im1( 1:s1(1) + V(1) , s1(2) - V(2) + 1:end );
%     B = im2( -V(1)+1:end, 1: V(2) );
% end
% if V(1) > 0  %left above right
%     A = im1( V(1)+1:end , s1(2) - V(2) + 1:end );
%     B = im2( 1:s2(1) - V(1), 1: V(2) );
% end
if V(1) <= s2(1) && V(2) <= s2(2) %&& V(2) > 0
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
%     close all
%     imshow(Im1); figure; imshow(Im2);
    sim = Similarity(Im1, Im2);
else
    sim = 0;
end
