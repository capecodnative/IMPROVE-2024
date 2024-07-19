% Use innerjoin to merge tables based on SiteCode
IMPloc = innerjoin(IMP(:, {'SiteCode', 'Date'}), Sites(:, {'Code', 'Latitude', 'Longitude', 'Elevation'}),...
 'LeftKeys', 'SiteCode', 'RightKeys', 'Code');