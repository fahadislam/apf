M = imcomplement(im2bw(rgb2gray(imread('map.png'))));
limits = [1 size(M, 2) 1 size(M, 1)]; %[x1 x2 y1 y2]

%% params
obs_thresh = 20;
mul_R = 10000;

%% start and goal
start = [1 1];
goal = [100 100];

%% attractive and repulsive potentials
G = zeros(size(M));
G(goal(1), goal(2)) = 1;
D = bwdist(M, 'euclidean'); %'euclidean', 'cityblock', 'chessboard', 'quasi-euclidean'
A = bwdist(G, 'euclidean');
R = 1./D;
R = R - (1/obs_thresh);
R = R.*(D < obs_thresh);
R = mul_R * R;
A= A.^2;
P = A + R;

%% search
state = start;
path = []
while ~isequal(state, goal)
    state = GetBestSuccAPF(state, P, M);
    path = [path ; state];
end

path_pot = P(sub2ind(size(P), path(:,1), path(:,2)));
surf(P);
hold on;
scatter3(path(:,1), path(:,2), path_pot);
axis(limits);

close all;
% succs = succs;

