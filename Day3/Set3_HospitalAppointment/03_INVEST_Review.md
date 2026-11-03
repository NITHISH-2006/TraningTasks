# Set 3 — Hospital Appointment: INVEST Review

## INVEST Criteria

| Criterion | Definition |
|-----------|------------|
| **I**ndependent | Story can be developed without depending on another story. |
| **N**egotiable | Details emerge through conversation. |
| **V**aluable | Delivers clear value to user or business. |
| **E**stimable | Team can estimate size/effort. |
| **S**mall | Fits within a single sprint. |
| **T**estable | Clear acceptance criteria exist. |

## Story-by-Story Review

| Story ID | Story Title | I | N | V | E | S | T | Verdict | Refinement Notes |
|----------|-------------|---|---|---|---|---|---|---------|------------------|
| US-1.1 | Search doctors by specialty/location | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | Ready | None. |
| US-1.2 | View doctor availability | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | Ready | None. |
| US-1.3 | Book appointment online | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | Ready | None. |
| US-1.4 | Reschedule or cancel appointment | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | Ready | None. |
| US-2.1 | Set weekly availability | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | Ready | None. |
| US-2.2 | View daily appointment list | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | Ready | None. |
| US-2.3 | Mark completed / no-show | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | Ready | None. |
| US-3.1 | Appointment reminders (SMS/email) | ⚠️ | ✅ | ✅ | ✅ | ✅ | ✅ | Needs refinement | Depends on notification service; split into preference + delivery. |
| US-3.2 | Confirm appointment from reminder | ⚠️ | ✅ | ✅ | ✅ | ✅ | ✅ | Needs refinement | Depends on US-3.1 (reminder must exist first). |
| US-3.3 | Receptionist check-in list | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | Ready | None. |
| US-4.1 | Manage locations & departments | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | Ready | None. |
| US-4.2 | Set slot duration & buffer | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | Ready | None. |
| US-4.3 | Clinic utilization reports | ✅ | ✅ | ✅ | ⚠️ | ⚠️ | ✅ | Needs refinement | Complex reporting; split into basic dashboard and detailed report. |
| US-5.1 | Check patient in | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | Ready | None. |
| US-5.2 | Walk-in waitlist | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | Ready | None. |

## Refinement Summary

- **US-3.1** → Split into US-3.1a (reminder preferences) and US-3.1b (SMS/email delivery).
- **US-3.2** → Mark dependency on US-3.1 (confirmation requires reminder).
- **US-4.3** → Split into US-4.3a (basic utilization dashboard) and US-4.3b (detailed utilization report).

After refinement, all stories meet full INVEST criteria.
