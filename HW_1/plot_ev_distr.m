function plot_ev_distr(sig)
    [M, N, L] = size(sig);
    lambda = zeros(M,L);
    for l = 1:L
        lambda(:,l) = diag(sig(:,:,l)); 
    end
    LMBD = sort(mean(lambda,2),'descend') .^2;
    LMBD = LMBD / sum(LMBD)
    
    figure(3);
    stem([1 2 3 4],[LMBD(1) LMBD(2) LMBD(3) LMBD(4)],'LineWidth',4);
    grid on; xlabel('Eigenvalue index in descend order'); ylabel('Eigenvalue normilized magnitude');
    title('Eigenvalue distribution');
    ax = gca(); set(ax, 'fontsize', 14);
    hold on
    plot([1 4],[LMBD(1)/2 LMBD(1)/2],'r--','LineWidth',2)
    hold off
end

