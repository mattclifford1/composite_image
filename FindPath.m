function [MinSeam1,Vis] = FindPath(e,b,c)

E = zeros(size(e,1),size(e,2),2);

for y = 2:size(e,1)
    for x = 1:size(e,2)
        if ((y-x>=-1) && (b==2)) || ((y+x-size(e,2)>=-1) && (b==3)) || b==1
            if x==1
                Min = min([E(y-1,x,1),E(y-1,x+1,1)]);
            elseif x==size(e,2)
                Min = min([E(y-1,x-1,1),E(y-1,x,1)]);
            else
                Min = min([E(y-1,x-1,1), E(y-1,x,1), E(y-1,x+1,1)]);
            end

            E(y,x,1) = e(y,x) + Min;

            if x ~= 1
                if Min == E(y-1,x-1)
                    E(y,x,2) = -1;
                end
            end         
            if x ~= size(e,2)
                if Min == E(y-1,x+1)
                    E(y,x,2) = 1;
                end            
            end
        else
            E(y,x,1) = Inf;
        end
    end
end

MinSeam1 = ones(size(e));

if b == 1
    MinPath = min(E(end,:,1));
elseif b == 3
    MinPath = E(end,1,1);
else
    MinPath = E(end,end,1);   
end

Vis = MinPath;

for yr = 1:size(e,1)
    line = 1;
    y = 1-yr+size(e,1);
    for x = 1:size(e,2)
        if yr==1
            if E(y,x,1) == MinPath
                if c == 1
                    Vis = Vis + sum(e(y,x:end)) - e(y,x);
                else
                    Vis = Vis + sum(e(y,1:x)) - e(y,x);
                end
                line = 0;
                if y~=1
                    Coordinate = x+(E(y,x,2));
                end
            end
        elseif x == Coordinate
            line = 0;
            if y~=1
                Coordinate = x+(E(y,x,2));
            else
                if c == 1
                    Vis = Vis + sum(e(y,1:x)) - e(y,x);
                else
                    Vis = Vis + sum(e(y,x:end)) - e(y,x);
                end
            end
        end
        MinSeam1(y,x) = line;
        
        if y==1
            MinSeam1(y,x) = MinSeam1(2,x);
        end
    end 
end
end