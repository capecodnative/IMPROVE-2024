function [SitePopulations, SiteLandArea] = fetchSEDAC_PopulationAndLandArea(latitude, longitude, siteName)
    % Fetches population data and land area for a given latitude and longitude from SEDAC (NASA)

    % Define the radius and prepare the request
    tempCircle = fliplr(scircle1(latitude, longitude, 50, [], earthRadius('km')));
    tempRequest.polygon = tempCircle;
    tempRequest.variables = {'gpw-v4-population-count-rev10_2000', 'gpw-v4-population-count-rev10_2005', 'gpw-v4-population-count-rev10_2015', 'gpw-v4-population-count-rev10_2020', 'gpw-v4-land-water-area-rev10_landareakm'};
    tempRequest.statistics = {'SUM'};
    tempRequest.requestID = {'123456789'};
    tempRequest.f = 'pjson';

    % Log the request
    fprintf('Fetching %s \n', siteName);

    % Perform the web request
    tempResponse = webwrite('https://sedac.ciesin.columbia.edu/arcgis-hosting-server/rest/services/sedac-pes/pesv3Broker/GPServer/pesv3Broker/execute/',...
        'Input_Data', jsonencode(tempRequest), 'f', "pjson", weboptions('Timeout', 40));
    tempResponseDecoded = jsondecode(tempResponse);

    % Extract population data and land area
    SitePopulations = zeros(1, 4);
    SitePopulations(1) = str2double(tempResponseDecoded.results.value.estimates.gpw_v4_population_count_rev10_2000.SUM);
    SitePopulations(2) = str2double(tempResponseDecoded.results.value.estimates.gpw_v4_population_count_rev10_2005.SUM);
    SitePopulations(3) = str2double(tempResponseDecoded.results.value.estimates.gpw_v4_population_count_rev10_2015.SUM);
    SitePopulations(4) = str2double(tempResponseDecoded.results.value.estimates.gpw_v4_population_count_rev10_2020.SUM);
    SiteLandArea = str2double(tempResponseDecoded.results.value.estimates.gpw_v4_land_water_area_rev10_landareakm.SUM);

end