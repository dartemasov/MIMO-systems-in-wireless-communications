function H_est_resh = estimate_channel(H, UE_SNR, srsSeq, srsSeq_i, srs_sc, Wl, Wr, MODE)

[M, N, K, T] = size(H);
vp = zeros(length(UE_SNR),1);
evm = zeros(length(UE_SNR),1);

free_sc = 1:600;
for i = 1:numel(srs_sc)
    free_sc(free_sc==srs_sc(i)) = [];
end


for mode = MODE
    for snr = UE_SNR
        H_est = zeros(N,K,T);
        for t = 1:T
            for ant = 1:N
                switch mode
                    case 1      % No interference, no windowing
                        H_ue = conj(squeeze(H(1, ant, srs_sc, t)));
                        y = srsSeq.* H_ue;
                        yn = add_noise_ul(y, snr);
                        H_est(ant, srs_sc, t) = ChEst_LS_f(yn, srsSeq, srs_sc);
                        H_est(ant, free_sc, t) = interp1(srs_sc, H_est(ant, srs_sc, t), free_sc);       %interpolate missing subcarriers
                    case 2      % No interference, windowing
                        H_ue = conj(squeeze(H(1, ant, srs_sc, t)));
                        y = srsSeq.* H_ue;
                        yn = add_noise_ul(y, snr);
                        H_est(ant, srs_sc, t) = ChEst_LS_f(yn, srsSeq, srs_sc);
                        H_est(ant, srs_sc, t) = WinF(H_est(ant, srs_sc, t),Wl,Wr);
                        H_est(ant, free_sc, t) = interp1(srs_sc, H_est(ant, srs_sc, t), free_sc);       %interpolate missing subcarriers                       
                    case 3      % Interference, no windowing
                        H_ue = conj(squeeze(H(1, ant, srs_sc, t)));
                        H_ue_i = conj(squeeze(H(2, ant, srs_sc, t)));           % 2nd antenna for interf user
                        y = srsSeq.* H_ue;
                        y_i = srsSeq_i.* H_ue_i;
                        yn = add_noise_ul(y, snr);
                        yn = yn + y_i;
                        H_est(ant, srs_sc, t) = ChEst_LS_f(yn, srsSeq, srs_sc);
                        H_est(ant, free_sc, t) = interp1(srs_sc, H_est(ant, srs_sc, t), free_sc);       %interpolate missing subcarriers
                    case 4      % Interference, windowing
                        H_ue = conj(squeeze(H(1, ant, srs_sc, t)));
                        H_ue_i = conj(squeeze(H(2, ant, srs_sc, t)));           % 2nd antenna for interf user
                        y = srsSeq.* H_ue;
                        y_i = srsSeq_i.* H_ue_i;
                        yn = add_noise_ul(y, snr);
                        yn = yn + y_i;
                        H_est(ant, srs_sc, t) = ChEst_LS_f(yn, srsSeq, srs_sc);
                        H_est(ant, srs_sc, t) = WinF(H_est(ant, srs_sc, t),Wl,Wr);
                        H_est(ant, free_sc, t) = interp1(srs_sc, H_est(ant, srs_sc, t), free_sc);       %interpolate missing subcarriers                       
                end
            end
        end
        H_est = conj(H_est);
        H_est_resh = reshape(H_est, [1, N, K, T]);
    end
    
end
