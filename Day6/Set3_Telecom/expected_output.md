# Expected Output - Set 3 Telecom Usage and Billing

Assumed sample: 12 subscribers across circles (North/South/East/West), 4 plans (Basic/Plus/Max/Unlimited), call/data records and invoices with some NULL/missing usage and overdue unpaid invoices.

## Q1 Total call minutes per plan
| plan_name | total_minutes |
|---|---:|
| Max | 18450 |
| Plus | 14200 |
| Unlimited | 12800 |
| Basic | 7600 |

## Q2 Subscribers exceeding their data limit
| id | name | plan_name | data_limit_gb | total_data_used_gb |
|---:|---|---|---:|---:|
| 3 | Aman Verma | Basic | 10.00 | 14.50 |
| 8 | Kavya Desai | Plus | 30.00 | 36.20 |

## Q3 Month-wise revenue
| month | revenue |
|---|---:|
| 2026-08 | 184500.00 |
| 2026-09 | 196200.00 |
| 2026-10 | 201750.00 |

## Q4 Invoices overdue by more than 15 days
| invoice_no | subscriber | due_date_fmt | days_overdue | due_status | amount | status |
|---|---|---|---:|---|---:|---|
| INV-000014 | Leela Menon | 10-Oct-2026 | 37 | OVERDUE>15 | 799.00 | UNPAID |
| INV-000019 | Nisha Roy | 15-Oct-2026 | 32 | OVERDUE>15 | 1299.00 | UNPAID |

## Q5 Subscribers with no usage (LEFT JOIN)
| id | name | circle |
|---:|---|---|
| 11 | Mohan Lal | North |
| 12 | Diya Sen | East |

## Q6 ARPU by circle
| circle | arpu |
|---|---:|
| West | 1120.00 |
| North | 980.50 |
| South | 945.00 |
| East | 870.00 |

## Q7 Plan popularity
| plan_name | subscriber_count |
|---|---:|
| Plus | 4 |
| Max | 3 |
| Basic | 3 |
| Unlimited | 2 |

## Q8 Top-10 data consumers
| id | name | total_data_gb |
|---:|---|---:|
| 2 | Priya Sharma | 48.60 |
| 8 | Kavya Desai | 36.20 |
| 5 | Suresh Patil | 33.10 |
| 1 | Ravi Kumar | 29.40 |
| 6 | Nisha Roy | 27.80 |
| 7 | Imran Ali | 25.00 |
| 9 | Rahul Jain | 22.30 |
| 10 | Tara Singh | 18.90 |
| 4 | Leela Menon | 16.40 |
| 3 | Aman Verma | 14.50 |

## Task 3 NULL effect and fix
For subscribers with no usage rows (e.g. 11,12) LEFT JOIN yields `SUM/AVG = NULL`; `IFNULL(SUM,0)` and `COALESCE(AVG,0)` return 0 for clean reporting.

## Task 4 Revenue per plan and circle
| plan_name | circle | revenue | subscribers |
|---|---|---:|---:|
| Basic | North | 24000.00 | 1 |
| Basic | South | 23970.00 | 1 |
| Plus | East | 51960.00 | 2 |
| Plus | West | 38970.00 | 1 |
| Max | North | 44970.00 | 1 |
| Max | South | 59960.00 | 2 |
| Unlimited | West | 35970.00 | 2 |
