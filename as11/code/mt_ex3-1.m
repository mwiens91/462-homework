clear;
close all

% Setup grids
L = 2.0;
ds = 2*L/17;

x = -L:ds:+L;
y = -L:ds:+L;

% Contour grid
xc = linspace(-L,L,500);
yc = linspace(-L,L,500);
[xxc,yyc] = meshgrid(xc,yc);

% Quiver grid
[xx,yy] = meshgrid(x,y);
[tt,rr] = cart2pol(xx,yy);

% Psi
psi = -4.*yyc./((4.*xxc - 4).^2 + 16.*yyc.^2) - yyc./(4.*(xxc.^2 + yyc.^2)) + yyc./(((xxc./(xxc.^2 + yyc.^2) - 4).^2 + yyc.^2./(xxc.^2 + yyc.^2).^2).*(xxc.^2 + yyc.^2)) + yyc;

% Velocities
uu = 1 - (4.*xx - 4).*(32.*xx - 32)./((4.*xx - 4).^2 + 16.*yy.^2).^2 + 4./((4.*xx - 4).^2 + 16.*yy.^2) - xx.^2./(2.*(xx.^2 + yy.^2).^2) + 1./(4.*(xx.^2 + yy.^2)) - (xx./(xx.^2 + yy.^2) - 4).*(2.*(xx./(xx.^2 + yy.^2) - 4).*(-2.*xx.^2./(xx.^2 + yy.^2).^2 + 1./(xx.^2 + yy.^2)) - 4.*yy.^2.*xx./(xx.^2 + yy.^2).^3)./((xx./(xx.^2 + yy.^2) - 4).^2 + yy.^2./(xx.^2 + yy.^2).^2).^2 + (-2.*xx.^2./(xx.^2 + yy.^2).^2 + 1./(xx.^2 + yy.^2))./((xx./(xx.^2 + yy.^2) - 4).^2 + yy.^2./(xx.^2 + yy.^2).^2);
vv = -32.*(4.*xx - 4).*yy./((4.*xx - 4).^2 + 16.*yy.^2).^2 - xx.*yy./(2.*(xx.^2 + yy.^2).^2) - (xx./(xx.^2 + yy.^2) - 4).*(-4.*(xx./(xx.^2 + yy.^2) - 4).*xx.*yy./(xx.^2 + yy.^2).^2 - 4.*yy.^3./(xx.^2 + yy.^2).^3 + 2.*yy./(xx.^2 + yy.^2).^2)./((xx./(xx.^2 + yy.^2) - 4).^2 + yy.^2./(xx.^2 + yy.^2).^2).^2 - 2.*xx.*yy./(((xx./(xx.^2 + yy.^2) - 4).^2 + yy.^2./(xx.^2 + yy.^2).^2).*(xx.^2 + yy.^2).^2);

% Start plot
clf
hold on

% Quivers - plotting twice makes symmetrically-placed arrows
rr1 = xx.^2 + yy.^2;
rr2 = (xx - 1).^2 + yy.^2;
quiv_condition = rr1>=0.3 & rr2>=0.3;

quiver(x,y,uu.*quiv_condition,vv.*quiv_condition,0.3,'k')
quiver(x,y,-uu.*quiv_condition,-vv.*quiv_condition,0.3,'k.')

% Axes
axis([-L +L -L +L]);
axis square;

% Level curves of psi
contour(xc,yc,psi,[-5.25:0.5:5]);
contour(xc,yc,psi,[0 0],'Black');

% Save image
print -dpng ../img/mt_ex3_1.png
