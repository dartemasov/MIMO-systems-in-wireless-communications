function H_est = time_interpolation(H_est, period)
% Now we have estimated channel in all the time samples. In the real
% systems it is not possible. Now lets leave channel estimation for only
% each 20 ms and remain it freezed for others


[M, N, K, T] = size(H_est);

H_temp = zeros(N,K);

for t = 1:T
    if mod(t, period) == 1
        H_temp = H_est(1,:,:,t);
    else
        H_est(1,:,:,t) = H_temp;
    end
       
end

end