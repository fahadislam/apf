function [ reachable ] = APFSearch( start, goal, map )

%% params
obs_thresh = 2;
mul_R = 50;

%% attractive and repulsive potentials
G = zeros(size(map));
G(goal(1), goal(2)) = 1;
D = bwdist(map, 'euclidean'); %'euclidean', 'cityblock', 'chessboard', 'quasi-euclidean'
A = bwdist(G, 'euclidean');
R = 1./D;
R = R - (1/obs_thresh);
R = R.*(D < obs_thresh);
R = mul_R * R;
A= A.^2;
P = A + R;

%% search
state = start;
path = [];
while ~isequal(state, goal)
    succ = GetBestSuccAPF(state, P, map);
    if (P(succ(1), succ(2)) >= P(state(1), state(2)))
        reachable = false;
        return;
    end
    path = [path ; succ];
    state = succ;
end

reachable = true;

% path_pot = P(sub2ind(size(P), path(:,1), path(:,2)));
% surf(P);
% hold on;
% scatter3(path(:,1), path(:,2), path_pot);
% axis(limits);
% close all;

end

