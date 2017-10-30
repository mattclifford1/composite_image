function [m, S] = getPosterior(x1, x, y, l)

c1 = getK(x, x, l)
c2 = getK(x, x1, l)
c3 = getK(x1, x, l)
c4 = getK(x1, x1, l)

c1I = inv(c1)
dot1 = dot(c3,c1I')
m = dot(dot1,y)

ddot = dot1*c2;
S = c4 - ddot;
