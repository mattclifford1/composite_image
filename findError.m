function Location = findError(ExposureMatrix)
    Intensity = ExposureMatrix;
    rows = size(Intensity,1);
    cols = size(Intensity,2);
    IntensityMean = [1,rows];
    for i=1:rows
        IntensityMean(i) = mean(Intensity(i,:));
    end
    errCount = 0;
    for y=1:rows
       for x=1:cols
             if Intensity(y,x) < IntensityMean(y)-(IntensityMean(y)/3) || Intensity(y,x) > IntensityMean(y)+(IntensityMean(y)/3) 
                 if Intensity(y,x) ~= 0
                     errCount = errCount + 1;
                     Location(errCount,:) = [y,x];
                 end
             end
       end
    end    
end
