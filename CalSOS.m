%Data.mat include Elevation, SlopeMatrix, and AspectMatrix data. 
Data = load('Data.mat');
cellsize = 5;

%Phi is the angle ¦Õ in figure 2.
Phi = 0;

%Beta is the angle ¦Â in figure 2.
Beta = Data.SlopeMatrix;

%Theta is the angle ¦È in figure 2.
Theta = Beta + Phi;

% see the formula (2) in paper.
Index = find(Theta >= 360);
 for i = Index
     Theta(i) = Theta(i) - 360;
 end
 
% see the formula (3) in paper.
Alpha = Theta;

% see the formula (5) in paper.
Vector_x = cellsize.*cos(Alpha.*(pi./180));
Vector_y = cellsize.*sin(Alpha.*(pi./180));
Vector_asp = cat(3, Vector_x, Vector_y);

[m, n] = size(Data.AspectMatrix);
SOSmatrix = zeros(m, n);

%Extend the boundary of the matrix by replicating.
Vector_asp = padarray(Vector_asp,[1 1], 'replicate');

% slide window
 for i = 2 : m + 1
     for j = 2 : n + 1
         tempValue = FiniteDifference(i, j , Vector_asp, cellsize);
         SOSmatrix(i - 1, j - 1) = tempValue;
     end
 end  
 
% Normlize the result of SOS.
NormlizedSOA = SOSmatrix./max(max(SOSmatrix));
h4 = histogram(NormlizedSOA,'BinWidth',1/64,'Normalization','probability');
pinlv = h4.Values;
xV = linspace(0,1,64);
plot(xV, pinlv,'r', 'LineWidth',1);