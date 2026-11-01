# Day 1 - Set 3: Hospital Appointment Desk

**Scenario:** A multi-speciality hospital runs its appointment desk on a shared roster. Receptionists search for patients, doctors need the day's list sorted by urgency, and the system must prevent the same patient from being booked twice in one slot.

## Tasks

| File | Task | Key idea |
| --- | --- | --- |
| `src/Task1_Search.java` | Search 20,000 patient records | Linear vs binary search over 1,000 look-ups |
| `src/Task2_Sorting.java` | Sort by urgency, then arrival time | Selection sort vs quick sort with swap counts and timings |
| `src/Task3_Duplicates.java` | Prevent double-booked slots | `HashSet` keyed by patient + slot |
| `src/Task4_StackQueue.java` | Walk-in tokens and recent-patient history | Custom queue/stack from scratch, then `ArrayDeque` |
| `src/Task5_DP_Appointments.java` | Maximum appointments in a shift | Weighted-interval dynamic programming vs greedy earliest start |

## Run

From this folder (PowerShell):

```powershell
Remove-Item -Recurse -Force out -ErrorAction SilentlyContinue
New-Item -ItemType Directory -Force -Path out | Out-Null
javac -d out (Get-ChildItem src\*.java | ForEach-Object { $_.FullName })
java -cp out Task1_Search
java -cp out Task2_Sorting
java -cp out Task3_Duplicates
java -cp out Task4_StackQueue
java -cp out Task5_DP_Appointments
```

## Result highlights

- Quick sort performs far better than selection sort on 20,000 appointments, even though it records more swaps.
- Greedy earliest-start scheduling chooses the long ward round and blocks the short consultations; DP schedules 9 appointments instead of 3.

## Results

- Full console output: [`output/console_output.txt`](output/console_output.txt)
- Complexity and rationale: [`notes/Complexity_Note.md`](notes/Complexity_Note.md)
