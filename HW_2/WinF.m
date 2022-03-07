% SRS channel estimation filtering in time domain (de-noising)
function [H_win,Ht] = WinF(H_LS,Wl,Wr)
L = length(H_LS);
% if Wl > L/2 || Wr > L/2
%    fprintf('Error in WinF :: Wl and Wr has to be less %d\n',L/2);
%    return
% end


W = [zeros(Wl-1,1); ones(Wr-Wl+1,1); zeros(L-Wr,1)];




Ht = ifft(H_LS);
Ht = ifftshift(Ht);
% figure(5)
% subplot(311), plot(abs(Ht)), xlim([0,L]), title('Original signal'); 
% hold on;



Ht_win = W.' .* Ht;
% subplot(312), plot(W), ylim([0,1]), xlim([0,L]), title('Window filter');
% subplot(313), plot(abs(Ht_win)), xlim([0,L]), title('Processed signal');
Ht_win = ifftshift(Ht_win);
H_win = fft(Ht_win);

end