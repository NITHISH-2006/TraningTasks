# Day 11 Set 3 - Insurance Premium Bands

**Scenario:** An insurer classifies eight applicants by BMI, age band, smoking status and policy term, then stops batch validation at the first ineligible record.

## Deliverables

- [`src/day11/set3/insurance/`](src/day11/set3/insurance/) - package with driver, sealed age bands and records.
- [`output/console_output.txt`](output/console_output.txt) - premium table for all eight applicants.
- [`notes/Memory_Model.md`](notes/Memory_Model.md) - stack/heap/reachability and operator precedence explanation.

## Run

```powershell
$set = "Day11\Set3_InsurancePremiums"
Remove-Item -Recurse -Force "$set\out" -ErrorAction SilentlyContinue
New-Item -ItemType Directory -Force -Path "$set\out" | Out-Null
javac -d "$set\out" (Get-ChildItem "$set\src" -Recurse -Filter *.java | ForEach-Object { $_.FullName })
java -cp "$set\out" day11.set3.insurance.PremiumApp
```
