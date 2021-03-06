function [O1,O2,Vis] = MergeGrad(I1,I2,v,a)
% INPUTS:       I1, I2      - Two input images with an overlap.
%               v           - A vector showing the displacement of I2 over
%                           I1 of where the overlap region is.
%               a           - The method used to minimise the seam. The 
%                           variable a will equal 1 when there is a single
%                           horizontal or vertical curve in the overlap, a
%                           will equal 2 when there are both a horizontal
%                           and a vertical curve and a will equal 3 when
%                           the curve is strictly diagonal.
% OUTPUTS:      O1, O2      - Two output images with their edited overlap
%                           regions.

% Sets i and j to the values in the vector
i = v(1);
j = v(2);

if i > size(I1,1)   
    p = 1;
    T1Sx = i - size(I2,1);
    T1Fx = size(I1,1);
    T2Sx = 1;
    T2Fx = size(I1,1) + size(I2,1) - i + 1;   
else
    p = 2;
    T1Sx = 1;
    T1Fx = i;
    T2Sx = size(I2,1) - i + 1;
    T2Fx = size(I2,1);    
end

if j > size(I1,2)
    r = 1;
    T1Sy = j - size(I2,2);
    T1Fy = size(I1,2);
    T2Sy = 1; 
    T2Fy = size(I1,2) + size(I2,2) - j + 1;
else
    r = 2;
    T1Sy = 1;
    T1Fy = j;  
    T2Sy = size(I2,2) - j + 1; 
    T2Fy = size(I2,2);        
end

if p == r
    c = 2;
else 
    c = 1;
end

omega1 = I1(T1Sx:T1Fx,T1Sy:T1Fy);
omega2 = I2(T2Sx:T2Fx,T2Sy:T2Fy);

e = round(abs(double(omega1) - double(omega2))).^2;

if a ~= 3
    
    if a == 2 || size(e,1) >= size(e,2)
        [MinSeam1y,Vis1] = FindPath(e,1,c);
        if a==2 && j < size(I1,2)
            MinSeam1y = ones(size(MinSeam1y)) - MinSeam1y;
        end
        MinSeam2y = ones(size(MinSeam1y)) - MinSeam1y;
    end
    
    if a == 2 || size(e,1) < size(e,2)
        [MinSeam1x,Vis2] = FindPath(transpose(e),1,c);
        MinSeam1x = transpose(MinSeam1x);
        if a==2 && i < size(I1,1)
            MinSeam1x = ones(size(MinSeam1x)) - MinSeam1x;
        end
        MinSeam2x = ones(size(MinSeam1x)) - MinSeam1x;
    end
    
    if a == 2
        
        MeanSeam1 = 0.5*(MinSeam1y + MinSeam1x);
        MeanSeam2 = 0.5*(MinSeam2y + MinSeam2x);
        Vis = mean(Vis1,Vis2);
        
    elseif size(e,1) > size(e,2)
        Vis = Vis1;
        MeanSeam1 = MinSeam1y;
        MeanSeam2 = MinSeam2y;
        
    else
        Vis = Vis2;
        MeanSeam1 = MinSeam1x;
        MeanSeam2 = MinSeam2x;  
        
    end
    
elseif size(e,1) >= size(e,2)
    if (j>size(I1,2)&&i>size(I1,2))||(j<size(I1,2)&&i<size(I1,2))
        [MeanSeam1,Vis] = FindPath(e,3,c);
        MeanSeam2 = ones(size(MeanSeam1)) - MeanSeam1;
    else
        [MeanSeam1,Vis] = FindPath(e,2,c);
        MeanSeam2 = ones(size(MeanSeam1)) - MeanSeam1;        
    end
else 
    if (j>size(I1,2)&&i>size(I1,2))||(j<size(I1,2)&&i<size(I1,2))
        [MeanSeam1,Vis] = FindPath(transpose(e),2,c);
        MeanSeam1 = transpose(MeanSeam1);
        MeanSeam2 = ones(size(MeanSeam1)) - MeanSeam1;
    else
        [MeanSeam1,Vis] = FindPath(transpose(e),3,c);
        MeanSeam1 = transpose(MeanSeam1);
        MeanSeam2 = ones(size(MeanSeam1)) - MeanSeam1;        
    end    
end

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

O1 = I1;
O2 = I2;

O1(T1Sx:T1Fx,T1Sy:T1Fy) = omega;
O2(T2Sx:T2Fx,T2Sy:T2Fy) = omega;
end