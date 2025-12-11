Nice, now we’re talking ✨
Let’s build some **solid interview-style questions** on **Conditional Aggregation Pivot** using your `de_sql_basics` schema.

Assume:

```sql
USE de_sql_basics;
```

I’ll give you **5 strong questions** where you’ll use:

* `CASE WHEN ... THEN ... END`
* with `COUNT`, `SUM`, `MAX`, `MIN`, `GROUP_CONCAT()`
  to pivot *rows → columns*.

No answers now — pure practice. If you want, I’ll send solutions later.

---

## Q1️⃣ Order Status Pivot (Global Summary Row)

**Goal:** Build a **single-row summary** of order counts by status.

Using the `orders` table, write a query that returns:

| delivered_count | pending_count | cancelled_count | shipped_count |
| --------------- | ------------- | --------------- | ------------- |
| ?               | ?             | ?               | ?             |

**Requirements:**

* Use `COUNT()` with `CASE WHEN` to pivot `status` values (`DELIVERED`, `PENDING`, `CANCELLED`, `SHIPPED`) into **separate columns**.
* Only **one row** in the result.
* Bonus: Add a `total_orders` column as well.

---

## Q2️⃣ Per-Customer Order Status Pivot

**Goal:** Show order distribution per customer across statuses as columns.

For each customer (from `customers` + `orders`), return:

| customer_id | customer_name | delivered_orders | pending_orders | cancelled_orders | shipped_orders |
| ----------- | ------------- | ---------------- | -------------- | ---------------- | -------------- |
| 1           | Raj Verma     | ?                | ?              | ?                | ?              |

**Requirements:**

* `customer_name` = `first_name + ' ' + last_name`
* Use **conditional aggregation** on `orders.status`.
* Only include customers who have placed **at least one order**.
* Sort by `customer_id`.

👉 This is a very common data-engineering interview style question.

---

## Q3️⃣ Payment Method Revenue Pivot (by Date)

**Goal:** Pivot payment methods into columns for **per-day revenue**.

Using `payments` (joined to `orders` if you want the date), build:

| order_date | card_amount | upi_amount | netbanking_amount | total_amount |
| ---------- | ----------- | ---------- | ----------------- | ------------ |
| 2025-02-01 | ?           | ?          | ?                 | ?            |

**Requirements:**

* Group by `order_date` (from `orders.order_date`).
* Use `SUM(CASE WHEN payment_method = 'CARD' THEN amount END)` style expressions.
* Null amounts should be treated as 0 by the aggregate automatically.
* Sort by `order_date` ascending.

Bonus:

* Filter only days where `total_amount > 10000`.

---

## Q4️⃣ Product Quantity Pivot by Order Status

**Goal:** For each product, see **how much quantity** was ordered in each status.

Join `order_items` + `orders` + `products` to get output:

| product_id | product_name        | qty_delivered | qty_pending | qty_cancelled | qty_shipped |
| ---------- | ------------------- | ------------- | ----------- | ------------- | ----------- |
| 1          | Mechanical Keyboard | ?             | ?           | ?             | ?           |

**Requirements:**

* Use `SUM(CASE WHEN o.status = 'DELIVERED' THEN oi.quantity END)` pattern.
* Include **all products that appear in `order_items`**.
* Order result by `product_name`.

This is a classic **pivot + join + aggregation** combo they love in interviews.

---

## Q5️⃣ GROUP_CONCAT Pivot – Orders by Status in a Single Row

**Goal:** Use `GROUP_CONCAT()` to collect **order_ids per status** in one row.

Output:

| delivered_orders | pending_orders | cancelled_orders | shipped_orders |
| ---------------- | -------------- | ---------------- | -------------- |
| 1,3,7,8          | 2,6            | 4                | 5              |

**Requirements:**

* One row only (no GROUP BY customer/date).
* Each column uses `GROUP_CONCAT(CASE WHEN ...)`.
* Inside `GROUP_CONCAT`, sort the ids ascending (if possible).

This trains you to use `GROUP_CONCAT` + conditional aggregation together.

---

If you want a **spicier one** (optional, Q6):

## Q6️⃣ Category-Level Active vs Inactive Products Pivot

Using `products`, create:

| category    | active_products | inactive_products | any_inactive_flag |
| ----------- | --------------- | ----------------- | ----------------- |
| Furniture   | 2               | 0                 | 0                 |
| Electronics | 3               | 0                 | 0                 |
| Accessories | 0               | 1                 | 1                 |

**Requirements:**

* Use `COUNT(CASE WHEN is_active = 1 THEN 1 END)` etc.
* `any_inactive_flag` should be:

  * `1` if that category has any inactive products
  * `0` otherwise
    (Hint: `MAX(CASE WHEN is_active = 0 THEN 1 ELSE 0 END)`)

---

If you want next, I can:

* Give **solutions for all 5/6** (with explanations),
* Or check your attempt for a couple of them and correct / optimize.

You pick:
👉 **“Give solutions”** or **“I’ll try first, then we review”**


