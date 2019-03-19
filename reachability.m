% M = imcomplement(im2bw(rgb2gray(imread('map.png'))));

APF = true;
% APF = false;

M = [0 0 0 0 0 0 0 0 0 0
    0 0 0 0 0 0 0 0 0 0
    0 0 0 0 0 0 0 0 0 0
    0 0 0 0 1 1 0 0 0 0
    0 0 0 1 1 1 1 0 0 0
    0 0 0 1 1 1 1 0 0 0
    0 0 0 0 1 1 0 0 0 0
    0 0 0 0 0 0 0 0 0 0
    0 0 0 0 0 0 0 0 0 0
    0 0 0 0 0 0 0 0 0 0];

[obs_X, obs_Y] = ind2sub(size(M), find(M));

limits = [1 size(M, 2) 1 size(M, 1)]; %[x1 x2 y1 y2]

attractor = [5, 10];
Reachable = [];
States = containers.Map();
Open = containers.Map();
Open(char(attractor)) = 0;
States(char(attractor)) = attractor;
Closed = [];

while ~isempty(Open)
    % expand state
    min_idx = find(cell2mat(Open.values) == min(cell2mat(Open.values)));
    keys = Open.keys;
    state = States(char(keys(min_idx(1))));
    remove(Open, char(keys(min_idx(1))));
    
    % check reachability
    if APF
        if (~APFSearch(state, attractor, M))
            break;
        end
    else
        if (~GreedySearch(state, attractor, M))
            break;
        end
    end
    
    % print
    state;
    pdist([state; attractor],'euclidean');
    
    Closed = [Closed {char(state)}];
    succs = GetSuccs(state, M);
    for i = 1 : size(succs,1)
        if ~any(strcmp(Closed,char(succs(i,:))))
            h = pdist([succs(i,:); attractor],'euclidean');
            Open(char(succs(i,:))) = h;
            States(char(succs(i,:))) = succs(i,:);
        end
    end
    
    Reachable = [Reachable ; state];
end

%% Plotting
% Reachable
scatter(Reachable(:,1), Reachable(:,2), 'r');
axis(limits);
hold on;

%attractor
scatter(attractor(1), attractor(2), 'b', 'filled');
hold on

%first unreachable
scatter(state(1), state(2), 'm', 'filled');
hold on

% obstacles
scatter(obs_X, obs_Y, 'k', 'filled');

close all