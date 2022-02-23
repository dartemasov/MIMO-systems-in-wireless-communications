function ber = detect(mode, s, s2, s_est, L)
    switch mode
        case {1, 2, 3, 4, 7, 8, 9}
            s_est = hard_detection(s_est,1);
            s_err = sum(abs(s - s_est)/2);
            ber = s_err/L;
        case {5, 6}
            s_est_1 = s_est(1,:);
            s_est_1 = hard_detection(s_est_1,1);
            s_err_1 = sum(abs(s - s_est_1)/2);
            s_est_2 = s_est(2,:);
            s_est_2 = hard_detection(s_est_2,1);
            s_err_2 = sum(abs(s2 - s_est_2/2));
            ber = (s_err_1 + s_err_2) / (2*L) - 0.25;
%             ber = (s_err_1 + s_err_2) / (2*L);
    end
end

