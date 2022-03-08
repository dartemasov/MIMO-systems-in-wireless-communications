function plot_metrics(mse_pos, mse_neg, evm_pos, evm_neg, vp_pos, vp_neg, cos_ang_err_pos, cos_ang_err_neg)
% Plot MSE, EVM, VP and cos of mean angle error for both polarizations
figure(1);
plot(mse_pos); hold on;
plot(mse_neg);
legend('+45° polarization', '-45° polarization');
title('Mean Squared Error');

figure(2);
plot(evm_pos); hold on;
plot(evm_neg);
legend('+45° polarization', '-45° polarization');
title('Error Vector Magnitude');

figure(3);
plot(vp_pos); hold on;
plot(vp_neg);
legend('+45° polarization', '-45° polarization');
title('Vector Projection');

% figure(4);
% plot(cos_ang_err_pos); hold on;
% plot(cos_ang_err_neg);
% legend('+45° polarization', '-45° polarization');
% title('Cos of mean angle error');
end

