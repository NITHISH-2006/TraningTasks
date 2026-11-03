# Set 3 — Hospital Appointment: Epics and User Stories

## Epics

| Epic ID | Epic Name | Description |
|---------|-----------|-------------|
| E1 | Patient Booking | Patients search doctors, view availability, and book/reschedule/cancel appointments. |
| E2 | Doctor Schedule Management | Doctors set availability, view appointments, and manage patient lists. |
| E3 | Reminders & Notifications | Automated reminders to patients and staff before appointments. |
| E4 | Clinic Administration | Admins manage locations, departments, staff, and scheduling rules. |
| E5 | Check-in & Visit Management | Receptionists check patients in, manage waitlist, and update visit status. |

## User Stories

### Epic E1 — Patient Booking

| ID | User Story | Acceptance Criteria Summary |
|----|------------|-----------------------------|
| US-1.1 | As a patient, I want to search for doctors by specialty and location, so that I can find the right provider. | Search returns doctors filtered by specialty, location, rating; shows availability. |
| US-1.2 | As a patient, I want to view a doctor's available time slots, so that I can pick a convenient appointment. | Slots shown for next 30 days; blocked times excluded; timezone aware. |
| US-1.3 | As a patient, I want to book an appointment online, so that I don't have to call the clinic. | Appointment created; confirmation shown; confirmation email/SMS sent. |
| US-1.4 | As a patient, I want to reschedule or cancel my appointment, so that I can adjust when my plans change. | Reschedule updates slot; cancel releases slot; cancellation policy shown; fees applied if applicable. |

### Epic E2 — Doctor Schedule Management

| ID | User Story | Acceptance Criteria Summary |
|----|------------|-----------------------------|
| US-2.1 | As a doctor, I want to set my weekly availability, so that patients only book when I'm available. | Recurring weekly pattern; exceptions (holidays, leave) blockable; saved per doctor. |
| US-2.2 | As a doctor, I want to view my daily appointment list with patient details, so that I can prepare for visits. | List shows patient name, reason, time, visit type; click for patient history. |
| US-2.3 | As a doctor, I want to mark an appointment as completed or no-show, so that records are accurate. | Status updated; no-show triggers follow-up workflow; visit notes enabled after completion. |

### Epic E3 — Reminders & Notifications

| ID | User Story | Acceptance Criteria Summary |
|----|------------|-----------------------------|
| US-3.1 | As a patient, I want to receive appointment reminders via SMS and email, so that I don't forget my visit. | Reminders sent 24h and 2h before; includes date, time, location, prep instructions. |
| US-3.2 | As a patient, I want to confirm my appointment from the reminder, so that the clinic knows I'm coming. | Confirmation updates appointment status; doctor notified; no-show risk reduced. |
| US-3.3 | As a receptionist, I want to see today's check-in list with arrival status, so that I can manage patient flow. | List shows scheduled vs. arrived; check-in button updates status; wait time estimated. |

### Epic E4 — Clinic Administration

| ID | User Story | Acceptance Criteria Summary |
|----|------------|-----------------------------|
| US-4.1 | As an admin, I want to add and manage clinic locations and departments, so that the system reflects our organization. | CRUD for locations, departments, rooms; each doctor assigned to location/department. |
| US-4.2 | As an admin, I want to set appointment slot duration and buffer times, so that schedules are realistic. | Slot length configurable per department (e.g., 15 min general, 30 min specialist); buffer between appointments. |
| US-4.3 | As an admin, I want to view clinic utilization reports, so that I can optimize staffing and room allocation. | Report shows bookings per day, no-show rate, room utilization, doctor utilization. |

### Epic E5 — Check-in & Visit Management

| ID | User Story | Acceptance Criteria Summary |
|----|------------|-----------------------------|
| US-5.1 | As a receptionist, I want to check a patient in when they arrive, so that the doctor knows they are here. | Check-in updates status to "Arrived"; doctor notified; room assigned. |
| US-5.2 | As a receptionist, I want to add walk-in patients to the waitlist, so that they can be seen when a slot opens. | Walk-in added with estimated wait; notified when slot available; converted to appointment. |
