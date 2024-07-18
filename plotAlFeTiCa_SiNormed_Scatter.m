axisLimitThresholds=[0.001,0.999];

% Calculate percentiles for axis limits based on axisLimitThresholds
AlSi_percentiles = prctile(log10(IMPelems.Al./IMPelems.Si), axisLimitThresholds*100);
FeSi_percentiles = prctile(log10(IMPelems.Fe./IMPelems.Si), axisLimitThresholds*100);
TiSi_percentiles = prctile(log10(IMPelems.Ti./IMPelems.Si), axisLimitThresholds*100);
CaSi_percentiles = prctile(log10(IMPelems.Ca./IMPelems.Si), axisLimitThresholds*100);

scatter3(log10(IMPelems.Al./IMPelems.Si),log10(IMPelems.Fe./IMPelems.Si),log10(IMPelems.Ti./IMPelems.Si),2,log10(IMPelems.Ca./IMPelems.Si),'filled');
xlabel('log_{10}(Al/Si)');
ylabel('log_{10}(Fe/Si)');
zlabel('log_{10}(Ti/Si)');
title('log_{10}(Al/Si), log_{10}(Fe/Si), log_{10}(Ti/Si); color: log_{10}(Ca/Si)');
hColorbar = colorbar;
hColorbar.Label.String = 'log_{10}(Ca/Si)';
colormap(jet);
caxis(CaSi_percentiles); % Set color axis limits based on Ca/Ti percentiles

% Set axis limits based on percentiles
xlim(AlSi_percentiles);
ylim(FeSi_percentiles);
zlim(TiSi_percentiles);

clear axisLimitThresholds AlSi_percentiles FeSi_percentiles TiSi_percentiles CaSi_percentiles hColorbar