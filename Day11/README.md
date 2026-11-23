# Day 11 - Java (JDK 25 LTS)

Topics: JDK/JRE/JVM, stack vs heap, garbage collection, control statements, loops, operators and access modifiers.

All sets use the Java 25 standard library only and live under a package structure (`day11.setN.<domain>`).

| Set | Folder | Focus | Key Deliverables |
|---|---|---|---|
| 1 | `Set1_LoanEligibility/` | Rules, `var`, pattern-matching switch, `continue`/`break`, decision table | `src/`, `output/console_output.txt`, `notes/Test_Cases.md` |
| 2 | `Set2_UtilityBilling/` | Slabs, switch expression, loops, operator precedence, casting | `src/`, `output/console_output.txt`, `notes/Boundary_Tests.md` |
| 3 | `Set3_InsurancePremiums/` | BMI, switch guards, labelled break, memory model | `src/`, `output/console_output.txt`, `notes/Memory_Model.md` |

Run one set from the repository root:

```powershell
$set = "Day11\Set1_LoanEligibility"
New-Item -ItemType Directory -Force -Path "$set\out" | Out-Null
javac -d "$set\out" (Get-ChildItem "$set\src" -Recurse -Filter *.java | ForEach-Object { $_.FullName })
java -cp "$set\out" day11.set1.loan.LoanEligibilityApp
```

Requires JDK 25 LTS (verified with Temurin 25.0.5).
