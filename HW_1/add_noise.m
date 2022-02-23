


function y = add_noise(y0,SNR,M,L)
    Ps = mean(var(y0));         % estimate power
    Dn = Ps / 10^(SNR/10);   % calculate dispersion
    n0 = (randn(M,L) + 1i*randn(M,L))*sqrt(Dn/2);        % gen noise
    y = y0 + n0;                % add noise
end

