function label = NeighbourLabel(image1num,image2num,frames)
% INPUTS:       image1num   - Reference image number.
%               image2num   - Neighbour image number.
%   OPTIONAL:   frames      - Matrix of frame numbers.
% OUTPUTS:      label       - String indicating where frame
%                             INTPUT:'image2num' appears in the composite
%                             image with respect to frame
%                             INTPUT:'image1num'.
% REQUIRED:     DAmatrix.m  - If INPUT:'frames' is not given.
if      nargin==2
    frames = DAmatrix();
end
if      isempty(find(frames(frames~=0)==image1num,1)) ||...
        isempty(find(frames(frames~=0)==image2num,1))
    errorMessage = 'Invalid frame number.';
    error(errorMessage);
end
frameList = sort(frames(:));
label = '';
if      abs(find(frameList==image1num,1)-find(frameList==image2num,1))==1
    labelList = {'R','L','D','U'};
    for         n = 1:length(labelList)
        try
            if      find(frames(1+strcmp(labelList{n},'U'):...
                    end-strcmp(labelList{n},'D'),...
                    1+strcmp(labelList{n},'L'):...
                    end-strcmp(labelList{n},'R'))==image1num,1)==...
                    find(frames(1+strcmp(labelList{n},'D'):...
                    end-strcmp(labelList{n},'U'),...
                    1+strcmp(labelList{n},'R'):...
                    end-strcmp(labelList{n},'L'))==image2num,1)
                label = labelList{n};
                break;
            end
        catch ERROR
            if      ~strcmp(ERROR.identifier,'MATLAB:dimagree')
                disp(ERROR.identifier)
                rethrow(ERROR)
            end
        end
    end
end