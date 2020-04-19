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
psi = yyc-4*yyc./(xxc.^2+yyc.^2);

% Velocities
rr = xx.^2+yy.^2;
uu = -8*xx.^2./rr.^2+4./rr.^2+1;
vv = -8*xx.*yy./rr.^2;

% Start plot
clf
hold on

% Quivers - plotting twice makes symmetrically-placed arrows
quiv_condition = rr>=4.3;

quiver(x,y,uu.*quiv_condition,vv.*quiv_condition,0.3,'k')
quiver(x,y,-uu.*quiv_condition,-vv.*quiv_condition,0.3,'k.')

% Axes
axis([-L +L -L +L]);
axis square;

% Level curves of psi
contour(xc,yc,psi,[-5.25:0.5:5]);
contour(xc,yc,psi,[0 0],'Black');

% Save image
print -dpng ../img/mt_ex1_2.png
