%  initialize workspace
clear;  close all

R = 2;  N = 32;
alph = pi-pi/6;   % my value so you can check your series (but use your own)
gap = pi/4;
delta_psi = 0.02;  %
C = 0;

%  coordinates of grid (adjust these!)
dth = pi/50;  dr = (R-1)/20;
[th,ra] = meshgrid(0:dth:2*pi,1:dr:R);
[xx,yy] = pol2cart(th,ra);

phi = C * th;
psi = -C * log(ra);

b = @(n,a) 1/n*(2*cos(a*n/2)-2*cos(a*n/2+pi*n/8)-4*sin(pi*n/16).^2);

for n = 1:N
    an =  2*R*b(n,alph)/n * (ra.^(n/2)+ra.^(-n/2))./( R.^(n/2)-R.^(-n/2) ).*sin(n*th/2);
    bn = -2*R*b(n,alph)/n * (ra.^(n/2)-ra.^(-n/2))./( R.^(n/2)-R.^(-n/2) ).*cos(n*th/2);

    phi = phi + an;
    psi = psi + bn;
end

psiM = [max(psi(:)),min(psi(:))]
phiM = [max(phi(:)),min(phi(:))];

contour(xx,yy,psi,[-1:0.1:1]*max(abs(psiM)),'-','linewidth',2)
hold on
contour(xx,yy,phi,[-1:0.1:1]*max(abs(phiM)),'b--')
caxis([-1 1]*max(abs(psiM)));
colorbar
axis equal;  axis([-1 1 -1 1]*1.05*R);

title('\bf Doomed solution','FontSize',14);
xlabel('\bf x-axis','FontSize',14);
ylabel('\bf y-axis','FontSize',14);

contour(xx,yy,psi,[psiM(1)-delta_psi psiM(2)+delta_psi],'k','linewidth',2)
contour(xx,yy,psi,[-1 1]*0.0005,'k','linewidth',2)

%  inflow/outflow
gth = 0:dth:gap;  gones = ones(size(gth));
[xr,yr] = pol2cart(     gth,R*gones);
plot(xr,yr,'k--','linewidth',2)
[xr,yr] = pol2cart(alph+gth,R*gones);
plot(xr,yr,'k--','linewidth',2)
