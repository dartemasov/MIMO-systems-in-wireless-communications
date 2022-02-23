function metric = measure_dfft_approximation_efficiency(H)
    [M,N] = size(H);
    metric = zeros(N,1);
    for beam_num = 1:N
        [H_filtered,~,~] = dfft_beam_selection(H, beam_num);
        metric(beam_num) = immse(H,H_filtered);
    end
end

