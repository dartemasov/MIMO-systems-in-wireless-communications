function plot_time_degradation(T,BER,SNR)
    figure(1);
    semilogy(1:T,BER, 'LineWidth', 2); grid on;
    xlabel('Time, TTI'); ylabel('BER'); 
%     ylim([1e-4 1]);

    legend({'LS Ch. Est.','Windowed LS Ch. Est.', 'LS Ch. Est + Interference', 'Windowed LS Ch. Est. + Interference'}, 'FontSize',13 , 'location', 'southwest');

    ax = gca(); set(ax, 'fontsize', 14);
    hold on;
end

