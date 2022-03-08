function [mse_pos, mse_neg, evm_pos, evm_neg, vp_pos, vp_neg, cos_ang_err_pos, cos_ang_err_neg] = measure_dfft_approximation_efficiency(H)
    [M,N] = size(H);
    mse_pos = zeros(N/2,1);
    mse_neg = zeros(N/2,1);
    evm_pos = zeros(N/2,1);
    evm_neg = zeros(N/2,1);
    vp_pos = zeros(N/2,1);
    vp_neg = zeros(N/2,1);
    cos_ang_err_pos = zeros(N/2,1);
    cos_ang_err_neg = zeros(N/2,1);
    
% Process all beams at once
%     for beam_num = 1:N
%         [H_filtered,~,~] = dfft_beam_selection(H, beam_num);
%         mse(beam_num) = immse(H,H_filtered);
%         [~,~,v] = svd(H);
%         [~,~,v_f] = svd(H_filtered);
%         evm(beam_num) = norm(v(:,1) - v_f(:,1));
%         vp(beam_num) = abs(v(:,1)' * v_f(:,1));
%         cos_angle_err(beam_num) = cos(sum(atan(imag(v(:,1))./real(v(:,1))) - atan(imag(v_f(:,1))./real(v_f(:,1))), 'all') / N);
%     end

% positive polarization
    for beam_num = 1:N/2
        [H_filtered,~,~] = dfft_beam_selection(H(:,1:32), beam_num);
        mse_pos(beam_num) = immse(H(:,1:32),H_filtered);
        [~,~,v] = svd(H(:,1:32));
        [~,~,v_f] = svd(H_filtered);
        evm_pos(beam_num) = norm(v(:,1) - v_f(:,1));
        vp_pos(beam_num) = abs(v(:,1)' * v_f(:,1));
        cos_ang_err_pos(beam_num) = cos(sum(atan(imag(v(:,1))./real(v(:,1))) - atan(imag(v_f(:,1))./real(v_f(:,1))), 'all') / N * 2);
    end

% negative polarization
    for beam_num = 1:N/2
        [H_filtered,~,~] = dfft_beam_selection(H(:,33:64), beam_num);
        mse_neg(beam_num) = immse(H(:,33:64),H_filtered);
        [~,~,v] = svd(H(:,33:64));
        [~,~,v_f] = svd(H_filtered);
        evm_neg(beam_num) = norm(v(:,1) - v_f(:,1));
        vp_neg(beam_num) = abs(v(:,1)' * v_f(:,1));
        cos_ang_err_neg(beam_num) = cos(sum(atan(imag(v(:,1))./real(v(:,1))) - atan(imag(v_f(:,1))./real(v_f(:,1))), 'all') / N * 2);
    end

plot_metrics(mse_pos, mse_neg, evm_pos, evm_neg, vp_pos, vp_neg, cos_ang_err_pos, cos_ang_err_neg);        % Plot MSE, EVM, VP and cos of mean angle error for both polarizations


end

