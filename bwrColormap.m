function bwrColormap(numColors)
    % Create a blue-white-red colormap
    % numColors: Number of colors in the colormap

    if nargin < 1
        numColors = 256; % Default number of colors
    end

    % Define the start (blue), middle (white), and end (red) colors
    blue = [0, 0, 1];
    white = [1, 1, 1];
    red = [1, 0, 0];

    % Create a transition from blue to white and from white to red
    halfPoint = floor(numColors / 2);
    blueToWhite = [linspace(blue(1), white(1), halfPoint)', linspace(blue(2), white(2), halfPoint)', linspace(blue(3), white(3), halfPoint)'];
    whiteToRed = [linspace(white(1), red(1), numColors - halfPoint)', linspace(white(2), red(2), numColors - halfPoint)', linspace(white(3), red(3), numColors - halfPoint)'];

    % Combine to form the BWR colormap
    bwrMap = [blueToWhite; whiteToRed];

    % Apply the colormap
    colormap(bwrMap);
end