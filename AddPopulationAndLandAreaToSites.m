% Adds site population and land area data to the Sites table originally extracted from the IMPROVE metadata
% Population data and land area are downloaded using the fetch_SitePopulation_fromSEDAC script
% via the fetchSEDAC_PopulationAndLandAreaData function.

% If SitePopulations100kmRad and SiteLandArea100kmRad are not already loaded, suggest loading them
if ~exist('SitePopulations100kmRad', 'var') || ~exist('SiteLandArea100kmRad', 'var')
    error('SitePopulations100kmRad and SiteLandArea100kmRad are not loaded. Run fetchSEDAC_PopulationAndLandAreaData first.');
end

% Add the 2020 population data from SitePopulations100kmRad(:,4) to the Pop2020 column of Sites
Sites.Pop2020 = SitePopulations100kmRad(:,4);

%Add the 2020 land area data from SiteLandArea100kmRad(:) to the LandArea column of Sites
Sites.LandArea = SiteLandArea100kmRad(:);
