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
psi = 2*xxc.*yyc;

% Velocities
uu = 2*xx;
vv = -2*yy;

% Start plot
clf
hold on

% Quivers - plotting twice makes symmetrically-placed arrows
quiver(x,y, uu, vv ,0.3,'k')
quiver(x,y,-uu ,-vv ,0.3,'k.')

% Axes
axis([-L +L -L +L]);
axis square;

% Level curves of psi
contour(xc,yc,psi,[-5.25:0.5:5]);

% Save image
print -dpng ../img/mt_ex2_1.png
