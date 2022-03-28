clear;
clc;
close all;
UE_D = 3;   % desired user index
UE_I = 4;   % interfered user index

% load  ../Channels/link_chan_2.mat           %       Urban, SRS period 20 ms
% load  ../Channels/link_chan_PATH.mat          %        Rich multipath, SRS period 20 ms 
load  ../Channels/link_chan_SPEED.mat          %        Speed, SRS period 20 ms 
% dimensions:
% <UE antenna> x <BS antenna> x <subcarrier> x <time>
[M, N, K, T] = size(Link_Channel);
pathloss = sqrt(mean(abs(Link_Channel) .^2 , 'all'));
Link_Channel = Link_Channel / pathloss;
StudentID = 5;
t = StudentID * 2;
[srsSeq, srsInfo, srs_sc] = srs_gen(UE_D);
[srsSeq_i, srsInfo_i, ~] = srs_gen(UE_I);
UE_SNR = 50;
DL_SNR = -10:10;
DL_SNR = 100;
SRS_transmission_preiod = 5;
L = 256;
Tn = 32;
Wl = 138;
Wr = 144;
% Window params: 
%   Scaling:
%       6:  135-147
%       12: 138-144     *
%       80: 101-181
%   Shifts:
%      -24: 93-141
%        0: 117-165
%      +24: 141-189

H = Link_Channel;

% for MODE = 1:4
%     H_est = estimate_channel(H, UE_SNR, srsSeq, srsSeq_i, srs_sc, Wl, Wr, MODE);
%     get_ber(MODE, H, H_est, StudentID, L, Tn, DL_SNR);
% end
% 
% plot_vp_evm(H, UE_SNR, srsSeq, srsSeq_i, srs_sc, Wl, Wr, t)

for MODE = 2
    H_est = estimate_channel(H, UE_SNR, srsSeq, srsSeq_i, srs_sc, Wl, Wr, MODE);
%     get_ber_time_degradation(MODE, H, H_est, StudentID, L, 5)
    get_eff_snr_time_degradation(H, H_est, StudentID, L, -10, SRS_transmission_preiod, 0)
end