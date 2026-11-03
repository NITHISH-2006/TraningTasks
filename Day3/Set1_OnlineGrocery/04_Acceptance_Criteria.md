# Set 1 — Online Grocery: Acceptance Criteria

## US-1.1 — Search products by keyword

**Given** I am on the homepage  
**When** I type "milk" into the search bar and press Enter  
**Then** I should see a list of products containing "milk" in the name or description  
**And** each result should show product name, price, image, and stock status  
**And** if no products match, I should see a "No results found" message

**Additional AC:**
- Search supports partial matches (e.g., "bre" returns "bread", "breakfast cereal")
- Search is case-insensitive
- Search results page loads within 2 seconds

## US-1.2 — Filter products by category

**Given** I am viewing search results or category page  
**When** I select the "Dairy" filter checkbox  
**Then** only dairy products should be displayed  
**And** the filter count should update to show the number of applied filters  
**And** I can combine multiple category filters (e.g., Dairy + Produce)

**Additional AC:**
- Clearing all filters returns to full product list
- Filter state persists when navigating between product pages

## US-1.3 — View product detail page

**Given** I click on a product from search results  
**When** the product detail page loads  
**Then** I should see the product name, price, image, description, nutrition information, and stock status  
**And** I should see an "Add to Cart" button if the product is in stock  
**And** I should see an "Out of Stock" badge if inventory is zero

## US-1.4 — Sort products by price

**Given** I am viewing a list of products  
**When** I select "Price: Low to High" sort option  
**Then** products should be ordered ascending by price  
**And** the sort indicator should show the active sort direction

**Additional AC:**
- Sorting applies to the current filtered results
- Sort preference persists across page navigation within the same session

## US-2.1 — Add products to cart & adjust quantity

**Given** I am on a product detail page  
**When** I click "Add to Cart"  
**Then** the item should be added to my shopping cart  
**And** the cart icon should show the updated item count  
**And** I should see a confirmation toast/message

**When** I adjust the quantity of an item in the cart  
**Then** the line total should update automatically  
**And** the cart total should reflect the new quantity

**Additional AC:**
- Cart persists across browser sessions (local storage)
- Maximum quantity per item is capped at 99

## US-2.2 — Apply discount coupon

**Given** I am at checkout with items in my cart  
**When** I enter a valid coupon code and click "Apply"  
**Then** the discount should be applied to the order total  
**And** the coupon should appear in the order summary with the discount amount

**When** I enter an invalid coupon code  
**Then** I should see an error message: "Invalid coupon code"

**Additional AC:**
- One coupon per order
- Coupon expiry dates are validated

## US-2.3 — Select delivery date & time slot

**Given** I am at the delivery selection step  
**When** I choose a delivery date  
**Then** I should see available time slots for that date  
**And** I can select one time slot for my delivery

**Additional AC:**
- Slots are shown in 1-hour windows
- Past dates and fully booked slots are not selectable
- Selected slot is stored with the order

## US-2.4 — Secure payment

**Given** I have entered my delivery details and selected a time slot  
**When** I enter payment details and click "Place Order"  
**Then** the payment should be processed through the payment gateway  
**And** on success, I should see an order confirmation page with order number  
**And** an order confirmation email should be sent to my email address

**When** payment fails  
**Then** I should see an error message and be prompted to retry or use another payment method

**Additional AC:**
- Payment data is encrypted (PCI-DSS compliant)
- No card details are stored on our servers

## US-3.1 — View order history

**Given** I am logged into my account  
**When** I navigate to "My Orders"  
**Then** I should see a list of my past orders with date, total, and status  
**And** I can click "Reorder" to add past items to my cart

**Additional AC:**
- Orders are sorted by date (newest first)
- Pagination for more than 10 orders

## US-3.2 — Track delivery in real time

**Given** I have an order with status "Out for Delivery"  
**When** I open the order tracking page  
**Then** I should see the current order status  
**And** I should see an estimated delivery time window

**Additional AC:**
- Status updates: Prepared → Out for Delivery → Delivered
- Customer receives notification when status changes

## US-3.3 — Contact support about delivery issue

**Given** I have an order with a delivery problem  
**When** I submit a support request with issue type and description  
**Then** a support ticket should be created  
**And** I should receive a confirmation email with ticket number

**Additional AC:**
- Ticket is assigned to a support agent within 4 business hours
- Customer can view ticket status in "My Support Tickets"

## US-4.1 — Register account

**Given** I am on the registration page  
**When** I enter a valid email, strong password, and click "Register"  
**Then** my account should be created  
**And** a verification email should be sent to my email address

**When** I enter an email that is already registered  
**Then** I should see an error: "Email already in use"

**Additional AC:**
- Password must be at least 8 characters with one number and one special character
- Email format is validated

## US-4.2 — Login with remember me

**Given** I am on the login page  
**When** I enter valid credentials and check "Remember Me"  
**Then** I should be logged in and remain signed on subsequent visits

**When** I enter invalid credentials  
**Then** I should see an error: "Invalid email or password"

## US-4.3 — Save multiple delivery addresses

**Given** I am in my account settings  
**When** I add a new delivery address  
**Then** the address should be saved to my address book  
**And** I can set it as my default address

**Additional AC:**
- Address form validates postal code format
- At least one address must be marked as default

## US-5.1 — Low-stock alerts

**Given** I am a warehouse associate on the inventory dashboard  
**When** a product's stock falls below the reorder threshold  
**Then** the product should be flagged as "Low Stock"  
**And** an alert email should be sent to the purchasing team

## US-5.2 — Mark order as delivered

**Given** I am a delivery driver with the driver app  
**When** I complete a delivery and mark it as "Delivered"  
**Then** the order status should update to "Delivered"  
**And** the customer should receive a delivery confirmation notification  
**And** proof of delivery (photo or signature) should be captured
