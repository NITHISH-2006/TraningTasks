# Set 3 — Hospital Appointment: Definition of Ready (DoR) and Definition of Done (DoD)

## Definition of Ready (DoR)

A user story is **Ready** for sprint inclusion only when ALL are true:

- [ ] Story written in `As a…, I want…, So that…` format
- [ ] Story meets all INVEST criteria
- [ ] Acceptance Criteria written in Given/When/Then format
- [ ] Story estimated with story points
- [ ] HIPAA/compliance review completed (for patient data stories)
- [ ] Dependencies identified and resolved
- [ ] UI/UX designs available (for booking flow, doctor dashboard)
- [ ] PO available for domain questions (clinical workflows, scheduling rules)

**DoR Example — US-1.3 (Book Appointment Online):**
- ✅ HIPAA review: patient data encryption, consent for reminders
- ✅ Dependencies: requires US-1.2 (availability) and US-4.2 (slot rules)
- ✅ Estimated at 8 points
- ✅ AC covers booking confirmation and slot locking

## Definition of Done (DoD)

A story is **Done** only when ALL are true:

- [ ] Code complete and meets coding standards
- [ ] Peer-reviewed via pull request (2 approvals)
- [ ] Unit tests passing (>80% coverage on changed code)
- [ ] QA tested against all Acceptance Criteria
- [ ] No critical/high bugs open
- [ ] HIPAA/compliance sign-off (where PHI is involved)
- [ ] Merged to `main` branch
- [ ] Deployed to staging/UAT
- [ ] Documentation updated (user guide, admin procedures)
- [ ] PO accepted during sprint demo

**DoD Example — US-5.1 (Check Patient In):**
- ✅ Check-in action updates status and notifies doctor
- ✅ QA verified check-in flow and room assignment
- ✅ No critical bugs
- ✅ Merged to `main`, deployed to staging
- ✅ PO accepted in sprint demo

## DoR vs DoD Summary

| Aspect | Definition of Ready (DoR) | Definition of Done (DoD) |
|--------|---------------------------|--------------------------|
| Purpose | Entry criteria — can we start? | Exit criteria — is it complete? |
| Applied before | Sprint planning / story pickup | Story completion / sprint review |
| Who agrees | PO + Team | Team + PO + Compliance (if PHI) |
| If not met | Story stays in product backlog | Story not counted; carried to next sprint |
