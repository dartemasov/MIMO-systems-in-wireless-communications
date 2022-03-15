function [H_LS] = ChEst_LS_f(y,srsSeq,srs_sc)

    H_LS = conj(srsSeq) .* y;

end