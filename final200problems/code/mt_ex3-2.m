clear;
close all

% Setup grids
L = 6.0;
ds = 2/17;

x = -1:ds:+L;
y = -1:ds:+1;

% Contour grid
xc = linspace(-1,L,1000);
yc = linspace(-1,L,1000);
[xxc,yyc] = meshgrid(xc,yc);

% Quiver grid
[xx,yy] = meshgrid(x,y);
[tt,rr] = cart2pol(xx,yy);

% Psi
psi = -4.*yyc./((-20 + 4.*xxc).^2 + 16.*yyc.^2) - yyc./(4.*(xxc.^2 + yyc.^2)) + yyc./((xxc.^2 + yyc.^2).*((xxc./(xxc.^2 + yyc.^2) - 20).^2 + yyc.^2./(xxc.^2 + yyc.^2).^2)) + yyc;

% Velocities
uu = 1 + 4./((-20 + 4.*xx).^2 + 16.*yy.^2) - (-20 + 4.*xx).*(-160 + 32.*xx)./((-20 + 4.*xx).^2 + 16.*yy.^2).^2 + 1./(4.*(xx.^2 + yy.^2)) - xx.^2./(2.*(xx.^2 + yy.^2).^2) + (1./(xx.^2 + yy.^2) - 2.*xx.^2./(xx.^2 + yy.^2).^2)./((xx./(xx.^2 + yy.^2) - 20).^2 + yy.^2./(xx.^2 + yy.^2).^2) - (xx./(xx.^2 + yy.^2) - 20).*(2.*(xx./(xx.^2 + yy.^2) - 20).*(1./(xx.^2 + yy.^2) - 2.*xx.^2./(xx.^2 + yy.^2).^2) - 4.*yy.^2.*xx./(xx.^2 + yy.^2).^3)./((xx./(xx.^2 + yy.^2) - 20).^2 + yy.^2./(xx.^2 + yy.^2).^2).^2;
vv = -32.*(-20 + 4.*xx).*yy./((-20 + 4.*xx).^2 + 16.*yy.^2).^2 - xx.*yy./(2.*(xx.^2 + yy.^2).^2) - 2.*xx.*yy./((xx.^2 + yy.^2).^2.*((xx./(xx.^2 + yy.^2) - 20).^2 + yy.^2./(xx.^2 + yy.^2).^2)) - (xx./(xx.^2 + yy.^2) - 20).*(-4.*(xx./(xx.^2 + yy.^2) - 20).*xx.*yy./(xx.^2 + yy.^2).^2 + 2.*yy./(xx.^2 + yy.^2).^2 - 4.*yy.^3./(xx.^2 + yy.^2).^3)./((xx./(xx.^2 + yy.^2) - 20).^2 + yy.^2./(xx.^2 + yy.^2).^2).^2;

% Start plot
clf
hold on

% Quivers - plotting twice makes symmetrically-placed arrows
rr1 = xx.^2 + yy.^2;
rr2 = (xx - 5).^2 + yy.^2;
quiv_condition = rr1>=0.3 & rr2>=0.3;

quiver(x,y,uu.*quiv_condition,vv.*quiv_condition,0.3,'k')
quiver(x,y,-uu.*quiv_condition,-vv.*quiv_condition,0.3,'k.')

% Axes
axis equal;
axis([-1 L -1 +1]);

% Level curves of psi
contour(xc,yc,psi,[-5.25:0.5:5]);
contour(xc,yc,psi,[0 0],'Black');

% Save image
print -dpng ../img/mt_ex3_2.png
