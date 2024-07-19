function hScatter = plotScatter3dWithThresholds(X, Y, Z, C, axisLimitThresholds, axisLabels, varargin)
    % Plot the data
    figure;
    hScatter = scatter3(X, Y, Z, 2, C, 'filled');
    xlabel(axisLabels{1});
    ylabel(axisLabels{2});
    zlabel(axisLabels{3});
    title(sprintf('%s, %s, %s; color: %s', axisLabels{1}, axisLabels{2}, axisLabels{3}, axisLabels{4}));
    hColorbar = colorbar;
    hColorbar.Label.String = axisLabels{4};
    colormap(jet);
    
    % Set axis limits based on percentiles, calculated in-line
    xlim(prctile(X, axisLimitThresholds));
    ylim(prctile(Y, axisLimitThresholds));
    zlim(prctile(Z, axisLimitThresholds));
    clim(prctile(C, axisLimitThresholds));
    
    % Adjust figure position if specified
    if ~isempty(varargin)
        set(gcf, 'Position', varargin{1});
    end
    
end