function neighbours = neighbourFind(im1, im2, V)

nUp = get_sim(im1, im2, V + [-1, 0]);
nDown = get_sim(im1, im2, V + [1, 0]);
nRight = get_sim(im1, im2, V + [0, -1]);
nLeft = get_sim(im1, im2, V + [0, 1]);
nUR = get_sim(im1, im2, V + [-1, -1]);
nUL = get_sim(im1, im2, V + [-1, 1]);
nDR = get_sim(im1, im2, V + [1, -1]);
nDL = get_sim(im1, im2, V + [1, 1]);
neighbours = [nUp, nDown, nRight, nLeft, nUR, nUL, nDR, nDL];