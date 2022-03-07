function [mse, evm, vp, cos_angle_err] = measure_dfft_approximation_efficiency(H)
    [M,N] = size(H);
    mse = zeros(N,1);
    vp = zeros(N,1);
    cos_vp = zeros(N,1);
    evm = zeros(N,1);
    for beam_num = 1:N
        [H_filtered,~,~] = dfft_beam_selection(H, beam_num);
        mse(beam_num) = immse(H,H_filtered);
        [~,~,v] = svd(H);
        [~,~,v_f] = svd(H_filtered);
        evm(beam_num) = norm(v(:,1) - v_f(:,1));
        vp(beam_num) = abs(v(:,1)' * v_f(:,1));
        cos_angle_err(beam_num) = cos(sum(atan(imag(v(:,1))./real(v(:,1))) - atan(imag(v_f(:,1))./real(v_f(:,1))), 'all') / N);
    end
end

