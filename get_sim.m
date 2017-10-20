function sim = get_sim(im1, im2, V)

s1 = size(im1); s2 = size(im2);

if V(1) < 0  %right above left
    A = im1( 1:s1(1) + V(1) , s1(2) - V(2) + 1:end );
    B = im2( -V(1)+1:end, 1: V(2) );
end
if V(1) > 0  %left above right
    A = im1( V(1)+1:end , s1(2) - V(2) + 1:end );
    B = im2( 1:s2(1) - V(1), 1: V(2) );
end
if V(1) == 0 
   A = im1( 1:end , s1(2) - V(2) + 1 :end );
   B = im2( 1:end, 1: V(2) ); 
end
sim = sum(sum(A.*B));