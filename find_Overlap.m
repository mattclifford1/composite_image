function V = find_Overlap(im1, im2)

s1 = size(im1); s2 = size(im2);

V = [450, 450];
VV = V;
sim = 0; 
neighbour = 1;
sim1 = get_sim(im1, im1, [s1(1), 2*s1(2)]);
sim2 = get_sim(im2, im2, [s1(1), 2*s2(2)]);
minSim = (sim1 + sim2)/20;
count = 1;
while sim < minSim
    sim = get_sim(im1, im2, V);
    nUp = get_sim(im1, im2, V + [-1, 0]);
    nDown = get_sim(im1, im2, V + [1, 0]);
    nRight = get_sim(im1, im2, V + [0, -1]);
    nLeft = get_sim(im1, im2, V + [0, 1]);
    neighbours = [nUp, nDown, nRight, nLeft];
    [neighbour, ind] = max(neighbours);
    while neighbour > sim
        if ind == 1
            if ismember(V + [-1, 0],VV, 'rows') == 0
                V = V + [-1, 0];
                sim = neighbours(1);
            else
                ind = 4;
            end
        end
        if ind == 2
            if ismember(V + [1, 0],VV, 'rows') == 0
                V = V + [1, 0];
                sim = neighbours(2);
            else
                ind = 1;
            end
        end
        if ind == 3
            if ismember(V + [0, -1],VV, 'rows') == 0
                V = V + [0, -1];
                sim = neighbours(3);
            else
                ind = 2;
            end
        end
        if ind == 4
            if ismember(V + [0, 1],VV, 'rows') == 0
                V = V + [0, 1];
                sim = neighbours(4);
            else 
                ind = 3;
            end
        end
    end
    VV = [VV;V];
    sim;
    count = count +1;
end
plot(VV(:,1),VV(:,2))


