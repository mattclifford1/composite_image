function [Vlr,Vud] = StandardiseMapping(V,Labels,imageSize)
Vcent = V-repmat(imageSize,size(V,1),1);
Vstand = Vcent.*(-1).^(repmat(strcmp('L',Labels) | strcmp('U',Labels),1,2));
Vlr = Vstand(strcmp('L',Labels) | strcmp('R',Labels),:);
Vud = Vstand(strcmp('U',Labels) | strcmp('D',Labels),:);