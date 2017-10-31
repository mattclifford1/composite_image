function [V, sim] = VfromInd(s2, V, ind, VV, neighbours)
sim = 'calc';
if ind == 8
    if ismember(V + [1, 1],VV, 'rows') == 0
        V = V + [1, 1];
        sim = neighbours(8);
    else
        V = randV(VV, s2);
    end
end
if ind == 7
    if ismember(V + [1, -1],VV, 'rows') == 0
        V = V + [1, -1];
        sim = neighbours(7);
    else
        V = randV(VV, s2);
    end
end
if ind == 6
    if ismember(V + [-1, 1],VV, 'rows') == 0
        V = V + [-1, 1];
        sim = neighbours(6);
    else
        V = randV(VV, s2);
    end
end
if ind == 5
    if ismember(V + [-1, -1],VV, 'rows') == 0
        V = V + [-1, -1];
        sim = neighbours(5);
    else
        V = randV(VV, s2);
    end
end
if ind == 1
    if ismember(V + [-1, 0],VV, 'rows') == 0
        V = V + [-1, 0];
        sim = neighbours(1);
    else
        V = randV(VV, s2);
    end
end
if ind == 2
    if ismember(V + [1, 0],VV, 'rows') == 0
        V = V + [1, 0];
        sim = neighbours(2);
    else
        V = randV(VV, s2);
    end
end
if ind == 3
    if ismember(V + [0, -1],VV, 'rows') == 0
        V = V + [0, -1];
        sim = neighbours(3);
    else
        V = randV(VV, s2);
    end
end
if ind == 4
    if ismember(V + [0, 1],VV, 'rows') == 0
        V = V + [0, 1];
        sim = neighbours(4);
    else
        V = randV(VV, s2);
    end
end
