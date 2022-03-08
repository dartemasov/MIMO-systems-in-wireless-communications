clear;
clc;
close all;
UE_D = 3;   % desired user index
UE_I = 4;   % interfered user index

% load  ../Channels/link_chan_2.mat
% load  ../Channels/link_chan_PATH.mat
load  ../Channels/link_chan_SPEED.mat
% dimensions:
% <UE antenna> x <BS antenna> x <subcarrier> x <time>
[M, N, K, T] = size(Link_Channel);
pathloss = sqrt(mean(abs(Link_Channel) .^2 , 'all'));
Link_Channel = Link_Channel / pathloss;
StudentID = 5;
t = StudentID * 2;
[srsSeq, srsInfo, srs_sc] = srs_gen(UE_D);
[srsSeq_i, srsInfo_i, ~] = srs_gen(UE_I);
UE_SNR = 15;
DL_SNR = 15:15;
SRS_transmission_preiod = 10;
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

for MODE = 1:4
    H_est = estimate_channel(H, UE_SNR, srsSeq, srsSeq_i, srs_sc, Wl, Wr, MODE);
    get_ber(MODE, H, H_est, StudentID, L, Tn, DL_SNR);
end

plot_vp_evm(H, UE_SNR, srsSeq, srsSeq_i, srs_sc, Wl, Wr, t)

for MODE = 1:4
    H_est = estimate_channel(H, UE_SNR, srsSeq, srsSeq_i, srs_sc, Wl, Wr, MODE);
    H_est = time_interpolation(H_est, SRS_transmission_preiod);
    get_time_degradation(MODE, H, H_est, StudentID, L, 5)
end