% Parameters about the Gaussian Surface.
A = 500;
B = 1800;
C = 1./500;
m = 500;
n = 500;

%Cell Size is 5 m. 
[x,y] = meshgrid(-500:5:500, -500:5:500);

%Cell Size is 20 m. It is used to draw the figure 4.
%[x,y] = meshgrid(-500:20:500, -500:20:500);

% The Gaussian Surface formula, see formula (7) in paprer.
Elevation = A.*(1-(x./m).^2).*exp(-(x./m).^2-(y./n+1).^2)...
    -C.*exp(-(x./m+1).^2-(y./n).^2)...
    -B.*(0.2.*(x./m)-(x./m).^3-(y./n).^5).*exp(-(x./m).^2-(y./n).^2);

% The partial derivative of Gaussian Surface with respect to X.
fx =B.*exp(- x.^2./m.^2 - y.^2./n.^2).*((3.*x.^2)./m.^3 - 1./(5.*m))-...
    (2.*A.*x.*exp(- x.^2./m.^2 - (y./n + 1).^2))./m.^2 + ...
    (2.*C.*exp(- y.^2./n.^2 - (x./m + 1).^2).*(x./m + 1))./m -...
    (2.*B.*x.*exp(- x.^2./m.^2 - y.^2./n.^2).*(x.^3./m.^3 + y.^5./n.^5 - x./(5.*m)))./m.^2 +...
    (2.*A.*x.*exp(- x.^2./m.^2 - (y./n + 1).^2).*(x.^2./m.^2 - 1))./m.^2;

% The partial derivative of Gaussian Surface with respect to Y.
fy =(5.*B.*y.^4.*exp(- x.^2./m.^2 - y.^2./n.^2))./n.^5 +...
    (2.*C.*y.*exp(- y.^2./n.^2 - (x./m + 1).^2))./n.^2 +...
    (2.*A.*exp(- x.^2./m.^2 - (y./n + 1).^2).*(y./n + 1).*(x.^2./m.^2 - 1))./n -...
    (2.*B.*y.*exp(- x.^2./m.^2 - y.^2./n.^2).*(x.^3./m.^3 + y.^5./n.^5 - x./(5.*m)))./n.^2;


%Calculate slope
SlopeMatrix = atan(sqrt(fx.^2+fy.^2)).*57.29578;

%Calculate aspect
AspectMatrix = 57.29578 .* atan2(fy, -fx);
IndexLess0 = find(AspectMatrix < 0);
IndexGreat90 = find(AspectMatrix > 90);
IndexElse = find((AspectMatrix>=0) & (AspectMatrix <=90));
 for i = IndexLess0
     AspectMatrix(i) = 90 - AspectMatrix(i);
 end
 for i = IndexGreat90
     AspectMatrix(i) = 450 - AspectMatrix(i);
 end
 for i = IndexElse
     AspectMatrix(i) = 90 - AspectMatrix(i);
 end


