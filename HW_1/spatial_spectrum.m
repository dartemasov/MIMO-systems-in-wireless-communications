function [rho,phi,theta] = spatial_spectrum(H_beam,fc,da,UE_ant_no)
% da - step by \theta and \phi for diagram calculation;
% fc - carrier frequency for wavelength calc.
% 1 dim of rho is cross polarization, second is positive, third is negative
% ============================================
% think how to build spatial spectrum using
% FFT and 2D-FFT (remember, URA is here!)
% see PDF with antenna description
LAMBDA = 3e8 / fc;
phi = -70:da:70;
theta = -20:da:80;
% ---- your code is here ----
vert_num = 0:3;
horiz_num = 0:7;

% rho_pos = zeros(length(phi), length(theta));
% rho_neg = zeros(length(phi), length(theta));
% rho_sum = zeros(length(phi), length(theta));
rho = zeros(3, length(phi), length(theta));

for phi_ind = 1:length(phi)
    for theta_ind = 1:length(theta)
%         positive polarization
        a_phi_elem_pos = exp(-1i*horiz_num*pi*sin(deg2rad(phi(phi_ind)))).';
        a_theta_elem_pos = exp(-1i*vert_num*2*pi*0.9*sin(deg2rad(theta(theta_ind)))).';
        steer_vec_pos = kron(a_phi_elem_pos, a_theta_elem_pos);
        rho(2, phi_ind, theta_ind) = H_beam(UE_ant_no,33:64) * steer_vec_pos;

%         negative polarization
        a_phi_elem_neg = exp(-1i*pi/2) * exp(-1i*horiz_num*pi*sin(deg2rad(phi(phi_ind)))).';
        a_theta_elem_neg = exp(-1i*pi/2) * exp(-1i*vert_num*2*pi*0.9*sin(deg2rad(theta(theta_ind)))).';
        steer_vec_neg = kron(a_phi_elem_neg, a_theta_elem_neg);
        rho(3, phi_ind, theta_ind) = H_beam(UE_ant_no,1:32) * steer_vec_neg;

        rho(1,:,:) = rho(2,:,:) + rho(3,:,:);
    end
end


% ---- end of your code ----
end
