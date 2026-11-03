# Set 1 — Online Grocery: Definition of Ready (DoR) and Definition of Done (DoD)

## Definition of Ready (DoR)

A user story is considered **Ready** to be pulled into a sprint only when ALL of the following are true:

- [ ] Story is written in `As a…, I want…, So that…` format
- [ ] Story meets all INVEST criteria (Independent, Negotiable, Valuable, Estimable, Small, Testable)
- [ ] Acceptance Criteria are written in Given/When/Then format
- [ ] Story has been estimated with story points (Fibonacci scale)
- [ ] Dependencies are identified and resolved (or tracked)
- [ ] UI/UX designs are available (if applicable)
- [ ] API contracts or technical approach are clarified
- [ ] Story is prioritised (MoSCoW rank assigned)
- [ ] PO is available to answer questions during the sprint

**DoR Example — US-2.4 (Secure Payment):**
- ✅ Written in user story format
- ✅ Split into smaller stories (gateway integration + checkout flow)
- ✅ AC written with success/failure scenarios
- ✅ Estimated at 13 points
- ✅ Payment gateway API documentation reviewed
- ✅ PO available for edge-case questions

## Definition of Done (DoD)

A user story is considered **Done** only when ALL of the following are true:

- [ ] Code is complete and meets coding standards
- [ ] Code has been peer-reviewed (pull request approved)
- [ ] Unit tests are written and passing (>80% coverage for changed code)
- [ ] QA has tested against all Acceptance Criteria
- [ ] No critical/high-priority bugs remain open
- [ ] Code is merged to the main branch
- [ ] Feature is deployed to staging environment
- [ ] Documentation updated (API docs, user guide if needed)
- [ ] PO has accepted the story during sprint review/demo

**DoD Example — US-1.1 (Search Products):**
- ✅ Search backend implemented with indexing
- ✅ PR approved by 2 peers
- ✅ Unit tests at 85% coverage
- ✅ QA verified partial match, case-insensitivity, empty results
- ✅ Zero critical bugs
- ✅ Merged to `main`
- ✅ Deployed to staging
- ✅ API documentation updated
- ✅ PO accepted in sprint demo

## DoR vs DoD Summary

| Aspect | Definition of Ready (DoR) | Definition of Done (DoD) |
|--------|---------------------------|--------------------------|
| Purpose | Entry criteria for sprint | Exit criteria for story completion |
| Applied to | Product backlog items before sprint planning | Each story within a sprint |
| Owner | PO + Team agree | Team + PO accept |
| Key question | "Can we start this story?" | "Is this story truly complete?" |
| Consequence of not met | Story stays in product backlog | Story not counted as complete; carried over |
