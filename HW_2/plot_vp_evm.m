function H_est = VP_EVM(H, UE_SNR, srsSeq, srsSeq_i, srs_sc, t)

[M, N, K, T] = size(H);
vp = zeros(length(UE_SNR),1);
evm = zeros(length(UE_SNR),1);


% y_i = srsSeq_i .* H(2,srs_sc)';  % in F-domain no noise

for mode = 1:4
    c = 0;
    for snr = UE_SNR
        c = c + 1;
        H_est = zeros(N,K);
        for ant = 1:N
            switch mode
                case 1      % No interference, no windowing
                    H_ue = conj(squeeze(H(1, ant, srs_sc, t)));
                    y = srsSeq.* H_ue;
                    yn = add_noise_ul(y, snr);
                    H_est(ant, srs_sc) = ChEst_LS_f(yn, srsSeq, srs_sc);
                case 2      % No interference, windowing
                    H_ue = conj(squeeze(H(1, ant, srs_sc, t)));
                    y = srsSeq.* H_ue;
                    yn = add_noise_ul(y, snr);
                    H_est(ant, srs_sc) = ChEst_LS_f(yn, srsSeq, srs_sc);
                    H_est(ant, srs_sc) = WinF(H_est(ant, srs_sc),135,147);
                case 3      % Interference, no windowing
                    H_ue = conj(squeeze(H(1, ant, srs_sc, t)));
                    H_ue_i = conj(squeeze(H(2, ant, srs_sc, t)));           % 2nd antenna for interf user
                    y = srsSeq.* H_ue;
                    y_i = srsSeq_i.* H_ue_i;
                    yn = add_noise_ul(y, snr);
                    yn = yn + y_i;
                    H_est(ant, srs_sc) = ChEst_LS_f(yn, srsSeq, srs_sc);
                case 4      % Interference, windowing
                    H_ue = conj(squeeze(H(1, ant, srs_sc, t)));
                    H_ue_i = conj(squeeze(H(2, ant, srs_sc, t)));           % 2nd antenna for interf user
                    y = srsSeq.* H_ue;
                    y_i = srsSeq_i.* H_ue_i;
                    yn = add_noise_ul(y, snr);
                    yn = yn + y_i;
                    H_est(ant, srs_sc) = ChEst_LS_f(yn, srsSeq, srs_sc);
                    H_est(ant, srs_sc) = WinF(H_est(ant, srs_sc),135,147);
            end
        end
        H_est = conj(H_est);
        H_est_resh = reshape(H_est, [1, N, K]);
        
        for curr_sc = srs_sc
            [u, s, v] = svd(H(1, :, curr_sc, t));
            [u_ls, s_ls, v_ls] = svd(H_est_resh(1, :, curr_sc));
            vp(c) = vp(c) + abs(v(:,1)' * v_ls(:,1));
            evm(c) = evm(c) + norm(v(:,1) - v_ls(:,1));
        end
    end
    
    vp = vp ./ length(srs_sc);
    evm = evm ./ length(srs_sc);
    
%     plot VP, EVM
    figure(1);
    if mode == 4
        plot(UE_SNR, vp, 'ro', 'LineWidth', 2, 'MarkerFaceColor', 'r');
    else
        plot(UE_SNR, vp, 'LineWidth',2);
    end
    title('Channel estimation Vector Projection');
    legend({'LS Ch. Est.','Windowed LS Ch. Est.', 'LS Ch. Est + Interference', 'Windowed LS Ch. Est. + Interference'}, 'FontSize',14, 'location', 'southeast');
    hold on;
    figure(2);
    if mode == 4
        plot(UE_SNR, evm, 'ro', 'LineWidth', 2, 'MarkerFaceColor','r');
    else
        plot(UE_SNR, evm, 'LineWidth',2);
    end    
    title('Channel estimation Error Vector Magnitude');
    legend({'LS Ch. Est.','Windowed LS Ch. Est.', 'LS Ch. Est + Interference', 'Windowed LS Ch. Est. + Interference'}, 'FontSize',14, 'location', 'northeast');
    hold on;


end