# Notes - Set 2 Insurance
- Used DATE_ADD/DATEDIFF for expiry windows, CASE+TIMESTAMPDIFF for age bands, CONCAT/SUBSTRING to mask policy numbers.
- Claim ratio computed with IFNULL/NULLIF to handle no-claim products and avoid divide-by-zero.
- INNER joins for required relationships; LEFT join for claims absence/ratio; CROSS join for product-region grid.
- HAVING filters aggregated claim ratio (>60%).
