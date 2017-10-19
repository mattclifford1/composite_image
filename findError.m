function Errors = findError(ExposureMatrix)
    Intensity = ExposureMatrix
    rows = size(Intensity,1);
    for i=1:rows
        IntensityMean(i) = mean(Intensity(i,:));
        
    end
    
    IntensityMean'
end
