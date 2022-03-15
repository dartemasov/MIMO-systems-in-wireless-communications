function plot_interpolation(H_est)
figure(5);
plot(real(squeeze(H_est(1,1,100,:)))); hold on;
% plot(angle(squeeze(H_est(1,1,100,:)))); hold on;
% plot(abs(squeeze(H_est(1,1,100,:)))); hold on;

legend({'Reference','Hold on', 'Linear', 'Spline', 'Poly 3 deg, 3 pts', ...
        'Poly 2 deg, 3 pts', 'Poly 2 deg, 2 pts'})
end

