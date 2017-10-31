function S = Similarity(overlap1,overlap2,W)
% INPUTS:       overlap1    - A matrix of feature space values in the
%                           overlap of the reference image.
%               overlap2    - A matrix of feature space values in the
%                           overlap of the neighbour image.
% OUTPUTS:      S           - A scalar value proportional to the similarity
%                           of INPUT:'overlap1' and INPUT:'overlap2'.
if      ~prod(size(overlap1)==size(overlap2))
    errorMessage = 'Dimensions of overlaps are not equal.';
    error(errorMessage);
end
% S = sum(sum(overlap1.*overlap2))-...
% sum(overlap1(overlap1~=0 & overlap2==0))-...
% sum(overlap2(overlap2~=0 & overlap1==0));
S = sum(sum(overlap1.*overlap2))-...
	W*sum(sum(abs(overlap1-overlap2)));