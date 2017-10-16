function [ corrected ] = NormaliseImage( finalMatrix, xcoord, ycoord )
%NORMALISEIMAGE Histogram match a source image to a reference
    %takes the finalMatrix from readfiles, and the x and y coordinates
    %of the image to normalise. The function acutomatically finds the
    %files in the surrounding neighbourhood and normalises to that
    reference = 0;
    for i = xcoord-3:xcoord+3
        if i >= 1 && i <= size(finalMatrix,2) && finalMatrix(ycoord,i) ~= 0 && i ~= xcoord
            fileName = findFullName(finalMatrix(ycoord,i));
            Im = imread(strcat('./images/',fileName));
            if reference == 0
                reference = Im;
            else
                reference = [reference, Im];
            end
        end
    end
    fileName = findFullName(finalMatrix(ycoord,xcoord));
    source = imread(strcat('./images/',fileName));
    
    corrected = im2uint16(histeq(im2double(source), hist(im2double(reference(:)))));
end

