function  filter = filterPick2(n)
if n == 0 
    filter = [];
elseif n == 1 
    filter = 2;
elseif n == 2
    filter = [ 5, 2];
elseif n == 3
   filter = [4, 4, 6];
elseif n == 4
   filter = [ 4, 3, 5, 10];
end
end

