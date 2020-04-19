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
psi = 2*xxc.*yyc - 2*xxc.*yyc./(xxc.^2+yyc.^2).^2;

% Velocities
rr = xx.^2 + yy.^2;
uu = 2*xx./rr.^2 - 4*xx.*(xx.^2-yy.^2)./rr.^3 + 2*xx;
vv = -2*yy./rr.^2 - 4*yy.*(xx.^2-yy.^2)./rr.^3 - 2*yy;

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
print -dpng ../img/mt_ex2_2.png
