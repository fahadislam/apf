function [ reachable ] = GreedySearch( start, goal, map )

map_free = zeros(size(map));
%% search
state = start;
path = [];
while ~isequal(state, goal)
    succ = GetBestSuccEuc(state, goal, map_free);
    if (pdist([succ; goal],'euclidean') >= pdist([state; goal],'euclidean'))
        reachable = false;
        return;
    end
    
    if (map(state(1), state(2)) == 0 && (map(succ(1), succ(2)) == 1))
        reachable = false;
        return;
    end

    path = [path ; succ];
    state = succ;
end

reachable = true;
end

