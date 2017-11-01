function [joint, vertShift, horiShift] =  stitch(Im1, Im2, V1, ImBottom, ImEnd)
vertShift = ImBottom;
horiShift = ImEnd;
% V1 is vector from Im1 to Im2
s1 = size(Im1); s2 = size(Im2);
V = V1 - s2;    %change to workable vector
VB = V(2) + ImEnd;  %take vector to two images that are overlapped
Vcopy = V;
V = V + [ImBottom, ImEnd];
%workout size of new image
row = s1(1);
if V(1) < 0     %need new space above Im1
    Va = abs(V);
    row = s1(1) + Va(1);
end
leftSpace = 0;
if Vcopy(2)+s2(2) - s1(2)  <= 0
    if V(2) >= 0  % Im2 doesn't go beyond left of Im1
        col = s1(2);
    else       %need new space to left of Im1
        col = s1(2) - V(2);
        leftSpace = 1;
    end
else   %need new space to right of Im1
    col = s1(2) + Vcopy(2);
    
end

joint = uint16(zeros(row,col));  s3 = size(joint);
if V(2) > 0    % Im1 to the left of Im2
    if V(1) >= 0   %Im1 above Im2
        joint(1:s1(1), 1:s1(2)) = Im1(1:end, 1:end);
        joint(V(1)+1:s2(1)+V(1), VB+1:VB+s2(2)) = Im2(1:end, 1:end);
        vertShift = V(1);
    end
    if V(1) < 0  %Im1 below Im2
        joint(Va(1)+1:end, 1:s1(2)) = Im1(1:end, 1:end);
        joint(1:s2(1), VB+1:VB+s2(2)) = Im2(1:end, 1:end);
        vertShift = 0;
    end
    horiShift = V(2);
end
sj = size(joint);
if V(2) <= 0    %Im1 to the right of Im2
    if leftSpace ~= 1 %Im2 doesn't go beyond the very left of Im1
        if V(2) == 0
            joint(Va(1) + 1:Va(1) + s1(1), 1:s1(2)) = Im1(1:end, 1:end);
            joint(1:s2(1)-1, V(2):V(2)+s2(2)) = Im2(1:end, 1:end);
            horiShift = horiShift;
        else
            if V(1) >= 0    %Im1 above Im2
                joint(1:s1(1), 1:s1(2)) = Im1(1:end, 1:end);
                joint(V(1)+1:s2(1)+V(1), sj(2)+V(2)-s2(2)+1:sj(2) + V(2)) = Im2(1:end, 1:end);
            end
            if V(1) < 0    %Im1 below Im2
                joint(Va(1):Va(1)-1 + s1(1), 1:s1(2)) = Im1(1:end, 1:end);
                joint(1:s2(1), sj(2)+V(2)-s2(2)+1:sj(2) + V(2)) = Im2(1:end, 1:end);
            end
            vertShift = V(1)
            s3 = size(joint);
            horiShift = s3(2) - s2(2);
        end 
    end
    %     if s1(2) + V(2) -s2(2) < 0  %Im2 goes beyond the very left of Im1
    if leftSpace == 1    %Im2 goes beyond the very left of Im1
        sj = size(joint);
        if V(1) >= 0    %Im1 above Im2
            %             sj(2)-s1(1)+1
            joint(1:s1(1), abs(V(2))+1:sj(2)) = Im1(1:end, 1:end);
            joint(V(1)+1:s2(1)+V(1), 1:s2(2)) = Im2(1:end, 1:end);
            vertShift = V(1);
            horiShift = 0;
        end
        if V(1) < 0    %Im1 below Im2
            joint(Va(1)+1:end, abs(V(2))+1:sj(2)) = Im1(1:end, 1:end);
            joint(1:s2(1), 1:s2(2)) = Im2(1:end, 1:end);
            horiShift = 0;
            vertShift = vertShift;
        end
        %         vertShift = V(1);
        %         s3 = size(joint);
        %         horiShift = s3(2) - s2(2);
    end
end
