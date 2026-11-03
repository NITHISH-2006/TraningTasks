# Set 1 — Online Grocery: Epics and User Stories

## Epics

| Epic ID | Epic Name | Description |
|---------|-----------|-------------|
| E1 | Product Catalog & Search | Browse, search, and filter grocery products with categories and details. |
| E2 | Shopping Cart & Checkout | Add/remove items, apply coupons, choose delivery slot, and complete payment. |
| E3 | Order Management & Tracking | View order history, track live delivery, reorder, and request support. |
| E4 | User Account & Profile | Register, login, manage addresses, payment methods, and preferences. |
| E5 | Inventory & Fulfillment | Track stock, manage picking/packing, and update delivery status. |

## User Stories

### Epic E1 — Product Catalog & Search

| ID | User Story | Acceptance Criteria Summary |
|----|------------|-----------------------------|
| US-1.1 | As a customer, I want to search for products by name or keyword, so that I can quickly find what I need. | Search bar returns relevant results; supports partial matches; shows "no results" when empty. |
| US-1.2 | As a customer, I want to filter products by category (dairy, produce, pantry), so that I can browse relevant items. | Category filters narrow results; multiple filters can be combined; filter count shown. |
| US-1.3 | As a customer, I want to view a product detail page with price, image, and description, so that I can make an informed purchase. | Detail page displays name, price, image, description, nutrition info, and stock status. |
| US-1.4 | As a customer, I want to sort products by price (low to high or high to low), so that I can find options within my budget. | Sorting applies to current results; persists across category navigation. |

### Epic E2 — Shopping Cart & Checkout

| ID | User Story | Acceptance Criteria Summary |
|----|------------|-----------------------------|
| US-2.1 | As a customer, I want to add products to my cart and adjust quantities, so that I can control what I purchase. | Add/remove works; quantity selector updates line total; cart persists across sessions. |
| US-2.2 | As a customer, I want to apply a discount coupon at checkout, so that I can save money on my order. | Coupon field validates code; discount applied to order total; invalid codes show error. |
| US-2.3 | As a customer, I want to select a delivery date and time slot, so that I can receive groceries when I'm home. | Available slots shown by date; selected slot stored with order; conflicts blocked. |
| US-2.4 | As a customer, I want to pay securely using credit card or digital wallet, so that I can complete my purchase. | Payment processed via gateway; success/failure shown; receipt emailed. |

### Epic E3 — Order Management & Tracking

| ID | User Story | Acceptance Criteria Summary |
|----|------------|-----------------------------|
| US-3.1 | As a customer, I want to view my order history, so that I can see past purchases and reorder. | List shows order date, total, status; reorder button adds items to cart. |
| US-3.2 | As a customer, I want to track my delivery in real time, so that I know when it will arrive. | Map shows driver location; estimated arrival updated; status changes (prepared → out-for-delivery → delivered). |
| US-3.3 | As a customer, I want to contact support about a delivery issue, so that I can get a refund or reschedule. | Support ticket created; confirmation email sent; issue assigned to agent. |

### Epic E4 — User Account & Profile

| ID | User Story | Acceptance Criteria Summary |
|----|------------|-----------------------------|
| US-4.1 | As a new user, I want to register an account with email and password, so that I can place orders. | Registration validates email; password strength enforced; verification email sent. |
| US-4.2 | As a returning user, I want to log in and stay signed in, so that I don't re-enter credentials each visit. | Secure login with "remember me"; session persists; logout clears session. |
| US-4.3 | As a customer, I want to save multiple delivery addresses, so that I can ship to home or office. | Address book stores name, street, city, postal code; default address selectable. |

### Epic E5 — Inventory & Fulfillment

| ID | User Story | Acceptance Criteria Summary |
|----|------------|-----------------------------|
| US-5.1 | As a warehouse associate, I want to see low-stock alerts, so that I can restock before items run out. | Dashboard flags items below threshold; alerts email purchaser. |
| US-5.2 | As a delivery driver, I want to mark orders as delivered, so that customers receive confirmation. | Driver app updates status; customer notified; proof of delivery captured. |
