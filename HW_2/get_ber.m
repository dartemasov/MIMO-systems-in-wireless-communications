function get_ber(MODE, H, H_est, StudentID, L, Tn, SNR)

[M, N, K, T] = size(H_est);


sc0 = StudentID*12 + StudentID^2;
sc1 = StudentID*12 + StudentID + L;
L = 256;
t = StudentID * 2;
BER = zeros(max(size(SNR)),Tn);
H_t = zeros(M,N,L);
H_est_t = zeros(M,N,L);
v_est = zeros(N,N,L);



for pack = 1:Tn
    t = StudentID * 2 + pack;
    s = 2*randi([0 1],1,L)-1;
    for l = 1:L
        H_t(:,:,l) = H(1,:,sc0-1+l,t);
        H_est_t(:,:,l) = H_est(1,:,sc0-1+l,t);
        [~, ~, v_est(:,:,l)] = svd(H_est_t(:,:,l));
    end

    for q=1:length(SNR)
        y0 = transmit(s,H_t,v_est);
        y = add_noise_dl(y0, SNR(q), M, L);
        s_est = receive(y, L);
        BER(q,pack) = detect(s, s_est, L);
        fprintf('BER = %.2f \t \n',BER(q,pack));  
    end
    fprintf('Packet %d\n',pack);
end
plot_ber(SNR, BER, MODE)


