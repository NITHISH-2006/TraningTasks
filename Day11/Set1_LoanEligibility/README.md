# Day 11 Set 1 - Loan Eligibility Engine

**Scenario:** A bank pre-screens ten loan applicants using six rules, daily approval limits and credit-band pricing.

## Deliverables

- [`src/day11/set1/loan/`](src/day11/set1/loan/) - package with driver, record types and sealed credit bands.
- [`output/console_output.txt`](output/console_output.txt) - decision table for all ten applicants.
- [`notes/Test_Cases.md`](notes/Test_Cases.md) - inputs and expected decisions, including edge cases.

## Run

```powershell
$set = "Day11\Set1_LoanEligibility"
Remove-Item -Recurse -Force "$set\out" -ErrorAction SilentlyContinue
New-Item -ItemType Directory -Force -Path "$set\out" | Out-Null
javac -d "$set\out" (Get-ChildItem "$set\src" -Recurse -Filter *.java | ForEach-Object { $_.FullName })
java -cp "$set\out" day11.set1.loan.LoanEligibilityApp
```
