function sim = get_sim(im1, im2, V1)
s1 = size(im1); s2 = size(im2);
V = V1 - s2;
if abs(V(1)) <= s2(1) && abs(V(2)) <= s2(2)
    %     close all
    %     imshow(Im1); figure; imshow(Im2);
    [Im1, Im2] = returnOverlapReigon(im1, im2, V1);
%     imshow(Im1);figure;imshow(Im2);
    sim = Similarity(Im1, Im2, 1);
else
    sim = 0;
end

