# Set 2 — Insurance Claims: Vision and Agile vs Waterfall

## Product Vision

**Vision Statement:**
To build a fast, transparent, and paperless insurance claims processing platform that enables policyholders to submit claims online, track claim status in real time, and receive settlements quickly — while giving adjusters and claims teams the tools to assess, approve, and pay claims efficiently.

**Goals:**
- Reduce average claim processing time from 30 days to 7 days.
- Enable end-to-end digital claim submission with document upload.
- Provide real-time claim status visibility to policyholders.
- Automate simple claim approvals (straight-through processing).
- Ensure compliance with insurance regulations and data privacy laws.

**Target Users:**
- Policyholders filing claims (auto, home, health, etc.)
- Claims adjusters assessing damage and liability
- Claims managers overseeing team workload and SLAs
- Finance team processing settlements
- Customer support handling claim inquiries

## Agile vs Waterfall

| Aspect | Waterfall | Agile (Scrum) |
|--------|-----------|---------------|
| **Requirements** | Gathered comprehensively upfront; fixed before development | Captured iteratively in user stories; refined each sprint |
| **Planning** | Detailed plan for entire project created upfront | High-level roadmap; detailed planning per sprint |
| **Delivery** | Single big-bang release at project end | Working software delivered every sprint (2–4 weeks) |
| **Customer Feedback** | Late — usually during UAT after development | Continuous — sprint reviews and demos |
| **Change Control** | Change requests are expensive and discouraged | Change is expected; backlog refined continuously |
| **Risk Management** | Risks identified late, often during testing | Risks surfaced early through incremental delivery |
| **Team Structure** | Siloed (BA → Dev → QA → Ops) | Cross-functional Scrum team |
| **Documentation** | Heavy upfront documentation (BRD, FRD, TDD) | Lightweight; user stories + acceptance criteria |
| **Testing** | Testing phase at end of project | Continuous testing within each sprint |
| **Suitability** | Fixed requirements, low uncertainty | Evolving requirements, high uncertainty (like insurance claims) |

## Why Agile for Insurance Claims?

Insurance claims processing involves:
- **Regulatory changes** — compliance rules evolve; Agile accommodates regulatory updates mid-project.
- **Stakeholder feedback** — adjusters and policyholders need to see working features early to validate usability.
- **Complex integrations** — payment gateways, fraud detection, document management systems; incremental integration reduces risk.
- **Faster time-to-value** — policyholders benefit from claim submission features sooner rather than waiting for a monolithic release.

## Roles in Insurance Claims Agile Team

| Role | Responsibility |
|------|---------------|
| Product Owner | Defines claim processing vision, prioritises backlog, accepts stories |
| Scrum Master | Facilitates ceremonies, removes blockers (e.g., regulatory approvals) |
| Development Team | Builds claim submission, assessment, and payment features |
| QA Engineer | Validates claim workflows, fraud rules, payment calculations |
| Compliance Officer | Ensures regulatory requirements are embedded in stories |
| Claims Adjuster (SME) | Provides domain expertise on claim assessment rules |
