function plot_correlation()
% ---------------------
% Plot ACF anc XCF in TD and FD
% ---------------------
close all;
figure(1);
subplot(121);
[srsSeq, srsInfo, idx] = srs_gen(0);
srsSeq_t = ifft(srsSeq);
autocorr_t = xcorr(srsSeq_t, srsSeq_t);
plot(abs(autocorr_t));
title('ACF of ZC sequence of length 288. Time domain');
xlabel('Time index');

subplot(122);
plot(abs(fft(autocorr_t)));
title('ACF of ZC sequence of length 288. Frequency domain');
xlabel('Subcarrier index');


figure(2);
subplot(121);
c_line = 'rgbmkrgb';
for q = 0:7
    [srsSeq1, srsInfo1, idx1] = srs_gen(q); 
    srsSeq1_t = ifft(srsSeq1);
    testcorr = xcorr((srsSeq_t), srsSeq1_t); 
    plot(abs(testcorr),c_line(q+1));
    hold on
end
hold off
xlabel('Time index');
title('Cross-correlation properties. Time domain');

subplot(122);
c_line = 'rgbmkrgb';
for q = 0:7
    [srsSeq1, srsInfo1, idx1] = srs_gen(q); 
    testcorr = xcorr((srsSeq), srsSeq1); 
    plot(abs(fft(testcorr)),c_line(q+1))
    hold on
end
hold off
xlabel('Subcarrier index');
title('Cross-correlation properties. Frequency domain');