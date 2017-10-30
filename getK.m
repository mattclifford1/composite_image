function K = getK(x1,x2,l)
x1
x2
if length(x1) == 1
    x = ones(1,length(x2));
    x1 = x .* x1;
end
if length(x2) == 1
    x = ones(1,length(x1));
    x2 = x .* x2;
end
x1
x2
K = exp(-(pdist2(x1 ,x2,'euclidean')^2)/l);