clear;  close all

L = 4.0;  ds = 2*L/17;
B = 1.5;

x = -L:ds:+L;  y = -L:ds:+L;

xc = linspace(-L, L, 500);
yc = linspace(-L, L, 500);
[xxc,yyc] = meshgrid(xc,yc);

[xx,yy] = meshgrid(x,y);
[tt,rr] = cart2pol(xx,yy);

%  calculate psi (note .* & ./ "dot" arithmetic)
psi = yyc;

%  calculate velocities (u = psi_y, v = -psi_x)
uu =  xx;
vv = 0 * yy;

%  plot vector field ("help quiver") outside unit circle
%  plotting twice makes symmetrically-placed arrows

clf
quiver(x,y, uu, vv ,0.3,'k')
hold on
quiver(x,y,-uu ,-vv ,0.3,'k.')
axis([-L +L -L +L]);  axis square;


%  plot level curves of psi (two versions, try both)
%contour(x,y,psi .* (rr>=1),[-8.5:1:8.5]);  colorbar

contour(xc,yc,psi,[-5.25:0.5:5]);

print -dpng hw09fig2.png
