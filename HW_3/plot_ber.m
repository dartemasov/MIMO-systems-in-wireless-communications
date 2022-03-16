function plot_ber(SNR,BER,mode)
    figure(2);
    semilogy(SNR,mean(BER,2), 'LineWidth', 2); grid on;
    xlabel('SNR,dB'); ylabel('BER'); 
%     ylim([1e-2 1]);

    legend({'Hold on', 'Linear', 'Spline', 'Poly 3 deg, 3 pts', ...
        'Poly 2 deg, 3 pts', 'Poly 2 deg, 2 pts'}, 'FontSize',13 , 'location', 'northeast');

    ax = gca(); set(ax, 'fontsize', 14);
    hold on
end

