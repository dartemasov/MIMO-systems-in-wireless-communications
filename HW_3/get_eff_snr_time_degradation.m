function get_eff_snr_time_degradation(H, H_est, StudentID, L, SNR, SRS_transmission_preiod)

[M, N, K, T] = size(H_est);



l = 290;
H_t = zeros(M,N);
H_est_t = zeros(M,N);
v_est = zeros(N,N);


plot_interpolation(H_est)  % No interpolation

for inter_mode = 1:6
H_est = time_interpolation(inter_mode, H_est, SRS_transmission_preiod);
plot_interpolation(H_est)


    for t = 1:T
            H_t(:,:) = H(1,:,l,t);
            H_est_t(:,:) = H_est(1,:,l,t);
            [~, ~, v(:,:)] = svd(H_t(:,:));
            [~, ~, v_est(:,:)] = svd(H_est_t(:,:));
            
            Hv_ref(t) = H_t(1,:) * v(:,1);
            Hv(t) = H_t(1,:) * v_est(:,1);
    

        
    end
        Ps = mean(var(Hv_ref));         % estimate power
        Dn = Ps / 10^(SNR/10);   % calculate dispersion
        eff_snr_ref = pow2db(abs(Hv_ref).^2 / Dn);
        eff_snr(:,inter_mode) = pow2db(abs(Hv).^2 / Dn);

        fprintf('SNR = %.2f \t \n',eff_snr(t));
        fprintf('TTI %d\n',t);
end

plot_eff_snr_time_degradation(T,eff_snr_ref, eff_snr, SNR)  % eff_snr is an array [T, number_of_interpolations]