function [ corrected ] = NormaliseImage( finalMatrix, row, col,source )
%NORMALISEIMAGE Histogram match a source image to a reference
    %takes the finalMatrix from readfiles, and the x and y coordinates
    %of the image to normalise. The function acutomatically finds the
    %files in the surrounding neighbourhood and normalises to that
    reference = 0;
    for i = col-3:col+3
        if i >= 1 && i <= size(finalMatrix,2) && finalMatrix(row,i) ~= 0 && i ~= col
            fileName = findFullName(finalMatrix(row,i));
            Im = imread(strcat('./images/',fileName));
            if reference == 0
                reference = Im;
            else
                reference = [reference, Im];
            end
        end
    end
    fileName = findFullName(finalMatrix(row,col));
    %source = imread(strcat('./images/',fileName));

    
    corrected = im2uint16(histeq(im2double(source), hist(im2double(reference(:)),...
    max(max(reference))-min(min(reference)))));
%     figure;
%     subplot(1,2,1);
%     imshow(source);
%     title('The original Image');
%     subplot(1,2,2);
%     imshow(corrected);
%     title('The corrected Image');
end

