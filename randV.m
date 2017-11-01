function Vnew = randV(VV, s2) 
min1 = 400;
max1 = 500;

min2 = 600;
max2 = 700;

range1 = max1 - min1;
range2 = max2 - min2;

% V = [randi(s2(1)), randi(s2(2))];
VR = [randi(range1), randi(range2)];
Vnew = VR + [min1, min2]
while ismember(Vnew ,VV, 'rows') == 1
    VR = [randi(s2(1)), randi(s2(2))];
    Vnew = VR + [min1, min2]
end