function [ succs ] = GetSuccs( state, map )

limits = [1 size(map, 2) 1 size(map, 1)];

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
for i = 1 : size(succs_all,1)
    if (succs_all(i,1) < limits(1) || succs_all(i,1) > limits(2) || succs_all(i,2) < limits(3) || succs_all(i,2) > limits(4))
        continue;
    end
    if (map(succs_all(i,1), succs_all(i,2)) == 1)
        continue;
    end
    succs = [succs ; succs_all(i,:)];
end

end

