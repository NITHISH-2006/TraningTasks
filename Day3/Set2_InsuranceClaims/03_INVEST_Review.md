# Set 2 — Insurance Claims: INVEST Review

## INVEST Criteria

| Criterion | Definition |
|-----------|------------|
| **I**ndependent | Story can be developed without depending on another story. |
| **N**egotiable | Details emerge through conversation, not fixed contract. |
| **V**aluable | Delivers clear value to user or business. |
| **E**stimable | Team can estimate size/effort. |
| **S**mall | Fits within a single sprint. |
| **T**estable | Clear acceptance criteria exist for verification. |

## Story-by-Story Review

| Story ID | Story Title | I | N | V | E | S | T | Verdict | Refinement Notes |
|----------|-------------|---|---|---|---|---|---|---------|------------------|
| US-1.1 | Submit claim online | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | Ready | None. |
| US-1.2 | Upload documents | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | Ready | None. |
| US-1.3 | Save claim draft | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | Ready | None. |
| US-2.1 | View assigned claims | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | Ready | None. |
| US-2.2 | Record damage assessment | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | Ready | None. |
| US-2.3 | Request additional info | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | Ready | None. |
| US-3.1 | Approve/reject claim | ⚠️ | ✅ | ✅ | ✅ | ✅ | ✅ | Needs refinement | Depends on US-2.2 assessment completion; note dependency. |
| US-3.2 | Initiate settlement payment | ⚠️ | ✅ | ✅ | ✅ | ✅ | ✅ | Needs refinement | Depends on US-3.1 approval; payment gateway integration required. |
| US-3.3 | Receive settlement breakdown | ⚠️ | ✅ | ✅ | ✅ | ✅ | ✅ | Needs refinement | Depends on US-3.2 payment initiation. |
| US-4.1 | Track claim status | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | Ready | None. |
| US-4.2 | Email/SMS notifications | ⚠️ | ✅ | ✅ | ✅ | ✅ | ✅ | Needs refinement | Depends on notification service integration; split into preference + delivery. |
| US-4.3 | Workload & SLA reports | ✅ | ✅ | ✅ | ✅ | ⚠️ | ✅ | Needs refinement | Complex reporting; split into basic dashboard and detailed SLA report. |
| US-5.1 | Fraud detection flags | ⚠️ | ✅ | ✅ | ⚠️ | ✅ | ✅ | Needs refinement | Rules engine complexity; spike needed to estimate accurately. |
| US-5.2 | Compliance audit log | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | Ready | None. |

## Refinement Summary

- **US-3.1** → Mark dependency on US-2.2 (assessment must exist before decision).
- **US-3.2** → Mark dependency on US-3.1 (approval precedes payment).
- **US-3.3** → Mark dependency on US-3.2 (payment precedes breakdown).
- **US-4.2** → Split into US-4.2a (notification preferences) and US-4.2b (email/SMS delivery).
- **US-4.3** → Split into US-4.3a (basic workload dashboard) and US-4.3b (detailed SLA compliance report).
- **US-5.1** → Add a spike story to research rules engine options before estimating.

After refinement, all stories meet full INVEST criteria.
