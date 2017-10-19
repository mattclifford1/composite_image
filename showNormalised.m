function [ neighbourhood ] = showNormalised( finalMatrix, col, yrow)
    neighbourhood = 0;
    for y = yrow-1:yrow+1
        row = 0;
        for x = col-1:col+1
            square = im2uint16(zeros(476,476));
            if x > 0 && y > 0 && x < size(finalMatrix,2) && y < size(finalMatrix,1) && finalMatrix(y,x) > 0
                fileName = findFullName(finalMatrix(y,x));
            	square = imread(strcat('./images/',fileName));
                
            end
            if x == col && y == yrow
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
    figure;
    imshow(neighbourhood);

end

