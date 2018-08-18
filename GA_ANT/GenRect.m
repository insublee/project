function Rect = GenRect(x)
% make double ring antenna!
% return 2-dim ant
L1 = x(1);
L2 = x(2);
W1 = x(3);
W2 = x(4);
G1 = x(5);
G2 = x(6);
b = x(7); % this can be going under zero
bw=x(8);

OutsideRect = antenna.Rectangle('Length',L1,'Width',L1);
OutsideRectW1 = antenna.Rectangle('Length',L1-(W1*2),'Width',L1-(W1*2));
InsideRect =  antenna.Rectangle('Length',L2,'Width',L2);
InsideRectW2 =  antenna.Rectangle('Length',L2-(W2*2),'Width',L2-(W2*2));
G1Rect = antenna.Rectangle('Length',G1,'Width',W1, 'Center',[0,(L1-W1)/2]);
G2Rect = antenna.Rectangle('Length',G2,'Width',W2, 'Center',[0,(W2-L2)/2]);
drp=[L2/2,b,0;
    L2/2,bw,0;
    L1/2-W1/2,bw,0;
    L1/2-W1/2,b,0;
    ];
bridgeRect = antenna.Polygon('Vertices', drp);
Rect = OutsideRect-OutsideRectW1+InsideRect-InsideRectW2-G1Rect-G2Rect+bridgeRect;




