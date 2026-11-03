# Set 1 — Online Grocery: Prioritisation and Estimation

## Prioritisation Method: MoSCoW

| Priority | Definition |
|----------|------------|
| **M**ust | Critical for MVP; product cannot launch without it. |
| **S**hould | Important but not blocking; should be included if possible. |
| **C**ould | Nice to have; included if time permits. |
| **W**on't | Explicitly out of scope for this release. |

## Story Prioritisation

| Story ID | Story Title | Priority | Rationale |
|----------|-------------|----------|-----------|
| US-1.1 | Search products by keyword | M | Core discovery feature; customers must find products. |
| US-1.2 | Filter by category | M | Essential for browsing large catalogs. |
| US-1.3 | Product detail page | M | Customers need product info before purchasing. |
| US-1.4 | Sort by price | C | Helpful but not critical for launch. |
| US-2.1 | Add to cart & adjust quantity | M | Core purchasing flow. |
| US-2.2 | Apply discount coupon | S | Drives conversions but not launch-blocking. |
| US-2.3 | Select delivery slot | M | Required for scheduled delivery promise. |
| US-2.4 | Secure payment | M | Core revenue feature; must work. |
| US-3.1 | View order history | S | Important for repeat customers. |
| US-3.2 | Real-time delivery tracking | C | Enhances experience; V2 feature. |
| US-3.3 | Contact support | S | Needed for issue resolution post-launch. |
| US-4.1 | Register account | M | Required for personalized experience and orders. |
| US-4.2 | Login with remember me | M | Core authentication flow. |
| US-4.3 | Save multiple addresses | S | Convenience feature for V2. |
| US-5.1 | Low-stock alerts | M | Prevents selling out-of-stock items. |
| US-5.2 | Mark order as delivered | M | Required for delivery completion flow. |

## Estimation Method: Story Points (Fibonacci)

Scale: 1, 2, 3, 5, 8, 13, 20, 40, 100

| Story ID | Story Title | Story Points | Estimation Notes |
|----------|-------------|--------------|------------------|
| US-1.1 | Search products by keyword | 5 | Requires backend search index + frontend UI. |
| US-1.2 | Filter by category | 3 | Straightforward filtering logic. |
| US-1.3 | Product detail page | 3 | Mostly display; data from existing API. |
| US-1.4 | Sort by price | 2 | Simple sorting on existing data. |
| US-2.1 | Add to cart & adjust quantity | 5 | Cart persistence + quantity logic. |
| US-2.2 | Apply discount coupon | 5 | Coupon validation + discount calculation. |
| US-2.3 | Select delivery slot | 8 | Slot availability logic + date picker UI. |
| US-2.4 | Secure payment | 13 | Payment gateway integration + security compliance. |
| US-3.1 | View order history | 3 | Read-only list from order service. |
| US-3.2 | Real-time delivery tracking | 13 | Requires driver app + real-time updates (WebSocket). |
| US-3.3 | Contact support | 5 | Ticket creation + email notification. |
| US-4.1 | Register account | 5 | Validation + verification email. |
| US-4.2 | Login with remember me | 3 | Authentication + session management. |
| US-4.3 | Save multiple addresses | 3 | Address CRUD + default selection. |
| US-5.1 | Low-stock alerts | 5 | Threshold monitoring + email alert. |
| US-5.2 | Mark order as delivered | 3 | Status update + customer notification. |

## Sprint Planning Projection

Assuming a team velocity of 30 story points per 2-week sprint:

| Sprint | Stories | Total Points | Focus |
|--------|---------|--------------|-------|
| Sprint 1 | US-1.1, US-1.2, US-1.3, US-2.1, US-4.1, US-4.2 | 25 | Core catalog, cart, auth |
| Sprint 2 | US-2.3, US-2.4, US-5.1, US-5.2, US-1.4 | 31 | Checkout, payment, fulfillment |
| Sprint 3 | US-3.1, US-3.3, US-2.2, US-4.3, US-3.2 (partial) | 28 | Order management, support, tracking |

## Estimation Assumptions

- Team of 4 developers + 1 QA + 1 PO + 1 SM
- Story points reflect complexity, risk, and effort (not just hours)
- Planning poker used for consensus estimation
- Stories > 8 points must be split before sprint commitment
