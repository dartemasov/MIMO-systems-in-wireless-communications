function s_est = receive(mode,H,u,y)
    [M, N, L] = size(H);

    switch mode
        case 1
            for l = 1:L
                s_est(l) = sum(pinv(H(:,:,l)) * y(:,l));
            end
        case {2, 7, 8, 9}
            for l = 1:L
                s_est(l) = u(:,1,l)' * y(:,l);
            end
        case {3, 4}
            for l = 1:L
                s_est(l) = sum(u(:,1:2,l)' * y(:,l));
            end
        case {5, 6}
            s_est = zeros(2,L);
            for l = 1:L
               s_est(1,l) = u(:,1,l)' * y(:,l);
               s_est(2,l) = u(:,2,l)' * y(:,l);
            end

    end
end

