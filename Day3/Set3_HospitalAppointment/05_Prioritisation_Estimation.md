# Set 3 — Hospital Appointment: Prioritisation and Estimation

## Prioritisation Method: MoSCoW

| Priority | Definition |
|----------|------------|
| **M**ust | Critical for MVP; hospital cannot launch scheduling without it. |
| **S**hould | Important but not launch-blocking; include if capacity allows. |
| **C**ould | Nice to have; V2 or post-launch enhancement. |
| **W**on't | Out of scope for this release. |

## Story Prioritisation

| Story ID | Story Title | Priority | Rationale |
|----------|-------------|----------|-----------|
| US-1.1 | Search doctors by specialty/location | M | Core discovery feature for patients. |
| US-1.2 | View doctor availability | M | Required to book an appointment. |
| US-1.3 | Book appointment online | M | Core revenue/access feature. |
| US-1.4 | Reschedule or cancel | S | Important for patient flexibility; V1 must-have but can be simple. |
| US-2.1 | Set weekly availability | M | Doctors must define when they can be booked. |
| US-2.2 | View daily appointment list | M | Doctors need to see their schedule. |
| US-2.3 | Mark completed / no-show | M | Required for accurate records and billing. |
| US-3.1 | Appointment reminders | S | Reduces no-shows; high value but not launch-blocking. |
| US-3.2 | Confirm from reminder | C | Nice-to-have engagement feature. |
| US-3.3 | Receptionist check-in list | M | Front desk needs to manage arrivals. |
| US-4.1 | Manage locations & departments | M | Admin must configure the clinic structure. |
| US-4.2 | Set slot duration & buffer | M | Scheduling rules must be configurable. |
| US-4.3 | Clinic utilization reports | C | Management reporting; V2 feature. |
| US-5.1 | Check patient in | M | Receptionist workflow core. |
| US-5.2 | Walk-in waitlist | S | Improves walk-in handling; not launch-critical. |

## Estimation Method: Story Points (Fibonacci)

Scale: 1, 2, 3, 5, 8, 13, 20, 40, 100

| Story ID | Story Title | Story Points | Estimation Notes |
|----------|-------------|--------------|------------------|
| US-1.1 | Search doctors by specialty/location | 5 | Search filters + doctor listing UI. |
| US-1.2 | View doctor availability | 5 | Calendar/slot generation logic. |
| US-1.3 | Book appointment online | 8 | Booking flow + confirmation + slot locking. |
| US-1.4 | Reschedule or cancel | 5 | Slot release + fee logic + notifications. |
| US-2.1 | Set weekly availability | 5 | Recurring pattern + exceptions UI. |
| US-2.2 | View daily appointment list | 3 | List view + patient detail drill-down. |
| US-2.3 | Mark completed / no-show | 3 | Status update + visit notes. |
| US-3.1 | Appointment reminders | 8 | Notification service + scheduling (cron). |
| US-3.2 | Confirm from reminder | 3 | Confirmation endpoint + status update. |
| US-3.3 | Receptionist check-in list | 5 | Queue view + check-in action + doctor notify. |
| US-4.1 | Manage locations & departments | 5 | CRUD + admin UI + assignment. |
| US-4.2 | Set slot duration & buffer | 3 | Configuration + slot generation rules. |
| US-4.3 | Clinic utilization reports | 13 | Reporting queries + dashboard + export. |
| US-5.1 | Check patient in | 3 | Check-in action + room assignment. |
| US-5.2 | Walk-in waitlist | 5 | Waitlist + estimated wait + conversion. |

## Sprint Planning Projection

Assuming team velocity of 30 story points per 2-week sprint:

| Sprint | Stories | Total Points | Focus |
|--------|---------|--------------|-------|
| Sprint 1 | US-1.1, US-1.2, US-2.1, US-4.1, US-4.2 | 23 | Search, availability, admin config |
| Sprint 2 | US-1.3, US-2.2, US-2.3, US-3.3, US-5.1 | 22 | Booking, doctor view, check-in |
| Sprint 3 | US-1.4, US-3.1, US-5.2, US-3.2 | 21 | Reschedule, reminders, waitlist, confirm |
| Sprint 4 | US-4.3, US-1.4 (refinement), spillover | 16 | Reports + spillover |

## Estimation Assumptions

- Team: 3 developers, 1 QA, 1 PO, 1 SM
- HIPAA compliance review required for patient data stories (US-1.3, US-2.2, US-3.1)
- Story points reflect complexity, risk, and effort — not hours
- Planning poker used for consensus estimation
