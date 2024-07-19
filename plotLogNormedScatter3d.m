function hScatter = plotLogNormedScatter3d(X, Y, Z, C, axisLimitThresholds, axisLabels)
    % Calculate percentiles for axis limits based on axisLimitThresholds
    X_percentiles = prctile(log10(X), axisLimitThresholds*100);
    Y_percentiles = prctile(log10(Y), axisLimitThresholds*100);
    Z_percentiles = prctile(log10(Z), axisLimitThresholds*100);
    C_percentiles = prctile(log10(C), axisLimitThresholds*100);

    % Plot the data
    hScatter = scatter3(X, Y, Z, 2, C, 'filled');
    xlabel(axisLabels{1});
    ylabel(axisLabels{2});
    zlabel(axisLabels{3});
    title(sprintf('%s, %s, %s; color: %s', axisLabels{1}, axisLabels{2}, axisLabels{3}, axisLabels{4}));
    hColorbar = colorbar;
    hColorbar.Label.String = axisLabels{4};
    colormap(jet);
    clim(C_percentiles); % Set color axis limits based on C percentiles

    % Set axis limits based on percentiles
    xlim(X_percentiles);
    ylim(Y_percentiles);
    zlim([min(Z_percentiles), max(Z_percentiles)]);

end