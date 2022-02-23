function [H_filtered, H_f_filtered, H_f] = dfft_beam_selection(H, beams_num)

[M, N] = size(H);

H_f = zeros(M,N);
H_f_temp = zeros(M,N);
H_f_filtered = zeros(M,N);
H_filtered = zeros(M,N);
mapping = zeros(M,N,N);

for i = 1:M
    H_f(i,:) = H(i,:) * dftmtx(N);
    H_f_temp(i,:) = H_f(i,:);
    for beam = 1:beams_num
        [max_val, max_idx] = max(H_f_temp(i,:));
        mapping(i, max_idx, max_idx) = 1;
        H_f_temp(i,max_idx) = 0;
    end
    H_f_filtered(i,:) = H_f(i,:) * squeeze(mapping(i,:,:));
    H_filtered(i,:) = H_f_filtered(i,:) * conj(dftmtx(N))/N;
end

end

