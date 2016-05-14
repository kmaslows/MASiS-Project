% p - probability of transferring from Good to Bad
% r - probability of transferring from Bad to Good

addpath(genpath('../Kolejka'));

p = 0.01:0.01:0.99;
r = 0.01:0.01:0.99;
number_of_packets = 10000; %todo

[P,R] = meshgrid(p,r);
P = P(:);
R = R(:);

n = length(p) * length(r);

data = zeros(n,3);

parfor (i = 1:n)
    packet_loss = gilbert3(P(i),R(i)); %todo: or gilbert2
    data(i,:) = [P(i), R(i), packet_loss];
    %disp([P(i), R(i), packet_loss]);
end

X = data(:,1);
Y = data(:,2);
Z = data(:,3);

Z1 = ones(1,length(Z)) * 0.35;

Xn = numel(unique(X));
Yn = numel(unique(Y));

XX = reshape(X,Xn,Yn);
YY = reshape(Y,Xn,Yn);
ZZ = reshape(Z,Xn,Yn);
ZZ1 = reshape(Z1,Xn,Yn);

hold on
surf(XX,YY,ZZ1)
surf(XX,YY,ZZ)
xlabel('Probability of G->B transfer')
ylabel('Probability of B->G transfer')
zlabel('# packet lost')
grid on
hold off