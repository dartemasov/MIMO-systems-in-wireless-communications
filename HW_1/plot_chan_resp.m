function plot_chan_resp(L, Link_Channel)
figure(1);
subplot(211), plot(1:L,abs(squeeze(Link_Channel(1,1,1:L,80))),'LineWidth',3);
xlabel('subcarrier index'); ylabel('abs(H)');
% ylim([0 1.2])
ax = gca(); set(ax, 'FontSize',16);
hold on
plot([0 L],[1 1],'r--','LineWidth',2)
hold off

subplot(212), plot(1:L,angle(squeeze(Link_Channel(1,1,1:L,80)))*180/pi,'LineWidth',3);
xlabel('subcarrier index'); ylabel('arg(H)');
ax = gca(); set(ax, 'FontSize',16);
end








