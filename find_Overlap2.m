function V = find_Overlap2(im1, im2)

s1 = size(im1); s2 = size(im2);
V = [randi(s2(1)), randi(s2(2))];
% V = [450, 550];
Vstart = V;
VV = V;
sim = 0; 
neighbour = 1;
sim1 = get_sim(im1, im1, [s1(1), 2*s1(2)]);
sim2 = get_sim(im2, im2, [s2(1), 2*s2(2)]);
minSim = (sim1 + sim2)/100;
count = 1;
while sim < minSim
    sim = get_sim(im1, im2, V)
    nUp = get_sim(im1, im2, V + [-1, 0]);
    nDown = get_sim(im1, im2, V + [1, 0]);
    nRight = get_sim(im1, im2, V + [0, -1]);
    nLeft = get_sim(im1, im2, V + [0, 1]);
    neighbours = [nUp, nDown, nRight, nLeft];
    [neighbour, ind] = max(neighbours);
%     while neighbour > sim
        if ind == 1
            if ismember(V + [-1, 0],VV, 'rows') == 0
                V = V + [-1, 0];
                sim = neighbours(1);
            else
%                 neighbours(1) = min(neighbours) - 1;
%                 [neighbour, ind] = max(neighbours)
                while ismember(V + [-1, 0],VV, 'rows') == 1
                    V = [randi(s2(1)), randi(s2(2))];
                end
            end
        end
        if ind == 2
            if ismember(V + [1, 0],VV, 'rows') == 0
                V = V + [1, 0];
                sim = neighbours(2);
            else
%                 neighbours(2) = min(neighbours) - 1;
%                 [neighbour, ind] = max(neighbours)
                while ismember(V + [1, 0],VV, 'rows') == 1
                    V = [randi(s2(1)), randi(s2(2))];
                end
            end
        end
        if ind == 3
            if ismember(V + [0, -1],VV, 'rows') == 0
                V = V + [0, -1];
                sim = neighbours(3);
            else
%                 neighbours(3) = min(neighbours) - 1;
%                 [neighbour, ind] = max(neighbours)
                while ismember(V + [0, -1],VV, 'rows') == 1
                    V = [randi(s2(1)), randi(s2(2))];
                end
            end
        end
        if ind == 4
            if ismember(V + [0, 1],VV, 'rows') == 0
                V = V + [0, 1];
                sim = neighbours(4);
            else 
%                 neighbours(4) = min(neighbours) - 1;
%                 [neighbour, ind] = max(neighbours)
                while ismember(V + [0, 1],VV, 'rows') == 1
                    V = [randi(s2(1)), randi(s2(2))];
                end
            end
        end
%     end
    VV = [VV;V];
    sim;
    count = count +1;
end
figure
plot(VV(:,1),VV(:,2))



