function find_Overlap(im1, im2)

s1 = size(im1); s2 = size(im2);

V = [0, 200];
sim = 0; 
neighbour = 1;
while sim < neighbour
    sim = get_sim(im1, im2, V);
    nUp = get_sim(im1, im2, V + [-1, 0]);
    nDown = get_sim(im1, im2, V + [1, 0]);
    nRight = get_sim(im1, im2, V + [0, -1]);
    nLeft = get_sim(im1, im2, V + [0, 1]);
    neighbours = [nUp, nDown, nLeft, nRight];
    neighbour = max(neighbours);
 
    sim
    neighbour
end


