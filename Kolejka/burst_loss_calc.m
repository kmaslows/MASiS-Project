function [ avg dev seq_vec] = burst_loss_calc( data )
% Calculates average length of lost packet sequences
% Input data can be in two formats:
% 1. Vector of lost packets numbers for example: [ 1 3 4 6 7 8 1 10 11 12 13 2 ]
% 2. Binary coded loss sequence where 0 means lost packet [1 0 1 0 0 1 0 0 0 1 0 0 0 0 1];
% output avg - mean sequence length,
% dev - standard deviation of dev
% seq_vec - vector with all loss sequences

seq_vec = [];
n = length(data);

if max(data) ~= 1, 
    counter = 1;
    for i = 1:(n-1)
        if data(i+1)-data(i) == 1
            counter = counter + 1;
        else
            seq_vec = [seq_vec counter];
            counter = 1;
        end

        if i+1 == n
           seq_vec = [seq_vec counter];
        end
    end
else
    counter = 0;
    for i = 1:n
        if data(i) == 0
            counter = counter + 1;
        elseif (data(i) == 1 && counter ~= 0)
            seq_vec = [seq_vec counter];
            counter = 0;
        end

        if (i == n && counter ~= 0)
           seq_vec = [seq_vec counter];
        end
    end
end
    
disp(seq_vec)
avg = mean(seq_vec);
dev = std(seq_vec);

end

