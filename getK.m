function K = getK(x1,x2,l)
% if length(x1) ~= 1 
%     x = ones(1,length(x2));
%     x1 = x .* x1;
% end
% if length(x2) ~= 1
%     x = ones(1,length(x1));
%     x2 = x .* x2;
% end
X1 = (x1-x2)';
X2 = (x1-x2);
dist = X1*X2;
K = exp((-(dist)^2)/l);