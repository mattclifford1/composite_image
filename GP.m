function GP

x = linspace(-10,10,100);

x1 = linspace(-3,3,10);
y1 = sin(x1);

mu = zeros(100,1);
S = zeros(100,1);
l = 5;
for i = 1:length(x)
    [m, S]  = getPosterior(x(i), x1, y1, l)
    m(i) = m; S(i) = S;
end
figure
hold on
plot(x1,y1,'o')
plot(x,m)
