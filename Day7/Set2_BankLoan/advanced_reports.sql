/* Day 7 - Set 2: Bank Loan Portfolio (MySQL 8.4)
   Assumed: branches(id,name), customers(id,name), guarantors(id,name),
   loans(id,customer_id,branch_id,amount,status,start_date),
   repayments(id,loan_id,due_date,paid_date,amount),
   loan_guarantors(loan_id,guarantor_id) -- guarantor may also be a borrower (exists in customers)
*/

-- Q1 (INNER/LEFT): Loans overdue by more than three instalments
SELECT l.id AS loan_id, c.name AS customer, b.name AS branch,
       COUNT(r.id) AS overdue_instalments
FROM loans l
JOIN customers c ON c.id = l.customer_id
JOIN branches b ON b.id = l.branch_id
JOIN repayments r ON r.loan_id = l.id
WHERE r.paid_date IS NULL AND r.due_date < CURDATE()
GROUP BY l.id, c.name, b.name
HAVING COUNT(r.id) > 3;

-- Q2 (INNER JOIN + GROUP BY/HAVING): Customers with loans in more than one branch
SELECT c.id, c.name, COUNT(DISTINCT l.branch_id) AS branch_count
FROM customers c JOIN loans l ON l.customer_id = c.id
GROUP BY c.id, c.name
HAVING COUNT(DISTINCT l.branch_id) > 1;

-- Q3 (SELF JOIN via customers/guarantors mapping): Guarantors who are also borrowers
SELECT DISTINCT g.id AS guarantor_id, g.name AS guarantor_name, c2.id AS borrower_customer_id
FROM guarantors g
JOIN loan_guarantors lg ON lg.guarantor_id = g.id
JOIN customers c2 ON c2.name = g.name; -- or ON c2.id = g.customer_ref_id in a normalized model

-- Q4 (LEFT JOIN): Branches with no loans
SELECT b.id, b.name
FROM branches b LEFT JOIN loans l ON l.branch_id = b.id
WHERE l.id IS NULL;

-- Q5 (INNER JOIN): Loan details with customer and branch
SELECT l.id, c.name AS customer, b.name AS branch, l.amount, l.status
FROM loans l
JOIN customers c ON c.id = l.customer_id
JOIN branches b ON b.id = l.branch_id;

-- Q6 (LEFT JOIN): Loans with no repayments recorded
SELECT l.id, c.name, l.amount
FROM loans l
JOIN customers c ON c.id = l.customer_id
LEFT JOIN repayments r ON r.loan_id = l.id
WHERE r.id IS NULL;

-- Q7 (INNER JOIN): Total repaid per loan
SELECT l.id, l.amount AS loan_amount, ROUND(SUM(r.amount),2) AS total_repaid
FROM loans l JOIN repayments r ON r.loan_id = l.id AND r.paid_date IS NOT NULL
GROUP BY l.id, l.amount;

-- Q8 (SELF JOIN on branches via loans): Pairs of loans in same branch
SELECT l1.id AS loan_a, l2.id AS loan_b, l1.branch_id
FROM loans l1 JOIN loans l2 ON l1.branch_id = l2.branch_id AND l1.id < l2.id;

-- Q9 (RIGHT/LEFT): All branches and their total exposure
SELECT b.id, b.name, ROUND(IFNULL(SUM(l.amount),0),2) AS total_exposure
FROM loans l RIGHT JOIN branches b ON b.id = l.branch_id
GROUP BY b.id, b.name;

-- Q10 (INNER JOIN): Active loans with guarantor count
SELECT l.id, c.name, COUNT(lg.guarantor_id) AS guarantor_count
FROM loans l
JOIN customers c ON c.id = l.customer_id
LEFT JOIN loan_guarantors lg ON lg.loan_id = l.id
WHERE l.status = 'ACTIVE'
GROUP BY l.id, c.name;

-- Correlated subquery: customers whose total loan exposure exceeds the branch average
SELECT c.id, c.name, b.name AS branch,
       (SELECT SUM(l2.amount) FROM loans l2 WHERE l2.customer_id = c.id) AS customer_exposure
FROM customers c
JOIN loans l ON l.customer_id = c.id
JOIN branches b ON b.id = l.branch_id
WHERE (SELECT SUM(l2.amount) FROM loans l2 WHERE l2.customer_id = c.id) >
      (SELECT AVG(be.branch_total) FROM (
          SELECT SUM(l3.amount) AS branch_total FROM loans l3 WHERE l3.branch_id = l.branch_id
       ) be);

-- Uncorrelated subquery variant: customers with exposure above overall average branch exposure
SELECT c.id, c.name, SUM(l.amount) AS customer_exposure
FROM customers c JOIN loans l ON l.customer_id = c.id
GROUP BY c.id, c.name
HAVING SUM(l.amount) > (
  SELECT AVG(bt.total_amt) FROM (SELECT SUM(amount) AS total_amt FROM loans GROUP BY branch_id) bt
);

-- EXISTS / NOT EXISTS: customers with a loan but no repayment in the last 60 days
SELECT DISTINCT c.id, c.name
FROM customers c
WHERE EXISTS (SELECT 1 FROM loans l WHERE l.customer_id = c.id)
  AND NOT EXISTS (
    SELECT 1 FROM repayments r
    JOIN loans l2 ON l2.id = r.loan_id
    WHERE l2.customer_id = c.id
      AND r.paid_date IS NOT NULL
      AND r.paid_date >= DATE_SUB(CURDATE(), INTERVAL 60 DAY)
  );

-- Nested subquery: branches whose highest loan is greater than the average of all branch maximums
SELECT b.id, b.name
FROM branches b
WHERE (SELECT MAX(l.amount) FROM loans l WHERE l.branch_id = b.id) >
      (SELECT AVG(m.max_amt) FROM (
         SELECT MAX(amount) AS max_amt FROM loans GROUP BY branch_id
       ) m);
