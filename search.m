M = imcomplement(im2bw(rgb2gray(imread('map.png'))));
start = [20 1];
goal = [100 100];
thresh = 20;
G = zeros(size(M));
G(goal(1), goal(2)) = 1;
D = bwdist(M, 'euclidean'); %'euclidean', 'cityblock', 'chessboard', 'quasi-euclidean'
A = bwdist(G, 'euclidean');
R = 1./D;
R = R - (1/thresh);
R = R.*(D < thresh);
R = 10000 * R;
A= A.^2;
P = A + R;
surf(P)

%% Search
limits = [1 size(M, 2) 1 size(M, 1)]; %[x1 x2 y1 y2]

state = start;

while ~isequal(state, goal)
    state = GetBestSuccs(state, P, limits);
    scatter(state(1), state(2));
    axis(limits);
    hold on;
end

close all;
% succs = succs;

