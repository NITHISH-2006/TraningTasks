# Set 2 — Insurance Claims: Estimation

## Estimation Method: Story Points (Fibonacci)

Scale: 1, 2, 3, 5, 8, 13, 20, 40, 100

| Story ID | Story Title | Story Points | Estimation Notes |
|----------|-------------|--------------|------------------|
| US-1.1 | Submit claim online | 5 | Form + validation + confirmation email. |
| US-1.2 | Upload documents | 5 | File storage, virus scan, UI. |
| US-1.3 | Save claim draft | 3 | Auto-save + resume logic. |
| US-2.1 | View assigned claims | 3 | Dashboard + filtering. |
| US-2.2 | Record damage assessment | 5 | Line items + calculation + status change. |
| US-2.3 | Request additional info | 3 | Request form + notification. |
| US-3.1 | Approve/reject claim | 5 | Decision logic + dual approval for high value. |
| US-3.2 | Initiate settlement payment | 8 | Banking gateway integration + payment record. |
| US-3.3 | Receive settlement breakdown | 5 | Itemized calculation + PDF generation. |
| US-4.1 | Track claim status | 3 | Status timeline UI. |
| US-4.2 | Email/SMS notifications | 8 | Notification service + preferences + retry logic. |
| US-4.3 | Workload & SLA reports | 8 | Reporting queries + dashboard + export. |
| US-5.1 | Fraud detection flags | 13 | Rules engine + investigation queue + spike needed. |
| US-5.2 | Compliance audit log | 5 | Immutable logging + retention + export. |

## Estimation Assumptions

- Team: 3 developers, 1 QA, 1 PO, 1 SM, plus part-time compliance officer
- US-5.1 requires a technical spike (3 points) before final estimation due to rules engine uncertainty
- Regulatory/compliance stories require review by compliance officer before acceptance
- Story points reflect complexity, risk, and effort — not hours

## Sprint Planning Projection

Assuming team velocity of 25 story points per 2-week sprint:

| Sprint | Stories | Total Points | Focus |
|--------|---------|--------------|-------|
| Sprint 1 | US-1.1, US-1.2, US-1.3, US-2.1, US-4.1 | 21 | Claim submission + tracking |
| Sprint 2 | US-2.2, US-2.3, US-3.1, US-5.2 | 18 | Assessment + decision + audit |
| Sprint 3 | US-3.2, US-3.3, US-4.2, US-5.1 (spike) | 29 | Payment + notifications + fraud |
| Sprint 4 | US-4.3, remaining refinement | 8 | Reports + spillover |

## Estimation Techniques Used

- **Planning Poker:** Team estimates each story independently, then discusses outliers to reach consensus.
- **Relative Estimation:** Stories sized relative to a baseline story (US-1.3 = 3 points).
- **Spike:** Time-boxed research for US-5.1 (fraud rules engine) to reduce estimation uncertainty.
- **Velocity Tracking:** Actual story points completed per sprint used to forecast future capacity.
