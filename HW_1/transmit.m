function y0 = transmit(mode,s,s2,H,v,sig,snr)
    [M, N, L] = size(H);
    x = zeros(N,L);
    y0 = zeros(M,L);
    switch mode
        case 1
            p = ones(N,L) / sqrt(N);
            for l=1:L
                x(:,l) = p(:,l) * s(l);
                y0(:,l) = H(:,:,l) * x(:,l);
            end
        case {2, 7, 8, 9}
            for l=1:L
                x(:,l) = v(:,1,l) * s(l);
                y0(:,l) = H(:,:,l) * x(:,l);
            end
        case 3                % transmit one stream via two channels
            for l=1:L
                x(:,l) = v(:,1:2,l) * repmat(s(l), 2, 1) / sqrt(2);
                y0(:,l) = H(:,:,l) * x(:,l);
            end
        case 4
            p = zeros(N,2,L);
            for l=1:L
                dispersion_sq = 1/(10^(snr/10));
                power_alloc = waterfill(1, [dispersion_sq/(sig(1,1,l)^2), dispersion_sq/(sig(2,2,l)^2)]);
                p(:,1,l) = v(:,1,l) * sqrt(power_alloc(1));
                p(:,2,l) = v(:,2,l) * sqrt(power_alloc(2));
                x(:,l) = p(:,1:2,l) * repmat(s(l), 2, 1);
                y0(:,l) = H(:,:,l) * x(:,l);
            end
        case 5              % transmit 2 different streams, equal power allocation
            for l=1:L
                x(:,l) = v(:,1:2,l) * [s(l);s2(l)] / sqrt(2);
                y0(:,l) = H(:,:,l) * x(:,l);
            end
        case 6
            p = zeros(N,2,L);
            for l=1:L
                dispersion_sq = 1/(20^(snr/10));
                power_alloc = waterfill(1, [dispersion_sq/(sig(1,1,l)^2), dispersion_sq/(sig(2,2,l)^2)]);
                p(:,1,l) = v(:,1,l) * sqrt(power_alloc(1));
                p(:,2,l) = v(:,2,l) * sqrt(power_alloc(2));
                x(:,l) = p(:,1:2,l) * [s(l);s2(l)];
                y0(:,l) = H(:,:,l) * x(:,l);
            end

    end

end

