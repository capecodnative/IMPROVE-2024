function showCorrHeatmap(corrMatrix, variableNames)
    % This function displays a heatmap of the correlation coefficients matrix
    % corrMatrix: A square matrix containing correlation coefficients
    % variableNames: A cell array of strings containing the variable names

    % Check if the number of variables matches the size of the correlation matrix
    if length(variableNames) ~= size(corrMatrix, 1)
        error('The number of variable names must match the size of the correlation matrix.');
    end

    % Modify variable names for subscripting after underscore
    for i = 1:length(variableNames)
        if contains(variableNames{i}, '_')
            parts = split(variableNames{i}, '_');
            variableNames{i} = [parts{1}, '_{', parts{2}, '}']; % Assuming one underscore per variable name
            % For multiple underscores, you might need a more complex handling
        end
    end

    % Create the heatmap with modified variable names
    heatmap(variableNames, variableNames, corrMatrix, ...
        'Colormap', jet, ...  % Use the jet colormap for better visibility
        'ColorLimits', [-1, 1], ...  % Set color limits from -1 to 1
        'Title', 'Correlation Coefficients Heatmap', ...
        'CellLabelColor','none');  % Hide cell labels for a cleaner look

    % Enhance the appearance
    ax = gca;  % Get the current axes to modify further properties
    ax.XLabel = 'Variables';
    ax.YLabel = 'Variables';
    ax.XData = variableNames;  % Ensure the variable names are used on the x-axis
    ax.YData = variableNames;  % Ensure the variable names are used on the y-axis
    ax.GridVisible = 'off';  % Turn off the grid for a cleaner look
end