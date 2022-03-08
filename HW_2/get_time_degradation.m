function get_time_degradation(MODE, H, H_est, StudentID, L, SNR)

[M, N, K, T] = size(H_est);


sc0 = StudentID*12 + StudentID^2;
BER = zeros(max(size(SNR)),T);
H_t = zeros(M,N,L);
H_est_t = zeros(M,N,L);
v_est = zeros(N,N,L);

for t = 1:T
    s = 2*randi([0 1],1,L)-1;
    for l = 1:L
        H_t(:,:,l) = H(1,:,sc0-1+l,t);
        H_est_t(:,:,l) = H_est(1,:,sc0-1+l,t);
        [~, ~, v_est(:,:,l)] = svd(H_est_t(:,:,l));
    end

    
    y0 = transmit(s,H_t,v_est);
    y = add_noise_dl(y0, SNR, M, L);
    s_est = receive(y, L);
    BER(1,t) = detect(s, s_est, L);
    fprintf('BER = %.2f \t \n',BER(1,t));  

    fprintf('TTI %d\n',t);
end

plot_time_degradation(T,BER,SNR)


