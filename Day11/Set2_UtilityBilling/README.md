# Day 11 Set 2 - Utility Billing Calculator

**Scenario:** An electricity distributor bills four consumption slabs, category fixed charges, late surcharge and online rebate.

## Deliverables

- [`src/day11/set2/billing/`](src/day11/set2/billing/) - package with driver, category enum, calculator and casting demo.
- [`output/console_output.txt`](output/console_output.txt) - boundary table, 12-month statement, sample meter readings and casting examples.
- [`notes/Boundary_Tests.md`](notes/Boundary_Tests.md) - expected values at 100/101/200/201/400/401 units.

## Run

```powershell
$set = "Day11\Set2_UtilityBilling"
Remove-Item -Recurse -Force "$set\out" -ErrorAction SilentlyContinue
New-Item -ItemType Directory -Force -Path "$set\out" | Out-Null
javac -d "$set\out" (Get-ChildItem "$set\src" -Recurse -Filter *.java | ForEach-Object { $_.FullName })
"1200 1350 1350 1500 1500 1605 0" | java -cp "$set\out" day11.set2.billing.BillingApp
```
