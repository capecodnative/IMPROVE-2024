function shorCorrHeatmap_sorted(corrMatrix, variableNames, sortRowIndex)
    % This function displays a heatmap of the correlation coefficients matrix
    % corrMatrix: A square matrix containing correlation coefficients
    % variableNames: A cell array of strings containing the variable names
    % sortRowIndex (optional): The index of the row based on which the matrix and variable names will be sorted

    % Check if the number of variables matches the size of the correlation matrix
    if length(variableNames) ~= size(corrMatrix, 1)
        error('The number of variable names must match the size of the correlation matrix.');
    end

    % Check if sortRowIndex is provided
    if nargin == 3
        % Temporarily set diagonal elements to a value greater than 1 to ensure they are sorted as maximum
        tempDiag = diag(corrMatrix); % Save original diagonal elements
        corrMatrix(logical(eye(size(corrMatrix)))) = 1.1;

        % Sort the specified row and get the indices for sorting
        [~, sortedIndices] = sort(corrMatrix(sortRowIndex, :), 'descend');

        % Use the sorted indices to reorder the correlation matrix and variable names
        corrMatrix = corrMatrix(sortedIndices, sortedIndices);
        variableNames = variableNames(sortedIndices);

        % Reset diagonal elements to 1 (or original values if needed)
        corrMatrix(logical(eye(size(corrMatrix)))) = tempDiag(sortedIndices);
    elseif nargin > 3
        error('Too many input arguments.');
    end

    % Modify variable names for subscripting after underscore
    for i = 1:length(variableNames)
        if contains(variableNames{i}, '_')
            parts = split(variableNames{i}, '_');
            variableNames{i} = [parts{1}, '_{', parts{2}, '}']; % Assuming one underscore per variable name
            % For multiple underscores, you might need a more complex handling
        end
    end

    % Create a new figure for the heatmap
    figure;

    % Create the heatmap with modified and (optionally) sorted variable names
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