function s_est = receive(y, L)
    for l = 1:L
        s_est(l) = y(:,l);
    end
end

