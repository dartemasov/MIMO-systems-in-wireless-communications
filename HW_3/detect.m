function ber = detect(s, s_est, L)
    s_est = hard_detection(s_est,1);
    s_err = sum(abs(s - s_est)/2);
    ber = s_err/L;
end

