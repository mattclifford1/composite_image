function Visibility = SeamRemoval(folder,frames,v,a)

Visibility = zeros(248,1);

I1 = imread([folder,frames.fileName{(frames.number==frames.number(1))}]);
I2 = imread([folder,frames.fileName{(frames.number==frames.number(2))}]);

for h = 1:248
    [O1,O2,Vis] = MergeGrad(I1,I2,v(h,:),a);
    Visibility(h) = Vis;
    imwrite(O1,strcat('noSeam',num2str(a),'/',frames.fileName{find(frames.number==h,1)}),'.tif')
    if h~=248
        I1 = O2;
        I2 = imread(['noscratch/',frames.fileName{(frames.number==frames.number(2+h))}]);
    end
end

imwrite(O2,strcat('noSeam',num2str(a),'/',frames.fileName{find(frames.number==h,1)}),'.tif')

end