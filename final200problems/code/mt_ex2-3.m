clear;
close all

% Setup grids
L = 4.0;
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
psi = 2*xxc.*yyc - 2*xxc.*yyc./(xxc.^2+yyc.^2).^2 - 0.2*yyc./(xxc.^2+yyc.^2) + 0.2*yyc;

% Velocities
rr = xx.^2 + yy.^2;
uu = (-4*xx.^3+4*xx.*yy.^2)./rr.^3 + (-0.4*xx.^2+2*xx)./rr.^2 + 0.2./rr + 2*xx + 0.2;
vv = -2*yy.*(xx.^6+3*xx.^4.*yy.^2+0.2*xx.^3+xx.^2.*(3*yy.^4+3)+0.2*xx.*yy.^2+yy.^6-yy.^2)./rr.^3;

% Start plot
clf
hold on

% Quivers - plotting twice makes symmetrically-placed arrows
quiver(x,y,uu.*(rr>=1),vv.*(rr>=1),0.3,'k')
quiver(x,y,-uu.*(rr>=1),-vv.*(rr>=1),0.3,'k.')

% Axes
axis([-L +L -L +L]);
axis square;

% Level curves of psi
contour(xc,yc,psi,[-5.25:0.5:5]);
contour(xc,yc,psi,[0 0],'Black');

% Save image
print -dpng ../img/mt_ex2_3.png
