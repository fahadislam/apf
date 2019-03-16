function [ best_succs ] = GetBestSuccs( state , P, limits)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

succs_all = [];
succs_all = [succs_all; [state(1) + 1, state(2)]];
succs_all = [succs_all; [state(1) - 1, state(2)]];
succs_all = [succs_all; [state(1), state(2) + 1]];
succs_all = [succs_all; [state(1), state(2) - 1]];
succs_all = [succs_all; [state(1) + 1, state(2) + 1]];
succs_all = [succs_all; [state(1) - 1, state(2) - 1]];
succs_all = [succs_all; [state(1) + 1, state(2) - 1]];
succs_all = [succs_all; [state(1) - 1, state(2) + 1]];

succs = [];
max_pot = Inf;
for i = 1 : size(succs_all,1)
    if (succs_all(i,1) < limits(1) || succs_all(i,1) > limits(2) || succs_all(i,2) < limits(3) || succs_all(i,2) > limits(4))
        continue;
    end;
    succ_pot = P(succs_all(i,1), succs_all(i,2));
    if (succ_pot < max_pot)
        max_pot = succ_pot;
        best_succs = succs_all(i,:);
    end
    succs = [succs ; succs_all(i,:)];
end
    


end

