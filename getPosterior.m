function [m, S] = getPosterior(x1, x, y, l)


dist1 = sqrt((x-x)^2)
c1 = exp((-(dist1))/l);
% c1 = getK(x, x, l)

X1 = (x-x)';
X2 = (x-x);
dist2 = sqrt((x1-x)^2);
c2 = exp((-(dist2)^2)/l);

c3 = c2'

X1 = (x1-x1);
X2 = (x1-x1)';
dist4 = sqrt(X1*X2)
c4 = exp((-(dist4))/l);

c1I = inv(c1);
dot1 = dot(c3,c1I');
m = dot(dot1,y);

ddot = dot1*c2;
S = c4 - ddot;