function [ output ] = get_delays( X )
% Return delays between packets. This function assumes that 1st colum
% contains times between packets
if (ismatrix(X)) 
    output = X(2:end,1) - X(1:end-1,1);
elseif (iscell(X))
    n = length(X);
    output = zeros(1,n);
    for i = 1:n,
        output(i) = X{i}(2:end,1) - X{i}(1:end-1,1);
    end
else

end