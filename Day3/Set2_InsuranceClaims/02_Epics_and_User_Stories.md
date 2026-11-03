# Set 2 — Insurance Claims: Epics and User Stories

## Epics

| Epic ID | Epic Name | Description |
|---------|-----------|-------------|
| E1 | Claim Submission | Policyholders submit claims online with details and supporting documents. |
| E2 | Claim Assessment | Adjusters review, assess damage, determine liability, and estimate payout. |
| E3 | Claim Decision & Settlement | Approve/reject claims, calculate settlement, and disburse payment. |
| E4 | Claim Tracking & Notifications | Policyholders and staff track claim status and receive updates. |
| E5 | Fraud Detection & Compliance | Automated and manual fraud checks; regulatory compliance validation. |

## User Stories

### Epic E1 — Claim Submission

| ID | User Story | Acceptance Criteria Summary |
|----|------------|-----------------------------|
| US-1.1 | As a policyholder, I want to submit a claim online with incident details, so that I can start the claims process without calling. | Claim form captures date, location, description, policy number; submission confirmed with claim ID. |
| US-1.2 | As a policyholder, I want to upload photos and documents as evidence, so that the adjuster can assess damage. | Supports PDF, JPG, PNG up to 10MB; multiple files; virus scan on upload. |
| US-1.3 | As a policyholder, I want to save a claim as draft and complete it later, so that I don't lose information. | Draft saved automatically; accessible from "My Claims" for 30 days. |

### Epic E2 — Claim Assessment

| ID | User Story | Acceptance Criteria Summary |
|----|------------|-----------------------------|
| US-2.1 | As an adjuster, I want to view all submitted claims assigned to me, so that I can prioritise my workload. | Dashboard shows claims sorted by date/severity; filter by status. |
| US-2.2 | As an adjuster, I want to record damage assessment and estimated repair cost, so that the claim can be valued. | Assessment form with line items; total calculated; supporting notes. |
| US-2.3 | As an adjuster, I want to request additional information from the policyholder, so that I can make an accurate decision. | Request sent to policyholder; claim status changes to "Pending Info"; notification emailed. |

### Epic E3 — Claim Decision & Settlement

| ID | User Story | Acceptance Criteria Summary |
|----|------------|-----------------------------|
| US-3.1 | As a claims manager, I want to approve or reject a claim based on assessment, so that valid claims are paid and fraud is prevented. | Approve/reject with reason; decision logged; policyholder notified. |
| US-3.2 | As a finance officer, I want to initiate settlement payment to the policyholder, so that approved claims are paid. | Payment generated; integrated with banking gateway; payment reference stored. |
| US-3.3 | As a policyholder, I want to receive my settlement amount and breakdown, so that I understand how the payout was calculated. | Settlement letter shows itemized calculation, deductions, and net payout. |

### Epic E4 — Claim Tracking & Notifications

| ID | User Story | Acceptance Criteria Summary |
|----|------------|-----------------------------|
| US-4.1 | As a policyholder, I want to track my claim status online, so that I know where my claim is in the process. | Status timeline: Submitted → Under Review → Assessed → Decision → Paid. |
| US-4.2 | As a policyholder, I want to receive email/SMS notifications when my claim status changes, so that I stay informed. | Triggered on status change; opt-out option; delivery receipt logged. |
| US-4.3 | As a claims manager, I want to view team workload and SLA reports, so that I can balance assignments and meet regulatory deadlines. | Report shows claims per adjuster, average days to decision, SLA breaches. |

### Epic E5 — Fraud Detection & Compliance

| ID | User Story | Acceptance Criteria Summary |
|----|------------|-----------------------------|
| US-5.1 | As a fraud analyst, I want claims flagged for potential fraud based on rules, so that suspicious claims get extra review. | Rules engine flags duplicates, high amounts, inconsistent details; flagged claims routed to investigation queue. |
| US-5.2 | As a compliance officer, I want claims data retained and auditable per regulations, so that we pass audits. | Audit log of all claim actions; data retention policy enforced; exportable reports. |
