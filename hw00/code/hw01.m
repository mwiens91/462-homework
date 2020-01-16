%
%  hw01.m - velocity field (djm: 08 jan 20)
%
%  save file as "hw01.m" (make sure that it is on the matlab path!)
%  to run, type "hw01" at the matlab prompt ">>"
%

%  initialize workspace & set constants (experiment with different values!!)
clear;  close all

L = 4.0;  ds = 2*L/17;
B = 1.5;

%  set x & y-vectors &  grid matrices ("help meshgrid")
x = -L:ds:+L;  y = -L:ds:+L;

xc = linspace(-L, L, 500);
yc = linspace(-L, L, 500);
[xxc,yyc] = meshgrid(xc,yc);

[xx,yy] = meshgrid(x,y);
[tt,rr] = cart2pol(xx,yy);

% r
r = sqrt(xx.^2 + yy.^2);
rc = sqrt(xxc.^2 + yyc.^2);

%  calculate psi (note .* & ./ "dot" arithmetic)
psi = yyc.*(1 - 1./rc.^2) + B/2 * log(rc.^2);

%  calculate velocities (u = psi_y, v = -psi_x)
uu =  1 + 1./r.^2 .* (B * yy - 1) + 2 * yy.^2 ./ r.^4;
vv = - 2 * yy .* xx ./ r.^4 - B * xx ./ r.^2;

%  plot vector field ("help quiver") outside unit circle
%  plotting twice makes symmetrically-placed arrows

clf
quiver(x,y, uu .* (rr>=1), vv .* (rr>=1),0.3,'k')
hold on
quiver(x,y,-uu .* (rr>=1),-vv .* (rr>=1),0.3,'k.')
axis([-L +L -L +L]);  axis square;
%  plots a dot at each gridpoint
%plot(x,y,xx .* (rr>=1),yy .* (rr>=1),'r.')

%  plot unit circle
th = 0:pi/50:2*pi;
plot(cos(th),sin(th),'k','linewidth',2)

%  plot level curves of psi (two versions, try both)
%contour(x,y,psi .* (rr>=1),[-8.5:1:8.5]);  colorbar

contour(xc,yc,psi,[-5.25:0.5:5]);  colorbar

%  plot one special contour
contour(xc,yc,psi,[0 0],'k');

%  label plot
title(['\bf Level curves of \psi with velocity field U (B=' num2str(B) ')'])
xlabel('\bf x')
ylabel('\bf y')

%  plot a point (not a very useful point)
if B > 2
xs = [0, 0];
ys = [1/2 * (sqrt(B^2 - 4) - B), 1/2 * (-sqrt(B^2 - 4) - B)];
end
if B < 2
    xs = [-1/2*sqrt(4 - B^2), 1/2*sqrt(4 - B^2)];
    ys = [-B/2, -B/2];
end

plot(xs,ys,'r*')

print -depsc2 hw01fig.eps
print -dpng hw01fig.png
