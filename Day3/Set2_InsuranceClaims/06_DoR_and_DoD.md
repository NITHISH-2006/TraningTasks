# Set 2 — Insurance Claims: Definition of Ready (DoR) and Definition of Done (DoD)

## Definition of Ready (DoR)

A user story is **Ready** for sprint inclusion only when ALL are true:

- [ ] Story written in `As a…, I want…, So that…` format
- [ ] Story meets all INVEST criteria
- [ ] Acceptance Criteria written in Given/When/Then format
- [ ] Story estimated with story points
- [ ] Dependencies identified (e.g., US-3.1 depends on US-2.2)
- [ ] Regulatory/compliance requirements reviewed (for claims, fraud, audit stories)
- [ ] UI mockups available (for claim forms, dashboards)
- [ ] API contracts defined (for payment gateway, notification service)
- [ ] PO available for domain questions (adjuster workflows, settlement rules)

**DoR Example — US-3.2 (Initiate Settlement Payment):**
- ✅ Dependencies documented: requires US-3.1 approval + banking gateway API
- ✅ Compliance reviewed: PCI-DSS, audit logging
- ✅ Estimated at 8 points
- ✅ AC covers success and failure scenarios

## Definition of Done (DoD)

A story is **Done** only when ALL are true:

- [ ] Code complete and meets coding standards
- [ ] Peer-reviewed via pull request (2 approvals)
- [ ] Unit tests passing (>80% coverage on changed code)
- [ ] QA tested against all Acceptance Criteria
- [ ] No critical/high bugs open
- [ ] Regulatory/compliance sign-off (where applicable)
- [ ] Merged to `main` branch
- [ ] Deployed to staging/UAT
- [ ] Documentation updated (claim handling procedures, API docs)
- [ ] PO accepted during sprint demo

**DoD Example — US-5.2 (Compliance Audit Log):**
- ✅ Immutable audit log implemented
- ✅ Compliance officer signed off on retention policy (7 years)
- ✅ QA verified log immutability and export
- ✅ No critical bugs
- ✅ Merged to `main`, deployed to staging
- ✅ PO accepted in sprint review

## DoR vs DoD Summary

| Aspect | Definition of Ready (DoR) | Definition of Done (DoD) |
|--------|---------------------------|--------------------------|
| Purpose | Entry criteria — can we start? | Exit criteria — is it complete? |
| Applied before | Sprint planning / story pickup | Story completion / sprint review |
| Who agrees | PO + Team | Team + PO + Compliance (if applicable) |
| If not met | Story stays in product backlog | Story not counted; carried to next sprint |
