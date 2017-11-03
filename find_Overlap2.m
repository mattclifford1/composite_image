function V = find_Overlap2(im1, im2, init)

s1 = size(im1); s2 = size(im2);
V = [randi(s2(1)), randi(s2(2))];
% V = [440, 570];
VV = zeros(s2(1)*s2(2),2);
VV(1,:) = V;
sim = 0;
oldSim = 0;
neighbour = 1;
sim1 = get_sim(im1, im1, [s1(1), 2*s1(2)]);
sim2 = get_sim(im2, im2, [s2(1), 2*s2(2)]);
minSim = (sim1 + sim2)/100;
count = 1;
while sim < minSim
    V = randV(VV, s2);
    if count == 1
        V = [450, 550];
        V = init;
        VV(1,:) = V;
    end
    sim = get_sim(im1, im2, V);
    neighbours = neighbourFind(im1, im2, V);
    [neighbour, ind] = max(neighbours);
    
    while  neighbour > sim
        V;
        if abs( V(1) - s2(1)) > s2(1) ||  abs( V(2) - s2(2)) > s2(2)
            V = randV(VV, s2);
        end
        sim = get_sim(im1, im2, V);
        neighbours = neighbourFind(im1, im2, V);
        [neighbour, ind] = max(neighbours);
        if neighbour > sim
            [V, sim] = VfromInd(s2, V, ind, VV, neighbours);
        else
            V = randV(VV, s2);
        end
        if sim == 'calc'
            sim = get_sim(im1, im2, V);
        end
        neighbours = neighbourFind(im1, im2, V);
        [neighbour, ind] = max(neighbours);
        neighbours;
        neighbour; 
        sim;
        minSim;
        V;
        count = count + 1;
        VV(count,:) = V;
    end
end
% figure
% plot(VV(1:count,1),VV(1:count,2))



