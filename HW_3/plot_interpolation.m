function plot_interpolation(H_est, l)
figure(5);
subplot(3,1,2);
plot(real(squeeze(H_est(1,1,l,:)))); hold on;
legend({'Reference','Reference predicted','Hold on', 'Linear', 'Spline', 'Poly 3 deg, 3 pts', ...
        'Poly 2 deg, 3 pts', 'Poly 2 deg, 2 pts'})
subplot(3,1,3);
plot(angle(squeeze(H_est(1,1,l,:)))); hold on;
legend({'Reference','Reference predicted','Hold on', 'Linear', 'Spline', 'Poly 3 deg, 3 pts', ...
        'Poly 2 deg, 3 pts', 'Poly 2 deg, 2 pts'})
subplot(3,1,1);
plot(abs(squeeze(H_est(1,1,l,:)))); hold on;
legend({'Reference', 'Reference predicted','Hold on', 'Linear', 'Spline', 'Poly 3 deg, 3 pts', ...
        'Poly 2 deg, 3 pts', 'Poly 2 deg, 2 pts'})


end

