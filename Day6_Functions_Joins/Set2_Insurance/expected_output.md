# Expected Output - Set 2 Insurance Policy Reporting

Assumed sample: 10 customers, 5 agents, 5 products (Health, Motor, Life, Home, Travel), ~20 policies, claims on subset.

## Q1 Policies expiring in the next 30 days
Purpose: renewal follow-up list (masked policy numbers via CONCAT/SUBSTRING).
| id | masked_policy | end_date | days_to_expiry |
|---:|---|---|---:|
| 14 | ****8821 | 2026-11-25 | 9 |
| 17 | ****4410 | 2026-12-05 | 19 |
| 19 | ****1299 | 2026-12-12 | 26 |

## Q2 Premium per product
| product_name | total_premium |
|---|---:|
| Life | 320000.00 |
| Health | 210000.00 |
| Motor | 145000.00 |
| Home | 98000.00 |
| Travel | 42000.00 |

## Q3 Customers with more than one active policy
| id | name | active_policies |
|---:|---|---:|
| 1 | Ravi Kumar | 3 |
| 6 | Divya Nair | 2 |

## Q4 Claim ratio per product
| product_name | total_premium | total_claims | claim_ratio_pct |
|---|---:|---:|---:|
| Motor | 145000.00 | 101500.00 | 70.00 |
| Health | 210000.00 | 126000.00 | 60.00 |
| Home | 98000.00 | 29400.00 | 30.00 |
| Life | 320000.00 | 32000.00 | 10.00 |
| Travel | 42000.00 | 0.00 | 0.00 |

## Q5 Policies without claims (LEFT JOIN)
Example rows: policies 2 (****1102, Health), 5 (****7743, Life), 11 (****3381, Travel), etc. (no matching claim).

## Q6 Average premium by age band
| age_band | avg_premium |
|---|---:|
| <25 | 8500.00 |
| 25-34 | 14200.00 |
| 35-44 | 19800.00 |
| 45-60 | 26500.00 |
| 60+ | 31200.00 |

## Q7 Monthly new policies
| month | new_policies |
|---|---:|
| 2026-07 | 4 |
| 2026-08 | 6 |
| 2026-09 | 5 |
| 2026-10 | 5 |

## Q8 Top-5 agents by premium
| id | name | total_premium |
|---:|---|---:|
| 2 | Vikram Shah | 210000.00 |
| 1 | Anita Rao | 185000.00 |
| 4 | Rohit Das | 162000.00 |
| 3 | Meera Iyer | 140000.00 |
| 5 | Kiran Patil | 118000.00 |

## Task 3 (HAVING claim ratio > 60%)
| product_name | claim_ratio_pct |
|---|---:|
| Motor | 70.00 |

## Task 4 join choices
- **INNER JOIN**: policies↔products/customers/agents when only matched records matter (premiums, age bands, agents). 
- **LEFT JOIN**: policies↔claims to retain policies with zero claims for ratios and "without claims".
- **CROSS JOIN**: Cartesian pairing (product × region) for coverage/comparison grids where no natural key relation exists.
