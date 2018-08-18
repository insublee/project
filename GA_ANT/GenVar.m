function Var = GenVar(x)
% take the number, and make real value
% Var = [L1 L2 W1 W2 G1 G2 b bw hsub];
%%test
%      [L1   L2   W1   W2   G1   G2   b   bw  hsub];
% lb = [0.4  0.2  0.2  0.3  0.1  0.1  -1  -1  0.2 ];
% ub = [1.2  0.8  0.9  0.9  0.9  0.9  1   1   1   ];
% 
% x = rand(1,9);
% y = [];
% for j = 1:9
%         y(j) = x(j) *lb(j) + (1-x(j))*ub(j);
% end
%% geometrical boundary
L1 = x(1) * 67e-3; % start value

L2 = x(2) * L1; 

R1 = L1;

R2 = L2;

W1 = x(3) * (L1 - L2)/2;

W2 = x(4) * L2/2; 

G1 = x(5) * ((R1/2) - W1);
% 0 < x(5) < 1
 
G2 = x(6) * (R2/2 - W2);
% 0 < x(6) < 1

b = -x(7) * L2/2 + (1 - x(7)) * L2/2; % 

bw = x(8) * L2/2 + (1-x(8)) * b;

hsub=x(9)*0.2*L1;
% 0.2 < x(9) < 0.8


Var = [L1 L2 W1 W2 G1 G2 b bw hsub];