# Justification Note - Set 2 Bank Loan Portfolio

| # | Question | Join/Subquery | Justification |
|---|---|---|---|
| Q1 | Loans overdue by > 3 instalments | INNER JOIN loans/customers/branches/repayments + HAVING | Need matched loan/customer/branch and overdue unpaid instalments; aggregate count per loan filtered with HAVING. |
| Q2 | Customers with loans in >1 branch | INNER JOIN customers-loans + HAVING COUNT(DISTINCT branch_id) | Only customers having loans; distinct branches per customer computed post-aggregation. |
| Q3 | Guarantors who are also borrowers | SELF/relational JOIN (guarantors ↔ customers/loan_guarantors) | Match guarantor identity against borrower records to find overlap. |
| Q4 | Branches with no loans | LEFT JOIN branches->loans + IS NULL | Preserve all branches and detect absence of loans. |
| Q5 | Loan details with customer and branch | INNER JOINs | Report requires existing related customer and branch for each loan. |
| Q6 | Loans with no repayments | LEFT JOIN loans->repayments + IS NULL | Identify loans lacking any repayment rows. |
| Q7 | Total repaid per loan | INNER JOIN loans-repayments (paid) + GROUP BY | Sum actual paid amounts for loans with payments. |
| Q8 | Loan pairs in same branch | SELF JOIN on branch_id | Compare loans within same branch. |
| Q9 | All branches and total exposure | RIGHT/LEFT JOIN to include branches with zero loans | Must show every branch even with NULL/zero exposure (IFNULL). |
| Q10 | Active loans with guarantor count | LEFT JOIN loan_guarantors | Keep active loans even if guarantor count is zero. |
| Corr | Customer exposure > branch average | Correlated subqueries (per-customer, per-branch) | Correlation references outer customer/branch to compute context-specific averages. |
| Uncorr | Exposure > overall avg branch exposure | Uncorrelated nested aggregates | Global benchmark independent of outer row except comparison. |
| Exists | Loan but no repayment in last 60 days | EXISTS + NOT EXISTS | Efficient existence checks: confirm loan exists and no recent paid repayment exists. |
| Nested | Branches whose highest loan > avg of branch maximums | Nested subqueries (MAX per branch, AVG of maxima) | Two-level aggregation: per-branch maxima then average across branches. |

Correlated subqueries depend on outer row values (re-evaluated per row/context) and express row-relative conditions clearly; uncorrelated compute once. EXISTS/NOT EXISTS are appropriate for presence/absence logic and avoid some NULL pitfalls of IN/NOT IN.
