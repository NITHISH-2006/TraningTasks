# Notes - Set 3 Telecom
- DATE_FORMAT/DATEDIFF/CONCAT/LPAD/CASE used to format invoice numbers and compute due-date status.
- LEFT JOIN used to find subscribers with no usage; NULL aggregates from missing rows fixed with IFNULL/COALESCE.
- Revenue per plan and circle via multi-table JOIN + GROUP BY + SUM/COUNT(DISTINCT).
- WHERE vs HAVING: limit/exceed checks on aggregated usage use HAVING (e.g. Q2).
