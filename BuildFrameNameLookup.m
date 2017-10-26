function frames = BuildFrameNameLookup(exclude);
% INPUTS:       exclude     - List of frame numbers to not be included.
% OUTPUTS:      frames      - Structure containing a sorted list of frame
%                             numbers and respective file names.
% REQUIRED:     ./images/
tic
imageFiles = dir('./images/*.tif');
frames.number = zeros(length(imageFiles),1);
frames.fileName = cell(length(frames.number),1);
for     n = 1:length(imageFiles)
    frames.fileName{n} = imageFiles(n).name;
    strLim = strfind(frames.fileName{n},' ');
    frameStr = extractBetween(frames.fileName(n),strLim(1)+1,strLim(2)-1);
    frames.number(n) = str2num(frameStr{:});
end
[frames.number,I] = sort(frames.number);
frames.fileName = frames.fileName(I);
if      numel(exclude)~=0
    index = find(ismember(frames.number,exclude));
    frames.number(index) = [];
    frames.fileName(index) = [];
end
toc