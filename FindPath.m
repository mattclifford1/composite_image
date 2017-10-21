function MinSeam1 = FindPath(e)

E = zeros(size(e,1),size(e,2),2);

for y = 2:size(e,1)
    for x = 1:size(e,2)
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
    end
end

MinSeam1 = ones(size(e));

MinPath = min(E(end,:,1));

for yr = 1:size(e,1)
    line = 1;
    y = 1-yr+size(e,1);
    for x = 1:size(e,2)
        if E(y,x,1) == MinPath
            line = 0;
            if y~=1
                MinPath2 = E(y-1,x+(E(y,x,2)),1);
            end
        end
        MinSeam1(y,x) = line;
        
        if y==1
            MinSeam1(y,x) = MinSeam1(2,x);
        end
    end 
    MinPath = MinPath2;
end

end