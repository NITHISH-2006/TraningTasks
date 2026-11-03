# Set 1 — Online Grocery: INVEST Review

## INVEST Criteria

| Criterion | Definition |
|-----------|------------|
| **I**ndependent | Story can be developed and delivered without depending on another story. |
| **N**egotiable | Story is not a fixed contract; details emerge through conversation. |
| **V**aluable | Story delivers clear value to the user or business. |
| **E**stimable | Team can estimate the story's size/effort. |
| **S**mall | Story fits within a single sprint. |
| **T**estable | Story has clear acceptance criteria to verify completion. |

## Story-by-Story Review

| Story ID | Story Title | I | N | V | E | S | T | Verdict | Refinement Notes |
|----------|-------------|---|---|---|---|---|---|---------|------------------|
| US-1.1 | Search products by keyword | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | Ready | None needed. |
| US-1.2 | Filter by category | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | Ready | None needed. |
| US-1.3 | Product detail page | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | Ready | None needed. |
| US-1.4 | Sort by price | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | Ready | None needed. |
| US-2.1 | Add to cart & adjust quantity | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | Ready | None needed. |
| US-2.2 | Apply discount coupon | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | Ready | None needed. |
| US-2.3 | Select delivery slot | ✅ | ✅ | ✅ | ✅ | ⚠️ | ✅ | Needs refinement | Split into "view slots" and "reserve slot" to keep small. |
| US-2.4 | Secure payment | ⚠️ | ✅ | ✅ | ✅ | ⚠️ | ✅ | Needs refinement | Depends on payment gateway integration; split into "integrate gateway" and "checkout payment flow." |
| US-3.1 | View order history | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | Ready | None needed. |
| US-3.2 | Real-time delivery tracking | ⚠️ | ✅ | ✅ | ⚠️ | ⚠️ | ✅ | Needs refinement | Requires driver app integration; split into basic status updates and live map tracking. |
| US-3.3 | Contact support | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | Ready | None needed. |
| US-4.1 | Register account | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | Ready | None needed. |
| US-4.2 | Login with remember me | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | Ready | None needed. |
| US-4.3 | Save multiple addresses | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | Ready | None needed. |
| US-5.1 | Low-stock alerts | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | Ready | None needed. |
| US-5.2 | Mark order as delivered | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | Ready | None needed. |

## Refinement Summary

- **US-2.3** → Split into US-2.3a (view available delivery slots) and US-2.3b (reserve a delivery slot).
- **US-2.4** → Split into US-2.4a (integrate payment gateway API) and US-2.4b (checkout payment flow UI).
- **US-3.2** → Split into US-3.2a (order status updates: prepared, out-for-delivery, delivered) and US-3.2b (live driver map tracking).

After splitting, all stories meet the full INVEST criteria.
