function y0 = transmit(mode,s,s2,H,v,sig)
    [M, N, L] = size(H);
    x = zeros(N,L);
    y0 = zeros(M,L);
%     v_beam = zeros(N,N,L);
    switch mode
%     if mode == 1
        case 1
            p = ones(N,L) / sqrt(N);
            for l=1:L
                x(:,l) = p(:,l) * s(l);
                y0(:,l) = H(:,:,l) * x(:,l);
            end
        case {2, 7, 8, 9}
            for l=1:L
                x(:,l) = v(:,1,l) * s(l);
                y0(:,l) = H(:,:,l) * x(:,l);
            end
        case 3                % transmit one stream via two channels
            for l=1:L
                x(:,l) = v(:,1:2,l) * repmat(s(l), 2, 1) / sqrt(2);
                y0(:,l) = H(:,:,l) * x(:,l);
            end
        case 4
            p = zeros(N,2,L);
            for l=1:L
                power_alloc = waterfill(1, [1/sig(1,1,l), 1/sig(2,2,l)]);
                p(:,1,l) = v(:,1,l) * sqrt(power_alloc(1));
                p(:,2,l) = v(:,2,l) * sqrt(power_alloc(2));
                x(:,l) = p(:,1:2,l) * repmat(s(l), 2, 1);
                y0(:,l) = H(:,:,l) * x(:,l);
            end
        case 5              % transmit 2 different streams, equal power allocation
            for l=1:L
                x(:,l) = v(:,1:2,l) * [s(l);s2(l)] / sqrt(2);
                y0(:,l) = H(:,:,l) * x(:,l);
            end
        case 6
            p = zeros(N,2,L);
            for l=1:L
                power_alloc = waterfill(1, [1/sig(1,1,l), 1/sig(2,2,l)]);
                p(:,1,l) = v(:,1,l) * sqrt(power_alloc(1));
                p(:,2,l) = v(:,2,l) * sqrt(power_alloc(2));
                x(:,l) = p(:,1:2,l) * [s(l);s2(l)];
                y0(:,l) = H(:,:,l) * x(:,l);
            end

%         case 7       % DFFT beam selection - 8 beams
%             for l=1:L
%                 H_beam = dfft_beam_selection(H(:,:,l), 8);
%                 [~, ~, v_beam(:,:,l)] = svd(H_beam);
%                 x(:,l) = v_beam(:,1,l) * s(l);
%                 y0(:,l) = H(:,:,l) * x(:,l);
%             end
% 
%         case 8       % DFFT beam selection - 4 beams
%             for l=1:L
%                 H_beam = dfft_beam_selection(H(:,:,l), 4);
%                 [~, ~, v_beam(:,:,l)] = svd(H_beam);
%                 x(:,l) = v_beam(:,1,l) * s(l);
%                 y0(:,l) = H(:,:,l) * x(:,l);
%             end
% 
%         case 9       % DFFT beam selection - 1 beam
%             for l=1:L
%                 H_beam = dfft_beam_selection(H(:,:,l), 1);
%                 [~, ~, v_beam(:,:,l)] = svd(H_beam);
%                 x(:,l) = v_beam(:,1,l) * s(l);
%                 y0(:,l) = H(:,:,l) * x(:,l);
%             end



    end

end

