function [v,v2] = FindMapping(image1,image2,pixelSize,minArea,position)
% INPUTS:       image1      - Reference image.
%               image2      - Neighbour image.
%               pixelSize   - A 1-2 vector representing the dimensions of
%                           the pixelation in INPUT:'image1' and
%                           INPUT:'image2'.
%               boundary    - A 1-2 vector representing the minimum
%                           proportion of each image dimension to be
%                           considered as a potential overlap.
% OUTPUTS:      v           - A 1-2 vector representing the relative
%                           position of the lower-right most pixel in
%                           INTPUT:'image2' to INPUT:'image1', which
%                           maximised similarity.
%               Sim         - Matrix of similarity measures from overlaps.
% REQUIRED:     EdgeDetector.m
%               Pixelate.m
%               SizeOfOL.m
%               Overlap.m
%               Similarity.m
tic
fSpace1 = EdgeDetector(image1,10000);
fSpace2 = EdgeDetector(image2,10000);
fSpace1pix = Pixelate(fSpace1,pixelSize);
fSpace2pix = Pixelate(fSpace2,pixelSize);
TotalOL = (size(fSpace1pix)+size(fSpace2pix))./pixelSize-[1,1];
index = uint16(zeros(prod(TotalOL),2));
index(:,2) = uint16(repmat([1:TotalOL(2)]',TotalOL(1),1));
index(:,1) = cumsum(index(:,2)==1);
validOL = prod(SizeOfOL(index,pixelSize,...
        [size(fSpace1pix);size(fSpace2pix)]),2)>=...
        minArea*max(numel(fSpace1pix),numel(fSpace2pix));
if      strcmp(position,'U')
    validOL = validOL & index(:,1)*pixelSize(1)-size(fSpace2pix,1)/2<=...
            size(fSpace1pix,1)/2;
elseif  strcmp(position,'D')
    validOL = validOL & index(:,1)*pixelSize(1)-size(fSpace2pix,1)/2>=...
            size(fSpace1pix,1)/2;
elseif  strcmp(position,'L')
    validOL = validOL & index(:,2)*pixelSize(2)-size(fSpace2pix,2)/2<=...
            size(fSpace1pix,2)/2;
elseif  strcmp(position,'R')
    validOL = validOL & index(:,2)*pixelSize(2)-size(fSpace2pix,2)/2>=...
            size(fSpace1pix,2)/2;
elseif  ~strcmp(position,'')
    errorMessage = 'Invalid neighbour label.';
    error(errorMessage);
end
validInd = find(validOL);
Sim = uint32(zeros(size(index,1),1));
for    k = 1:length(validInd)
    overlap1 = Overlap(double(index(validInd(k),:)),fSpace1pix,pixelSize,...
            [size(fSpace1pix);size(fSpace2pix)],1);
    overlap2 = Overlap(double(index(validInd(k),:)),fSpace2pix,pixelSize,...
            [size(fSpace1pix);size(fSpace2pix)],2);
    Sim(validInd(k)) = uint32(Similarity(overlap1,overlap2));
end
v = index(Sim==max(Sim),:).*uint16(pixelSize);
index2 = uint16(zeros(prod(pixelSize),2));
index2(:,2) = uint16(repmat([1:pixelSize(2)]',pixelSize(1),1));
index2(:,1) = cumsum(index2(:,2)==1);
Sim2 = zeros(size(index2,1),1);
for     k = 1:length(Sim2)
    overlap1 = Overlap(double(v-1+index2(k,:)),fSpace1,[1,1],...
            [size(fSpace1);size(fSpace2)],1);
	overlap2 = Overlap(double(v-1+index2(k,:)),fSpace2,[1,1],...
            [size(fSpace2);size(fSpace2)],2);
	Sim2(k) = Similarity(overlap1,overlap2);
end
v2 = v-1+index2(Sim2==max(Sim2),:);
toc