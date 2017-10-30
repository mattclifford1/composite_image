function V = randV(VV, s2) 

V = [randi(s2(1)), randi(s2(2))];
while ismember(V ,VV, 'rows') == 1
    V = [randi(s2(1)), randi(s2(2))]
end