function plot_spatial_spectrum(rho, phi, theta, UE_ant_no)

% figure(UE_ant_no)
figure(4)
mesh(phi,theta,abs(squeeze(rho(1,:,:)))'); title('Spatial spectrum, cross porarization, linear scale');
% str = sprintf('Spatial spectrum, UE antenna element no.%d', UE_ant_no);
% subplot(2,2,UE_ant_no); mesh(phi,theta,abs(squeeze(rho(1,:,:)))'); title(str);
% subplot(2,2,1:2); mesh(phi,theta,abs(squeeze(rho(1,:,:)))'); title('Spatial spectrum, cross porarization');
% subplot(2,2,3); mesh(phi,theta,abs(squeeze(rho(2,:,:)))'); title('Spatial spectrum, +45° polarization');
% subplot(2,2,4); mesh(phi,theta,abs(squeeze(rho(3,:,:)))'); title('Spatial spectrum, -45° polarization');
ylabel('\theta');
xlabel('\phi');
zlabel('Spatial power spectrum,dB');

% log scale 
% figure(5)
% mesh(phi,theta,10 * log10(abs(squeeze(rho(1,:,:)))')); title('Spatial spectrum, cross porarization, log scale');
% subplot(2,2,1:2); mesh(phi,theta,10 * log10(abs(squeeze(rho(1,:,:)))')); title('Spatial spectrum, cross porarization');
% subplot(2,2,3); mesh(phi,theta,10 * log10(abs(squeeze(rho(2,:,:)))')); title('Spatial spectrum, +45° polarization');
% subplot(2,2,4); mesh(phi,theta,10 * log10(abs(squeeze(rho(3,:,:)))')); title('Spatial spectrum, -45° polarization');
ylabel('\theta');
xlabel('\phi');
zlabel('Spatial power spectrum,dB');

end

