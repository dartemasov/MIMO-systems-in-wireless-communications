function plot_eff_snr_time_degradation(T,eff_snr_ref,eff_snr,SNR)
    figure(1);

    plot(1:T,eff_snr_ref, 'LineWidth', 1); grid on; hold on;
    
    [~, n_plots] = size(eff_snr);
    for plt = 1:n_plots
        plot(1:T,eff_snr(:,plt), 'LineWidth', 1);
    end
    xlabel('Time, TTI'); ylabel('SNR'); 
    xlim([1 81]);

    legend({'Reference','Hold on', 'Linear', 'Spline', 'Poly 3 deg, 3 pts', ...
        'Poly 2 deg, 3 pts', 'Poly 2 deg, 2 pts'}, ...
        'FontSize',13 , 'location', 'southwest');
    title('INTERPOL')
    ax = gca(); set(ax, 'fontsize', 14);
    hold on;
end

