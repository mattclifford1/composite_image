function [v2,NL,Sim,OLSize] = FindMapping(f1,f2,threshold,pixelSize,minArea,W,frames,folder)
% INPUTS:       f1          - Reference frame number.
%               f2          - Neighbour frame number.
%               pixelSize   - A 1-2 vector representing the dimensions of
%                             the pixelation in INPUT:'image1' and
%                             INPUT:'image2'.
%               minArea     - A 1-2 vector representing the minimum
%                             area of the images considered as a potential
%                             overlap.
%               frames      - Structure containing a sorted list of frame
%                             numbers and respective file names.
% OUTPUTS:      v2          - A 1-2 vector representing the fine relative
%                             position of the lower-right most pixel in
%                             INTPUT:'image2' to INPUT:'image1', which
%                             maximises similarity.
%               NL          - String indicating where frame INTPUT:'f2'
%                             appears in the composite image with respect
%                             to frame INTPUT:'f1'.
%               Sim         - Vector of similarity measures from overlaps.
% REQUIRED:     EdgeDetector.m
%               Pixelate.m
%               SizeOfOL.m
%               Overlap.m
%               Similarity.m
%               NeighbourLabel.m
%               ./images/
image1 = imread([folder,frames.fileName{find(frames.number==f1,1)}]);
image2 = imread([folder,frames.fileName{find(frames.number==f2,1)}]);
fSpace1 = EdgeDetector(image1,threshold);
fSpace2 = EdgeDetector(image2,threshold);
fSpace1pix = Pixelate(fSpace1,pixelSize);
fSpace2pix = Pixelate(fSpace2,pixelSize);
TotalOL = (size(fSpace1pix)+size(fSpace2pix))./pixelSize-[1,1];
index = uint16(zeros(prod(TotalOL),2));
index(:,2) = uint16(repmat(transpose(1:TotalOL(2)),TotalOL(1),1));
index(:,1) = cumsum(index(:,2)==1);
validOL = prod(SizeOfOL(index,pixelSize,...
        [size(fSpace1pix);size(fSpace2pix)]),2)>=...
        minArea*max(numel(fSpace1pix),numel(fSpace2pix));
NL = NeighbourLabel(f1,f2);
if      strcmp(NL,'U')
    validOL = validOL & index(:,1)*pixelSize(1)-size(fSpace2pix,1)/2<=...
            size(fSpace1pix,1)/2;
elseif  strcmp(NL,'D')
    validOL = validOL & index(:,1)*pixelSize(1)-size(fSpace2pix,1)/2>=...
            size(fSpace1pix,1)/2;
elseif  strcmp(NL,'L')
    validOL = validOL & index(:,2)*pixelSize(2)-size(fSpace2pix,2)/2<=...
            size(fSpace1pix,2)/2;
elseif  strcmp(NL,'R')
    validOL = validOL & index(:,2)*pixelSize(2)-size(fSpace2pix,2)/2>=...
            size(fSpace1pix,2)/2;
elseif  ~strcmp(NL,'')
    errorMessage = 'Invalid neighbour label.';
    error(errorMessage);
end
validInd = find(validOL);
Sim = uint32(zeros(size(index,1),1));
cancel = 0;
while   max(Sim)==0 && ~cancel
    for     k = 1:length(validInd)
        overlap1 = Overlap(double(index(validInd(k),:)),fSpace1pix,pixelSize,...
                [size(fSpace1pix);size(fSpace2pix)],1);
        overlap2 = Overlap(double(index(validInd(k),:)),fSpace2pix,pixelSize,...
                [size(fSpace1pix);size(fSpace2pix)],2);
        Sim(validInd(k)) = uint32(Similarity(overlap1,overlap2,W));
    end
    if      W==1
        cancel = 1;
    end
    W = 1;
end
v = index(Sim==max(Sim),:).*uint16(pixelSize);
index2 = uint16(zeros(prod(pixelSize),2));
index2(:,2) = uint16(repmat(transpose(1:pixelSize(2)),pixelSize(1),1));
index2(:,1) = cumsum(index2(:,2)==1);
Sim2 = zeros(size(index2,1),1);
for     k = 1:length(Sim2)
    overlap1 = Overlap(double(v-1+index2(k,:)),fSpace1,[1,1],...
            [size(fSpace1);size(fSpace2)],1);
	overlap2 = Overlap(double(v-1+index2(k,:)),fSpace2,[1,1],...
            [size(fSpace2);size(fSpace2)],2);
	Sim2(k) = Similarity(overlap1,overlap2,W);
end
v2 = v-1+index2(Sim2==max(Sim2),:);
OLSize = SizeOfOL(v2,[1,1],[size(image1);size(image2)]);