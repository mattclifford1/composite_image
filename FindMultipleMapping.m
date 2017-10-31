function [Vfine,Labels,simMaxVals,OLSizes] = FindMultipleMapping(f,threshold,pixelSize,minArea,W)
% INPUTS:       f           - List of frame numbers.
%               pixelSize   - A 1-2 vector representing the dimensions of
%                             the pixelation in INPUT:'image1' and
%                             INPUT:'image2'.
%               minArea     - A 1-2 vector representing the minimum
%                             area of the images considered as a potential
%                             overlap.
% OUTPUTS:      Vfine       - A Matrix of row vectors representing the
%                             relative positions of the lower-right most
%                             pixels in frames INTPUT:'image2'(2:end) to
%                             frames INPUT:'image1'(1:end-1), which
%                             maximises similarities.
%               Labels      - List of strings indicating where frames
%                             INTPUT:'f'(2:end) appear in the composite
%                             image with respect to frames
%                             INPUT:'f'(1:end-1).
%               simMaxVals  - List of maximised similarity measures from
%                             overlaps between frames INTPUT:'f'.
% REQUIRED:     BuildFrameNameLookup.m
%               FindMapping.m
tic
frames = BuildFrameNameLookup(4);
Vfine = zeros(length(f)-1,2);
Labels = cell(length(f)-1,1);
simMaxVals = zeros(size(Vfine,1),1);
OLSizes = zeros(length(f)-1,2);
for     n = 1:size(Vfine,1)
    [v2,nl,sim,OL] = FindMapping(f(n),f(n+1),threshold,...
            pixelSize,minArea,W,frames);
    Labels{n} = nl;
    Vfine(n,:) = v2;
    simMaxVals(n) = max(sim);
    OLSizes(n,:) = OL;
end
toc