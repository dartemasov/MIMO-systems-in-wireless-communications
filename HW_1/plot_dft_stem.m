function plot_dft_stem(H)
[~, H_f_filtered_1,~] = dfft_beam_selection(H, 1);
[~, H_f_filtered_4,~] = dfft_beam_selection(H, 4);
[~, H_f_filtered_8,H_f] = dfft_beam_selection(H, 8);

figure(1);
% Create stem
for ue_ant = 1:4
    stem(abs(H_f(ue_ant,:)));
    hold on;
end
hold off;
legend('UE ant. 1', 'UE ant. 2', 'UE ant. 3', 'UE ant. 4');
title('Fourier spectrum (full)')

figure(2);
for ue_ant = 1:4
    stem(abs(H_f_filtered_1(ue_ant,:)));
    hold on;
end
hold off;
legend('UE ant. 1', 'UE ant. 2', 'UE ant. 3', 'UE ant. 4');
title('Fourier spectrum (1 selected beam)')

figure(3);
for ue_ant = 1:4
    stem(abs(H_f_filtered_4(ue_ant,:)));
    hold on;
end
hold off;
legend('UE ant. 1', 'UE ant. 2', 'UE ant. 3', 'UE ant. 4');
title('Fourier spectrum (4 selected beams)')

figure(4);
for ue_ant = 1:4
    stem(abs(H_f_filtered_8(ue_ant,:)));
    hold on;
end
hold off;
legend('UE ant. 1', 'UE ant. 2', 'UE ant. 3', 'UE ant. 4');
title('Fourier spectrum (8 selected beams)')