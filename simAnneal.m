function V = simAnneal(Im1, Im2,init)
%input two images after they have been throught the edge dectector.

n = 100000;
s = get_sim(Im1,Im2,init)/n;
V = init;
k = 1 ; kMax = 10000;
T = 100;
% while T > Tmin
for i = k:kMax
    T = 0.99*T;
    a = 300; b = 400;
    Vrange = [randi(a), randi(b)];
    Vnew = Vrange - [a/2,b/2] + [400,476];
%     Vnew = [randi(800), randi(800)];
%     range = round(T);
%     if range == 0;
%         range =1;
%     end
%     Vnew = V + [round(randi(range)-range/2), round(randi(range)-range/2)];
    sNew = get_sim(Im1,Im2,Vnew)/n;
%     if 1/(1 + exp((sNew-s)/T)) >= rand
% (sNew-s)/T
% exp((sNew-s)/T)
    if exp((sNew-s)/T) >= rand
        s = sNew;
        V = Vnew;
    end
end
