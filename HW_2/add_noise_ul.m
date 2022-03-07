function z = add_noise(y,SNR)

% to add termal noise according input SNR, we need estimate average power
% of the signal to be sure that we will add right portion of noise.

Ps = mean(var(y));
Dn = Ps / 10^(SNR/10);

% adding complex gaussian noise with variation Dn and expectation mean|n0| = 1
n0 = (randn(size(y)) + 1i*randn(size(y)))*sqrt(Dn/2);

% then we can update y into y with noise
z = y + n0;

end