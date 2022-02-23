function plot_ber(SNR,BER,mode)
    figure(2);
    semilogy(SNR,mean(BER,2),'LineWidth',3); grid on;
    xlabel('SNR,dB'); ylabel('BER'); ylim([1e-4 1]);
%     leg = sprintf('Mode %i',mode);
    legend('ref', '1 ch', '2 ch same data eq pow', '2 ch same data wf pow', ...
        '2 ch diff data eq pow', '2 ch diff data wf pow');
    ax = gca(); set(ax, 'fontsize', 15);
    hold on
end

