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
psi = yyc - 4 * yyc ./ (xxc.^2 + yyc.^2);

%  calculate velocities (u = psi_y, v = -psi_x)
rr = xx.^2 + yy.^2;
uu = -8 *xx.^2 ./ rr.^2 + 4 ./ rr.^2 + 1;
vv = - 8 *xx .* yy ./ rr.^2;

%  plot vector field ("help quiver") outside unit circle
%  plotting twice makes symmetrically-placed arrows

clf
quiver(x,y, uu .* (rr>=1), vv .* (rr>=1),0.3,'k')
hold on
quiver(x,y,-uu .* (rr>=1),-vv .* (rr>=1),0.3,'k.')
axis([-L +L -L +L]);  axis square;


%  plot level curves of psi (two versions, try both)
%contour(x,y,psi .* (rr>=1),[-8.5:1:8.5]);  colorbar

contour(xc,yc,psi,[-5.25:0.5:5]);
%  plot one special contour
contour(xc,yc,psi,[0 0],'Black');



print -dpng hw09fig3.png
