function [ r h p ] = estimate_gilbert( A )
%ESTIMATE_GILBERT Summary of this function goes here
% A - stream of zeros and ones; 1 - packet lost; 0 - packet forwarded

total_length = length(A);

X1 = findstr(A,[1]);
X2 = findstr(A,[1 1]);
X3 = findstr(A, [1 0 1]);
X4 = findstr(A, [1 1 1]);

number_of_ones = length(X1);
number_of_double_ones = length(X2);
number_of_one_o_ones = length(X3);
number_of_triple_ones = length(X4);

a = number_of_ones/total_length;
b = number_of_double_ones/number_of_ones;
c = number_of_triple_ones/(number_of_triple_ones+number_of_one_o_ones);

% avoid c by assuming h=0.5
%h = 1
%r = 1-2*b

r = 1-(a*c-b*b)/(2*a*c-b*(a+c));
h = 1-b/(1-r);
p = (a*r)/(1-h-a);

end

