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
output{1,3} = [];

%% Run
parfor i = 1:n,
    tic
    [ lost lostvec Xvec ] = queue( A, b(i), c(i) );
    toc
    disp('-----------------------------------')
    disp(['Run = ', num2str(i) , '/', num2str(n), ' B = ', num2str(b(i)), ' C = ', num2str(c(i))]);
    disp(['Packet lost: ', num2str(lost)]);
    output{i,3} = {lost lostvec Xvec};
end

end
