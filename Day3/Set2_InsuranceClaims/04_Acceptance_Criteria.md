# Set 2 — Insurance Claims: Acceptance Criteria

## US-1.1 — Submit claim online

**Given** I am a logged-in policyholder  
**When** I complete the claim form with incident date, location, description, and policy number, then click "Submit"  
**Then** a claim should be created with a unique claim ID  
**And** the claim status should be "Submitted"  
**And** I should see a confirmation page with my claim ID and next steps  
**And** a confirmation email should be sent to my registered email

**Additional AC:**
- All required fields validated (incident date cannot be in the future)
- Policy number validated against active policies
- Claim form saves progress if user navigates away (auto-draft)

## US-1.2 — Upload documents

**Given** I am on the claim submission or claim detail page  
**When** I upload a photo or document (PDF, JPG, PNG, max 10MB each)  
**Then** the file should be attached to my claim  
**And** I should see the file listed with name, size, and upload time  
**And** I can remove an uploaded file before final submission

**Additional AC:**
- Virus scan performed on all uploads; infected files rejected
- Maximum 10 files per claim
- File descriptions optional but supported

## US-1.3 — Save claim as draft

**Given** I am filling out a claim form  
**When** I click "Save as Draft" or navigate away without submitting  
**Then** my entered data should be saved automatically  
**And** I can resume the claim from "My Claims" within 30 days  
**And** drafts older than 30 days are purged

## US-2.1 — View assigned claims

**Given** I am a claims adjuster logged into the system  
**When** I open my adjuster dashboard  
**Then** I should see a list of claims assigned to me  
**And** claims are sorted by submission date (oldest first) or severity  
**And** I can filter by status (Submitted, Under Review, Assessed, Pending Info)

**Additional AC:**
- Each claim row shows claim ID, policyholder name, date submitted, and estimated value
- Clicking a claim opens the full claim detail view

## US-2.2 — Record damage assessment

**Given** I am an adjuster viewing a claim in "Under Review" status  
**When** I complete the damage assessment form with line items and estimated repair cost  
**Then** the total estimated cost should be calculated automatically  
**And** the claim status should change to "Assessed"  
**And** my assessment notes should be saved with timestamp

**Additional AC:**
- Assessment can be saved as draft before final submission
- Line items support category (parts, labor, etc.), quantity, unit price

## US-2.3 — Request additional information

**Given** I am an adjuster reviewing a claim that needs more details  
**When** I submit an information request with specific questions  
**Then** the claim status should change to "Pending Info"  
**And** the policyholder should receive a notification with the request  
**And** the request should be logged with date and adjuster name

## US-3.1 — Approve or reject claim

**Given** I am a claims manager reviewing an assessed claim  
**When** I select "Approve" or "Reject" with a reason  
**Then** the claim status should update to "Approved" or "Rejected"  
**And** the decision and reason should be logged with timestamp and manager ID  
**And** the policyholder should be notified of the decision

**Additional AC:**
- Rejection requires a reason (cannot be blank)
- Approval of claims above $10,000 requires secondary manager approval

## US-3.2 — Initiate settlement payment

**Given** I am a finance officer with an approved claim  
**When** I initiate payment with the approved settlement amount  
**Then** a payment record should be created with status "Processing"  
**And** the claim status should change to "Payment Initiated"  
**And** a payment reference number should be generated

**Additional AC:**
- Payment integrated with banking gateway
- Payment details (amount, payee, reference) stored for audit

## US-3.3 — Receive settlement breakdown

**Given** I am a policyholder with an approved and paid claim  
**When** I view my claim detail page  
**Then** I should see an itemized settlement breakdown (estimated cost, deductible, depreciation, net payout)  
**And** I can download a settlement letter as PDF

**Additional AC:**
- Breakdown shows how the final amount was calculated
- Settlement letter includes claim ID, date, and payment reference

## US-4.1 — Track claim status

**Given** I am a policyholder viewing "My Claims"  
**When** I click on a claim  
**Then** I should see a status timeline (Submitted → Under Review → Assessed → Decision → Paid/Rejected)  
**And** the current status should be highlighted  
**And** key dates (submitted, assessed, decided, paid) should be shown

## US-4.2 — Email/SMS notifications

**Given** a claim status changes  
**When** the status transition occurs  
**Then** the policyholder should receive a notification via their preferred channel (email or SMS)  
**And** the notification should include claim ID and new status  
**And** notification delivery should be logged

**Additional AC:**
- Policyholder can opt out of SMS notifications
- Failed notifications retried up to 3 times

## US-4.3 — Workload & SLA reports

**Given** I am a claims manager  
**When** I view the reports dashboard  
**Then** I should see claims per adjuster, average days to decision, and SLA breach count  
**And** I can filter by date range and claim type

**Additional AC:**
- SLA: standard claims decided within 7 business days
- Report exportable to CSV/PDF

## US-5.1 — Fraud detection flags

**Given** a claim is submitted or updated  
**When** fraud rules are evaluated (duplicate claims, amount anomalies, inconsistent details)  
**Then** suspicious claims should be flagged with a risk score  
**And** flagged claims should be routed to the investigation queue  
**And** the fraud analyst should be notified

**Additional AC:**
- Rules configurable by compliance team
- False positive override option with reason

## US-5.2 — Compliance audit log

**Given** any action is taken on a claim (submit, assess, decide, pay, comment)  
**When** the action occurs  
**Then** an audit log entry should be created (user, action, timestamp, old/new values)  
**And** audit logs should be immutable and retained per regulatory requirements (7 years)

**Additional AC:**
- Audit logs exportable for regulatory audits
- Access to audit logs restricted to compliance and audit roles
