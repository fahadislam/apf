function [ best_succ ] = GetBestSuccAPF( state , P, map )

succs = GetSuccs(state, map);
min_pot = Inf;
best_succ = [];
for i = 1 : size(succs,1)
    succ_pot = P(succs(i,1), succs(i,2));
    if (succ_pot < min_pot)
        min_pot = succ_pot;
        best_succ = succs(i,:);
    end
end

% if size(best_succs, 1) == 0
%     best_succs
% end

end

