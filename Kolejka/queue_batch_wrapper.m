function [ output ] = queue_batch_wrapper( A, B, C )
%% This is a batch wrapper for queue function, which can take vectors as arguments
% A - Data to process
% B - Vector of buffor lengths. Must be positive integer.
% C - Vector of queue throuput speeds [Bytes/s]
% output - cell array of length len(A) and three columns
% output{:,1} - B value used during run
% output{:,2} - C value used during run
% output{:,3} - 1x3 cell with simulation results (lost, lostvec, Xvec)

%% Prepare agruments
n = length(B)*length(C);
[b,c] = meshgrid(B, C);
b = b(:);
c = c(:);
output = num2cell([b c]);
%output{1,3} = [];
output_lost = cell(n,1);
output_lostvec = cell(n,1);
output_Xvec = cell(n,1);
%% Run
parfor (i = 1:n),
    tic
    [ output_lost{i}, output_lostvec{i}, output_Xvec{i} ] = queue( A, b(i), c(i) );
    disp('-----------------------------------')
    disp(['Run = ', num2str(i) , '/', num2str(n), ' B = ', num2str(b(i)), ' C = ', num2str(c(i))])
    disp(['Packet lost: ', num2str(output_lost{i})])
    lost_indexes = output_lostvec{i}(:,4);
    if ~isempty(lost_indexes)
        [r,h,p] = gilbert_packets(lost_indexes, length(A));
        disp(['Gilbert: ', 'r=' , num2str(r), ' h=', num2str(h), ' p=', num2str(p)]);
    end
    toc
end


output = [output output_lost output_lostvec output_Xvec];

end
