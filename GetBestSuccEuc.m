function [ best_succ ] = GetBestSuccEuc( state, goal, map )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

succs = GetSuccs(state, map);
min_h = Inf;
best_succ = [];
for i = 1 : size(succs,1)
    succ_h = pdist([succs(i,:); goal],'euclidean');
    if (succ_h < min_h)
        min_h = succ_h;
        best_succ = succs(i,:);
    end
end

end

