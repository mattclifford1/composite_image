function imageG = EdgeDetector(image,threshold)
% INPUTS:       image       - A single image.
%               threshold   - Minimum edge response to be recorded.
% OUTPUTS:      imageG      - The transformation of INPUT:'image' under the
%                           sum of squared sobel convolutions, stored as a
%                           uint16 matrix.
Gx = [1,0,-1;2,0,-2;1,0,-1];
Gy = [-1,-2,-1;0,0,0;1,2,1];
imageGx = conv2(double(image),Gx);
imageGy = conv2(double(image),Gy);
imageGx = imageGx(2:end-1,2:end-1);
imageGy = imageGy(2:end-1,2:end-1);
imageG = uint16((imageGx.^2+imageGy.^2).^0.5);
imageG(imageG<=threshold)=uint16(0);
