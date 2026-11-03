# Set 3 — Hospital Appointment: Acceptance Criteria

## US-1.1 — Search doctors by specialty and location

**Given** I am on the doctor search page  
**When** I select a specialty (e.g., Cardiology) and location (e.g., Downtown Clinic)  
**Then** I should see a list of matching doctors  
**And** each doctor should show name, specialty, rating, and next available slot  
**And** I can clear filters to see all doctors

**Additional AC:**
- Search is case-insensitive
- Results sorted by rating or earliest availability (selectable)
- "No doctors found" message when no matches

## US-1.2 — View doctor available time slots

**Given** I am viewing a doctor's profile  
**When** I select a date within the next 30 days  
**Then** I should see available time slots for that date  
**And** booked or blocked times should not be shown  
**And** times should display in my local timezone

**Additional AC:**
- Slots shown in 15-, 30-, or 60-minute intervals based on appointment type
- Past times on the current day are not bookable

## US-1.3 — Book an appointment online

**Given** I have selected a doctor and time slot  
**When** I confirm the booking with appointment type and reason  
**Then** an appointment should be created with status "Scheduled"  
**And** I should see a confirmation page with appointment details  
**And** a confirmation email/SMS should be sent to me  
**And** the slot should be marked as booked for other patients

**Additional AC:**
- Patient must be logged in (or prompted to register)
- Appointment cannot be booked in the past
- Duplicate bookings for same time prevented

## US-1.4 — Reschedule or cancel appointment

**Given** I have an upcoming appointment  
**When** I select "Reschedule" and choose a new time slot  
**Then** the appointment should be updated to the new slot  
**And** the old slot should be released for other patients  
**And** I should receive a reschedule confirmation

**When** I select "Cancel"  
**Then** the appointment status should change to "Cancelled"  
**And** the slot should be released  
**And** cancellation fee applied if within 24 hours (per policy)  
**And** I should receive a cancellation confirmation

## US-2.1 — Set weekly availability

**Given** I am a doctor in my schedule settings  
**When** I set my recurring weekly availability (e.g., Mon–Fri 9am–5pm)  
**Then** patients should only be able to book within those hours  
**And** I can add exceptions (e.g., vacation, conference) that block specific dates

**Additional AC:**
- Availability applies to all locations where I practice
- Changes take effect immediately for future bookings
- Existing appointments not affected by availability changes

## US-2.2 — View daily appointment list

**Given** I am a doctor logging in for the day  
**When** I open my appointment dashboard  
**Then** I should see today's appointments sorted by time  
**And** each entry shows patient name, reason, appointment type, and duration  
**And** I can click an appointment to view patient history

**Additional AC:**
- Appointments from all clinic locations where I practice are included
- Status indicators: Scheduled, Arrived, In Progress, Completed, No-Show, Cancelled

## US-2.3 — Mark completed or no-show

**Given** I am a doctor after a patient visit  
**When** I mark the appointment as "Completed"  
**Then** the status should update to "Completed"  
**And** I can add visit notes and diagnosis  
**And** the slot is freed for reporting

**When** a patient does not arrive within 15 minutes of slot time  
**Then** I can mark as "No-Show"  
**And** the no-show is logged against the patient record  
**And** a follow-up task may be created

## US-3.1 — Appointment reminders (SMS/email)

**Given** a patient has an upcoming appointment  
**When** it is 24 hours and 2 hours before the appointment  
**Then** the patient should receive a reminder via their preferred channel (SMS and/or email)  
**And** the reminder includes date, time, location, doctor, and prep instructions

**Additional AC:**
- Patient can opt out of SMS or email reminders
- Failed deliveries retried up to 3 times
- Delivery status logged for audit

## US-3.2 — Confirm appointment from reminder

**Given** I received an appointment reminder  
**When** I click "Confirm" in the reminder  
**Then** my appointment status should update to "Confirmed"  
**And** the doctor should see the confirmed status  
**And** I should receive a confirmation receipt

**Additional AC:**
- Confirmation link expires 2 hours before appointment
- Unconfirmed appointments remain "Scheduled" (not auto-cancelled)

## US-3.3 — Receptionist check-in list

**Given** I am a receptionist at the clinic  
**When** I view today's check-in list  
**Then** I should see all appointments for today sorted by time  
**And** each entry shows arrival status (Scheduled / Arrived / In-Process / Completed)  
**And** I can check a patient in with one click

**Additional AC:**
- Check-in updates status and notifies the doctor
- Estimated wait time shown based on current queue
- Room assignment optional but supported

## US-4.1 — Manage locations and departments

**Given** I am a hospital administrator  
**When** I add a new clinic location or department  
**Then** it should be available for doctor assignment and patient booking  
**And** I can edit or deactivate locations/departments

**Additional AC:**
- Deactivated locations cannot accept new bookings
- Existing appointments at deactivated locations are preserved

## US-4.2 — Set slot duration and buffer times

**Given** I am an administrator configuring scheduling rules  
**When** I set slot duration per department (e.g., 15 min general, 30 min specialist)  
**And** set buffer time between appointments (e.g., 5 min)  
**Then** the booking system should generate slots accordingly  
**And** doctors should have buffer between back-to-back appointments

## US-4.3 — Clinic utilization reports

**Given** I am an administrator  
**When** I view the utilization dashboard  
**Then** I should see bookings per day, no-show rate, room utilization, and doctor utilization  
**And** I can filter by date range, location, and department

**Additional AC:**
- Report exportable to CSV/PDF
- Data refreshed daily (or real-time option)

## US-5.1 — Check patient in

**Given** a patient arrives for their appointment  
**When** the receptionist checks them in  
**Then** the appointment status should change to "Arrived"  
**And** the assigned doctor should be notified  
**And** an exam room should be assigned

**Additional AC:**
- Check-in time recorded for wait-time analytics
- Patient can check in via self-service kiosk (V2)

## US-5.2 — Walk-in waitlist

**Given** a patient walks in without an appointment  
**When** the receptionist adds them to the waitlist  
**Then** the walk-in should be recorded with arrival time and reason  
**And** the system should estimate wait time based on current queue  
**And** the patient should be notified when a slot becomes available  
**And** the waitlist entry can be converted to a booked appointment
