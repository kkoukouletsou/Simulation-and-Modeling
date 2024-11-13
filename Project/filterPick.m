function [filter] = filterPick(n)
if n == 1
    filter = [1 2];
elseif n == 2
    filter = [1 5 6];
elseif n == 3
    filter = [1 4 2 7];
elseif n == 4
    filter = [1 2 5 4 8];
elseif n == 5
    filter = [1 5 3 2 3 4];
end
end


