function plot_ber(SNR,BER,mode)
    figure(2);
    semilogy(SNR,mean(BER,2), 'LineWidth', 2); grid on;
    xlabel('SNR,dB'); ylabel('BER'); ylim([1e-4 1]);

    legend({'LS Ch. Est.','Windowed LS Ch. Est.', 'LS Ch. Est + Interference', 'Windowed LS Ch. Est. + Interference'}, 'FontSize',13 , 'location', 'northeast');

    ax = gca(); set(ax, 'fontsize', 14);
    hold on
end

