function V = gradAscent(im1, im2, initV)

s2 = size(im2);
V = initV;
VV = zeros(s2(1)*s2(2),2);
VV(1,:) = V;
sim = 0;
neighbour = 1;
count = 1;
while  neighbour > sim
    sim = get_sim(im1, im2, V);
    neighbours = neighbourFind(im1, im2, V);
    [neighbour, ind] = max(neighbours);
    [V, sim] = VfromInd(s2, V, ind, VV, neighbours);
    neighbours = neighbourFind(im1, im2, V);
    [neighbour, ind] = max(neighbours);
    count = count + 1;
    VV(count,:) = V;
end
% plot(VV(1:count,1),VV(1:count,2))



