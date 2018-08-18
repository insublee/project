%% start here. 
clear;
clc;
%% dataset creation
dataset = [0.0636 0.0221 0.0093 0.0085 0.0225 0.0013 0.0352 0.0020 0.0055 0.9824 16.1939];
csvwrite('result.csv',dataset); 

%% boundary setting
% R1 = 67e-3 starting point
%    [L1,  L2,  W1,  W2,  G1,  G2,  b,   bw,  hsub]
lb = [0.4  0.2  0.2  0.2  0.1  0.1  0.1  0.1  0.2 ];
ub = [1.2  0.8  0.9  0.9  0.9  0.9  0.9  0.9  0.9   ];
% L1 : outer rectangle size
% L2 : inner rectangle size
% W1 : outer rectangle width
% W2 : inner rectangle width
% G1 : Gap between outer rectangle 
% G2 : Gap between inner rectangle 
% b : location of bridge between two ractangles
% bw : bridge width
% hsub : thickness of substarate


%% GA


FitnessFunction = @GenAntTestF;
numberOfVariables = 9;

opts = gaoptimset('Generations', 75,'PlotFcns',{@gaplotbestf});
% Run the ga solver
[x,Fval,exitFlag,Output] = ga(FitnessFunction,numberOfVariables,[], [], [], [], lb, ub, [],opts);

fprintf('The number of generations was : %d\n', Output.generations);
fprintf('The number of function evaluations was : %d\n', Output.funccount);
fprintf('The best function value found was : %g\n', Fval);
fprintf('The best x value was : %g\n', x);




%% result

k = GenVar(x);
k
Rect = GenRect(k);
show(Rect)

L1 = k(1);
L2 = k(2);
W1 = k(3);
W2 = k(4);
G1 = k(5);
G2 = k(6);
b = k(7);
bw=k(8);
hsub=k(9);
gp=1.5*L1;
freq = 1.575e9;

GND  = antenna.Rectangle('Length',gp,'Width',gp);
sub = dielectric('TMM10i');
Patch = pcbStack;
Patch.Name = 'Double ring';
Patch.BoardThickness = hsub;
Patch.BoardShape = GND;
Patch.Layers = {Rect,sub,GND};
Patch.FeedLocations = [0 (L2-W2)/2 1 3];
Patch.FeedDiameter = W2/2;

figure;
show(Patch);

spaced_freq = linspace(freq*0.5  ,freq*3,11);
rfplot(sparameters(Patch, spaced_freq));

S  = sparameters(Patch, freq);
S1 = abs(S.Parameters);
S1
S2 = axialRatio(Patch,freq,0,0);
S2