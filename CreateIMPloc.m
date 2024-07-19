% Use innerjoin to merge tables based on SiteCode
IMPloc = innerjoin(IMP(:, 'SiteCode'), Sites(:, {'Code', 'Latitude', 'Longitude', 'Elevation'}), 'Keys', 'SiteCode');