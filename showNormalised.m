function [ neighbourhood ] = showNormalised( finalMatrix, xcoord, ycoord )
    neighbourhood = 0;
    for y = ycoord-1:ycoord+1
        row = 0;
        for x = xcoord-1:xcoord+1
            square = im2uint16(zeros(476,476));
            if x > 0 && y > 0 && x < size(finalMatrix,2) && y < size(finalMatrix,1) && finalMatrix(y,x) > 0
                fileName = findFullName(finalMatrix(y,x));
            	square = imread(strcat('./images/',fileName));
                
            end
            if x == xcoord && y == ycoord
                square = NormaliseImage(finalMatrix, x, y);
            end
            if row == 0
                row = square;
            else
                row = [row, square];
            end
        end
        if neighbourhood == 0
            neighbourhood = row;
        else
            neighbourhood = [neighbourhood; row];
        end
    end
    

end