Nice, now we’re talking ✨
Let’s build some **solid interview-style questions** on **Conditional Aggregation Pivot** using your `de_sql_basics` schema.

Assume:

```sql
USE de_sql_basics;
```

I’ll give you **5 strong questions** where you’ll use:

* `CASE WHEN ... THEN ... END`
* with `COUNT`, `SUM`, `MAX`, `MIN`, `GROUP_CONCAT()`
  to pivot *rows → columns*.

No answers now — pure practice. If you want, I’ll send solutions later.

---

## Q1️⃣ Order Status Pivot (Global Summary Row)

**Goal:** Build a **single-row summary** of order counts by status.

Using the `orders` table, write a query that returns:

| delivered_count | pending_count | cancelled_count | shipped_count |
| --------------- | ------------- | --------------- | ------------- |
| ?               | ?             | ?               | ?             |

**Requirements:**

* Use `COUNT()` with `CASE WHEN` to pivot `status` values (`DELIVERED`, `PENDING`, `CANCELLED`, `SHIPPED`) into **separate columns**.
* Only **one row** in the result.
* Bonus: Add a `total_orders` column as well.

---

## Q2️⃣ Per-Customer Order Status Pivot

**Goal:** Show order distribution per customer across statuses as columns.

For each customer (from `customers` + `orders`), return:

| customer_id | customer_name | delivered_orders | pending_orders | cancelled_orders | shipped_orders |
| ----------- | ------------- | ---------------- | -------------- | ---------------- | -------------- |
| 1           | Raj Verma     | ?                | ?              | ?                | ?              |

**Requirements:**

* `customer_name` = `first_name + ' ' + last_name`
* Use **conditional aggregation** on `orders.status`.
* Only include customers who have placed **at least one order**.
* Sort by `customer_id`.

👉 This is a very common data-engineering interview style question.

---

## Q3️⃣ Payment Method Revenue Pivot (by Date)

**Goal:** Pivot payment methods into columns for **per-day revenue**.

Using `payments` (joined to `orders` if you want the date), build:

| order_date | card_amount | upi_amount | netbanking_amount | total_amount |
| ---------- | ----------- | ---------- | ----------------- | ------------ |
| 2025-02-01 | ?           | ?          | ?                 | ?            |

**Requirements:**

* Group by `order_date` (from `orders.order_date`).
* Use `SUM(CASE WHEN payment_method = 'CARD' THEN amount END)` style expressions.
* Null amounts should be treated as 0 by the aggregate automatically.
* Sort by `order_date` ascending.

Bonus:

* Filter only days where `total_amount > 10000`.

---

## Q4️⃣ Product Quantity Pivot by Order Status

**Goal:** For each product, see **how much quantity** was ordered in each status.

Join `order_items` + `orders` + `products` to get output:

| product_id | product_name        | qty_delivered | qty_pending | qty_cancelled | qty_shipped |
| ---------- | ------------------- | ------------- | ----------- | ------------- | ----------- |
| 1          | Mechanical Keyboard | ?             | ?           | ?             | ?           |

**Requirements:**

* Use `SUM(CASE WHEN o.status = 'DELIVERED' THEN oi.quantity END)` pattern.
* Include **all products that appear in `order_items`**.
* Order result by `product_name`.

This is a classic **pivot + join + aggregation** combo they love in interviews.

---

## Q5️⃣ GROUP_CONCAT Pivot – Orders by Status in a Single Row

**Goal:** Use `GROUP_CONCAT()` to collect **order_ids per status** in one row.

Output:

| delivered_orders | pending_orders | cancelled_orders | shipped_orders |
| ---------------- | -------------- | ---------------- | -------------- |
| 1,3,7,8          | 2,6            | 4                | 5              |

**Requirements:**

* One row only (no GROUP BY customer/date).
* Each column uses `GROUP_CONCAT(CASE WHEN ...)`.
* Inside `GROUP_CONCAT`, sort the ids ascending (if possible).

This trains you to use `GROUP_CONCAT` + conditional aggregation together.

---

If you want a **spicier one** (optional, Q6):

## Q6️⃣ Category-Level Active vs Inactive Products Pivot

Using `products`, create:

| category    | active_products | inactive_products | any_inactive_flag |
| ----------- | --------------- | ----------------- | ----------------- |
| Furniture   | 2               | 0                 | 0                 |
| Electronics | 3               | 0                 | 0                 |
| Accessories | 0               | 1                 | 1                 |

**Requirements:**

* Use `COUNT(CASE WHEN is_active = 1 THEN 1 END)` etc.
* `any_inactive_flag` should be:

  * `1` if that category has any inactive products
  * `0` otherwise
    (Hint: `MAX(CASE WHEN is_active = 0 THEN 1 ELSE 0 END)`)

---

If you want next, I can:

* Give **solutions for all 5/6** (with explanations),
* Or check your attempt for a couple of them and correct / optimize.

You pick:
👉 **“Give solutions”** or **“I’ll try first, then we review”**
