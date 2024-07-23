% Fetches site population data and land area from SEDAC (NASA) for all sites in the Sites table
numSites = height(Sites);
SitePopulations100kmRad = nan(numSites, 4);
SiteLandArea100kmRad = nan(numSites, 1);

for i = 1:numSites
    [SitePopulations, SiteLandArea] = fetchSEDAC_PopulationAndLandArea(Sites.Latitude(i), Sites.Longitude(i), Sites.Site(i));
    SitePopulations100kmRad(i, :) = SitePopulations;
    SiteLandArea100kmRad(i) = SiteLandArea;
    fprintf('Fetched #%d %s \n', i, Sites.Site(i));
end

%clear all unwanted created variables
clear i numSites SiteLandArea SitePopulations