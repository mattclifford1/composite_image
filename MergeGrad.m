function [Render1,Render2] = MergeGrad(I1,I2,v)

% [dI1dx,dI1dy,dI2dx,dI2dy] = FindGrad(I1,I2);

i = v(1);
j = v(2);

if i > size(I1,1)    
%     disp(1)
    T1Sx = i - size(I2,1);
    T1Fx = size(I1,1);
    T2Sx = 1;
    T2Fx = size(I1,1) + size(I2,1) - i + 1;   
else
%     disp(2)
    T1Sx = 1;
    T1Fx = i;
    T2Sx = size(I2,1) - i + 1;
    T2Fx = size(I2,1);    
end

if j > size(I1,2)
%     disp(3)
    T1Sy = j - size(I2,2);
    T1Fy = size(I1,2);
    T2Sy = 1; 
    T2Fy = size(I1,2) + size(I2,2) - j + 1;
else
%     disp(4)
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

% do1dx = dI1dx(T1Sx:T1Fx,T1Sy:T1Fy);
% do2dx = dI2dx(T2Sx:T2Fx,T2Sy:T2Fy);
% do1dy = dI1dy(T1Sx:T1Fx,T1Sy:T1Fy);
% do2dy = dI2dy(T2Sx:T2Fx,T2Sy:T2Fy);

% Fx = abs(do1dx+do2dx);
% Fy = abs(do1dy+do2dy);

e = round(abs(double(omega1) - double(omega2)));

% imshow(uint16(e));
% disp(max(max(e)))
Ev = zeros(size(e,1),size(e,2),2);

for y = 2:size(e,1)
    for x = 1:size(e,2)
        if x==1
            Min = min([Ev(y-1,x,1),Ev(y-1,x+1,1)]);
        elseif x==size(e,2)
            Min = min([Ev(y-1,x-1,1),Ev(y-1,x,1)]);
        else
            Min = min([Ev(y-1,x-1,1), Ev(y-1,x,1), Ev(y-1,x+1,1)]);
        end
        
        Ev(y,x,1) = e(y,x) + Min;
        
        if x ~= 1
            if Min == Ev(y-1,x-1)
                Ev(y,x,2) = -1;
            end
        end         
        if x ~= size(e,2)
            if Min == Ev(y-1,x+1)
                Ev(y,x,2) = 1;
            end            
        end
    end
end

MinSeam1 = ones(size(e));

MinPath = min(Ev(end,:,1));

for yr = 1:size(e,1)
    line = 1;
    y = 1-yr+size(e,1);
    for x = 1:size(e,2)
        if Ev(y,x,1) == MinPath
            line = 0;
            if y~=1
                MinPath2 = Ev(y-1,x+(Ev(y,x,2)),1);
            end
        end
        MinSeam1(y,x) = line;
        
        if y==1
            MinSeam1(y,x) = MinSeam1(2,x);
        end
    end 
    MinPath = MinPath2;
end

MinSeam2 = ones(size(MinSeam1)) - MinSeam1;

omega = omega1.*uint16(MinSeam1) + omega2.*uint16(MinSeam2);

Render1 = I1;
Render2 = I2;

Render1(T1Sx:T1Fx,T1Sy:T1Fy) = omega;
Render2(T2Sx:T2Fx,T2Sy:T2Fy) = omega;

end