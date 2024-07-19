% Assuming IMPelems is a structure containing element data
X = log10(IMPelems.Al ./ IMPelems.Si);
Y = log10(IMPelems.Fe ./ IMPelems.Si);
Z = log10(IMPelems.Ti ./ IMPelems.Si);
C = IMPloc.Longitude;
tempPosition =  [3062.6 146.6 1102.4 858];

% Define axis labels
axisLabels = {'log_{10}(Al/Si)', 'log_{10}(Fe/Si)', 'log_{10}(Ti/Si)', 'Longitude'};

% Define axis limit thresholds as percentiles
axisLimitThresholds = [0.01, 99.99];

% Call the function
hScatter = plotScatter3dWithThresholds(X, Y, Z, C, axisLimitThresholds, axisLabels, tempPosition);
view(51,16);
clim([-150 -63]);

clear X Y Z C axisLabels axisLimitThresholds tempPosition;