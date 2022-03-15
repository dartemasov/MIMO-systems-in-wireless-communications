function H_est = time_interpolation(inter_mode, H_est, period)
% Now we have estimated channel in all the time samples. In the real
% systems it is not possible. Now lets leave channel estimation for only
% each 20 ms and remain it freezed for others

[M, N, K, T] = size(H_est);
H_est_orig = H_est;

steps = 1:T;

mask_orig = 1:period:T;
mask_interp = 1:T;
for el = mask_orig
    mask_interp(mask_interp == el) = [];
end

% plot_interpolation(H_est)

H_temp = zeros(N,K);
for mode = inter_mode
    switch mode
        case 1
            for t = 1:T
                if mod(t, period) == 1
                    H_temp = H_est_orig(1,:,:,t);
                else
                    H_est(1,:,:,t) = H_temp;
                end
            end
%             plot_interpolation(H_est)
        case 2      % linear interpolation
            for ant = 1:N
                for sc = 1:K
                    H_est(1,ant,sc,mask_interp) = interp1(mask_orig, squeeze(H_est_orig(1,ant,sc,mask_orig)), mask_interp, 'linear');
                end
            end
%             plot_interpolation(H_est)
        case 3      % spline interpolation
            for ant = 1:N
                for sc = 1:K
                    H_est(1,ant,sc,mask_interp) = interp1(mask_orig, squeeze(H_est_orig(1,ant,sc,mask_orig)), mask_interp, 'cubic');
                end
            end
%             plot_interpolation(H_est)
        case 4      % polynomial interpolation / 2 prev. states + 1 next / degree 2
            degree = 2;
            for ant = 1:N
                for sc = 1:K
                    for t = 2*period+1:period:T
                        fit = polyfit((t-2*period:period:t+1), squeeze(H_est_orig(1,ant,sc,(t-2*period:period:t+1))), degree);
%                         steps(t-2*period:period:t+1)     %dbg
                        H_est(1,ant,sc,(t-2*period:period:t+1)) = squeeze(H_est_orig(1,ant,sc,([t-2*period:period:t+1])));
                        x_fit = t+1-period:t-1;
                        y_fit = polyval(fit, x_fit);
                        H_est(1,ant,sc,(t+1-period:t-1)) = y_fit;
                    end
                end
            end

        case 5      % polynomial interpolation / 2 prev. states + 1 next / degree 3
            degree = 3;
            for ant = 1:N
                for sc = 1:K
                    for t = 2*period+1:period:T
                        fit = polyfit((t-2*period:period:t+1), squeeze(H_est_orig(1,ant,sc,(t-2*period:period:t+1))), degree);
%                         steps(t-2*period:period:t+1)     %dbg
                        H_est(1,ant,sc,(t-2*period:period:t+1)) = squeeze(H_est_orig(1,ant,sc,([t-2*period:period:t+1])));
                        x_fit = t+1-period:t-1;
                        y_fit = polyval(fit, x_fit);
                        H_est(1,ant,sc,(t+1-period:t-1)) = y_fit;
                    end
                end
            end

        case 6      % polynomial interpolation / 1 prev. state + 1 next / degree 3
            degree = 2;
            for ant = 1:N
                for sc = 1:K
                    for t = period+1:period:T
                        fit = polyfit((t-period:period:t+1), squeeze(H_est_orig(1,ant,sc,(t-period:period:t+1))), degree);
%                         steps(t-period:period:t+1)     %dbg
                        H_est(1,ant,sc,(t-period:period:t+1)) = squeeze(H_est_orig(1,ant,sc,([t-period:period:t+1])));
                        x_fit = t+1-period:t-1;
                        y_fit = polyval(fit, x_fit);
                        H_est(1,ant,sc,(t+1-period:t-1)) = y_fit;
                    end
                end
            end

        
    end
%     interp1()
       
end

