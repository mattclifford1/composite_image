function [Render1,Render2] = MergeGrad(I1,I2,v)

% [dI1dx,dI1dy,dI2dx,dI2dy] = FindGrad(I1,I2);

i = v(1);
j = v(2);

if i > size(I1,1)    
    disp(1)
    T1Sx = i - size(I2,1);
    T1Fx = size(I1,1);
    T2Sx = 1;
    T2Fx = size(I1,1) + size(I2,1) - i + 1;   
else
    disp(2)
    T1Sx = 1;
    T1Fx = i;
    T2Sx = size(I2,1) - i + 1;
    T2Fx = size(I2,1);    
end

if j > size(I1,2)
    disp(3)
    T1Sy = j - size(I2,2);
    T1Fy = size(I1,2);
    T2Sy = 1; 
    T2Fy = size(I1,2) + size(I2,2) - j + 1;
else
    disp(4)
    T1Sy = 1;
    T1Fy = j;  
    T2Sy = size(I2,2) - j + 1; 
    T2Fy = size(I2,2);        
end

% disp(T1Sx)
% disp(T1Fx)
% disp(T1Sy)
% disp(T1Fy)
% disp(T2Sx)
% disp(T2Fx)
% disp(T2Sy)
% disp(T2Fy)

omega1 = I1(T1Sx:T1Fx,T1Sy:T1Fy);
omega2 = I2(T2Sx:T2Fx,T2Sy:T2Fy);


imshow(omega1)
figure, imshow(omega2)
% do1dx = dI1dx(T1Sx:T1Fx,T1Sy:T1Fy);
% do2dx = dI2dx(T2Sx:T2Fx,T2Sy:T2Fy);
% do1dy = dI1dy(T1Sx:T1Fx,T1Sy:T1Fy);
% do2dy = dI2dy(T2Sx:T2Fx,T2Sy:T2Fy);

% Fx = abs(do1dx+do2dx);
% Fy = abs(do1dy+do2dy);

e = round(abs(double(omega1) - double(omega2)));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

MinSeam1y = FindPath(e);

MinSeam1x = transpose(FindPath(transpose(e)));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

MinSeam2x = ones(size(MinSeam1x)) - MinSeam1x;
MinSeam2y = ones(size(MinSeam1y)) - MinSeam1y;

MeanSeam1 = 0.5*(MinSeam1y + MinSeam1x);
MeanSeam2 = 0.5*(MinSeam2y + MinSeam2x);

disp(max(max(MeanSeam1)))

figure, imshow(MeanSeam1)
figure, imshow(MeanSeam2)

disp(i)
disp(j)

if size(e,1) >= size(e,2)
    if j > size(I1,2)
        omega = double(omega1).*(MeanSeam1) + double(omega2).*(MeanSeam2);
    else
        omega = double(omega1).*(MeanSeam2) + double(omega2).*(MeanSeam1);
    end
else
    if i > size(I1,1)
        omega = double(omega1).*(MeanSeam1) + double(omega2).*(MeanSeam2);
    else
        omega = double(omega1).*(MeanSeam2) + double(omega2).*(MeanSeam1);
    end   
end

omega = uint16(omega);

Render1 = I1;
Render2 = I2;

Render1(T1Sx:T1Fx,T1Sy:T1Fy) = omega;
Render2(T2Sx:T2Fx,T2Sy:T2Fy) = omega;

figure, imshow(omega)
end