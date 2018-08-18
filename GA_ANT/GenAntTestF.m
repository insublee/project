function AntResult = GenAntTestF(x)
% take the variable and generate antenna

% %    [L1   L2   W1   W2   G1   G2   b    bw   hsub];
% lb = [0.4  0.2  0.2  0.2  0.1  0.1  0.1  0.1  0.2 ];
% ub = [1.2  0.8  0.9  0.9  0.9  0.9  1    1    1   ];
% 
% x = rand(1,9);
% y = [];
% for j = 1:9
%         y(j) = x(j) *lb(j) + (1-x(j))*ub(j);
% end
% x = y;


ActualVar   = GenVar(x)
L1  = ActualVar(1);
L2  = ActualVar(2);
W1  = ActualVar(3);
W2  = ActualVar(4);
G1  = ActualVar(5);
G2  = ActualVar(6);
b   = ActualVar(7);
bw  = ActualVar(8);
hsub= ActualVar(9);


%% variable

freq = 1.575e9;
gp = L1*1.5; % ground

%% Gen 2-dim polygon

Rect = GenRect(ActualVar);
% show(Rect)
%% make ant

GND  = antenna.Rectangle('Length',gp,'Width',gp);

sub = dielectric('TMM10i');
Patch = pcbStack;
Patch.Name = 'Double ring';
Patch.BoardThickness = hsub;
Patch.BoardShape = GND;
Patch.Layers = {Rect,sub,GND};
Patch.FeedLocations = [0 (L2-W2)/2 1 3];
Patch.FeedDiameter = W2/2;

% show(Patch)
%% test the antenna and return value 


% spaced_freq = linspace(freq*0.5  ,freq*3,51);
% S = sparameters(Patch, spaced_freq);

% figure
% mesh(Patch,'MaxEdgeLength',.01,'MinEdgeLength',.003)
% 
% figure;
% impedance(Patch, freq);

S  = sparameters(Patch, freq);
AntResult = abs(S.Parameters);
AntResult;
S2 = axialRatio(Patch,freq,0,0);

%% data mining

dataset = [];
dataset = [L1, L2, W1, W2, G1, G2, b, bw, hsub, AntResult, S2];
previous_dataset = csvread('result.csv');
csvwrite('result.csv',[previous_dataset;dataset]);
