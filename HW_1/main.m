% clear all;
clear;
close all;
clc;
StudentID = 5;  % Work number from 1 to 10
Tn = 32;        % Amount of packets for transmission (default: 32)
SNR = -20:2:8;  % dB	range of SNR (default -20...8 for BPSK)
BER = zeros(max(size(SNR)),Tn);
L = 256;        % L Number of constellation points and allocated subcarriers
%               for OFDM L < K - 12*StudentID (default: 256 for BPSK)
% load -mat ../Channels/link_chan_PATH.mat
load -mat ../Channels/link_chan_2.mat
fc = 3.5e9;
% dimensions:
% <UE antenna> x <BS antenna> x <subcarrier> x <time>
[M, N, K, T] = size(Link_Channel);
pathloss = sqrt(mean(abs(Link_Channel) .^2 , 'all'));
Link_Channel = Link_Channel / pathloss;
fprintf('Channel pathloss:\t%g  (%d dB)\n',pathloss,20*log10(pathloss));
% --------------------------------------------------------------------------
% plot_chan_resp(L, Link_Channel)

sc0 = StudentID*12 + StudentID^2;
sc1 = StudentID*12 + StudentID + L;
lambda = zeros(M,L);
H = zeros(M,N,L);  % Channel knowledge (perfect) on UE has dimensionality MxNxL
u = zeros(M,M,L);
sig = zeros(M,N,L);
v = zeros(N,N,L);

% Modes:
% 1 - Reference transmission
% 2 - Single stream transmission
% 3 - Dual stream transmission. Same data over two channels. Equal power
% allocation
% 4 - Dual stream transmission. Same data over two channels. Waterfilling
% power allocation
% 5 - Dual stream transmission. Different data over two channels. 
% Equal power allocation
% 6 - Dual stream transmission. Different data over two channels. 
% Waterfilling power allocation
% 7 - Precoding vector based on 8 DFT beams
% 8 - Precoding vector based on 4 DFT beams
% 9 - Precoding vector based on 1 DFT beams


% 
% for mode = 2
%     for pack = 1:Tn 
%         t = StudentID * 2 + pack;
%         s = 2*randi([0 1],1,L)-1;
%         s2 = 2*randi([0 1],1,L)-1;
%     
%         for l=1:L
%             H(:,:,l) = Link_Channel(:,:,(sc0-1+l),t);
%                 switch mode
%                     case 7
%                         H(:,:,l) = dfft_beam_selection(H(:,:,l), 8);
%                     case 8
%                         H(:,:,l) = dfft_beam_selection(H(:,:,l), 4);
%                     case 9
%                         H(:,:,l) = dfft_beam_selection(H(:,:,l), 1);
%                 end
%             [u(:,:,l), sig(:,:,l), v(:,:,l)] = svd(H(:,:,l));
%         end
%     
%         for q=1:length(SNR)
%             y0 = transmit(mode, s, s2, H, v, sig, q);  % precode and multiply by channel matrix       
%             y = add_noise(y0, SNR(q), M, L);
%             s_est = receive(mode, H, u, y);  
%             BER(q,pack) = detect(mode, s, s2, s_est, L);
%             fprintf('BER = %.2f \t \n',BER(q,pack));  
%         end
%         fprintf('Packet %d\n',pack);
%     end
%     plot_ber(SNR, BER, mode)
% end

% plot_ev_distr(sig);


% Plot spatial spectrums
H_beam = Link_Channel(:,:,StudentID*12+StudentID^2,StudentID^2);
% UE_ant_no = 4;      % select antenna on UE side
% da = 2;
% 
% for UE_ant_no = 1:4
%     [rho,phi,theta] = spatial_spectrum(H_beam, fc, da, UE_ant_no);
%     plot_spatial_spectrum(rho,phi,theta, UE_ant_no);
% end

% % Compare performance
measure_dfft_approximation_efficiency(H_beam);
% plot(mse);

% 
% [rho,phi,theta] = spatial_spectrum(H_beam, fc, da, UE_ant_no);
% plot_spatial_spectrum(rho,phi,theta);
% [H_filtered,~,~] = dfft_beam_selection(H_beam, 1);
% [rho,phi,theta] = spatial_spectrum(H_filtered, fc, da, UE_ant_no);
% plot_spatial_spectrum(rho,phi,theta);
