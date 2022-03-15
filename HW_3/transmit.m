function y0 = transmit(s,H,v)
    [M, N, L] = size(H);
    x = zeros(N,L);
    y0 = zeros(M,L);
    for l=1:L
        x(:,l) = v(:,1,l) * s(l);
        y0(:,l) = H(:,:,l) * x(:,l);
    end
end

