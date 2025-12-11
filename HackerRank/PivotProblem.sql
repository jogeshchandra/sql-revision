/* 🔗 Problem:
https://www.hackerrank.com/challenges/occupations/problem?isFullScreen=true

📌 Title:
OCCUPATIONS

📌 Platform:
HackerRank

📌 Concept:
Conditional Aggregation Pivot.

📌 Difficulty:
<Easy / Medium / Hard>

📑 Schema Provided:

🎯 Goal:
Needed to pivot the table

⚠️ Things I learned:
- how to pivot the table in sql using conditional aggregation
- What is conditional aggregation how its being done using agg functions and case when statements
- <Anything new>

🧠 Mistakes to avoid next time:
- Able to pivot the table ( got the concept (refer chat GPT))
- <Syntax issue, concept confusion>
*/

My solution:
select 
max(Doctor),
max(Professor),
max(Singer),
max(Actor) from(
select name,occupation,
row_number() over (partition by occupation order by name) as rn,
(CASE when occupation ='Doctor' then name END) as Doctor ,
(CASE when occupation ='Professor' then name END) as Professor ,
(CASE when occupation ='Singer' then name END ) as Singer,
(CASE when occupation ='Actor' then name END) as Actor
from 
OCCUPATIONS) as dd
group by rn


ChatGPT Explanation:

Concept Note:
**Conditional Aggregation Pivot**
Of course! Method 1 — **Conditional Aggregation Pivot** — is the most important pivot skill because:

✔ Works in **ALL** SQL databases
✔ Common in real interviews
✔ Doesn’t need a special `PIVOT` function
✔ HackerRank/LeetCode **love** this style

---

# 🎯 The Main Idea

We convert *row values* into *columns* using:

### `CASE WHEN <condition> THEN <value> END`

But because multiple rows may match the condition → we wrap in **an aggregate** like:

✔ `MAX()`
✔ `SUM()`
✔ `COUNT()`

---

## 💡 Think of it like this:

📌 “If this row belongs to category X → put the value under column X”

---

## Example Table

| name  | occupation |
| ----- | ---------- |
| Amit  | Doctor     |
| Raj   | Actor      |
| Sara  | Professor  |
| Meena | Singer     |

Goal: Pivot so occupations become columns

---

## ✨ Pivot Query (Method 1)

```sql
SELECT
    MAX(CASE WHEN occupation = 'Doctor' THEN name END) AS Doctor,
    MAX(CASE WHEN occupation = 'Actor' THEN name END) AS Actor,
    MAX(CASE WHEN occupation = 'Professor' THEN name END) AS Professor,
    MAX(CASE WHEN occupation = 'Singer' THEN name END) AS Singer
FROM occupations;
```

---

# 🔍 How it works (Breaking it down)

Take one column — Doctor:

```sql
MAX(CASE WHEN occupation = 'Doctor' THEN name END) AS Doctor
```
//This is important to understand:
Internally SQL sees the table like this:

| name  | occupation | CASE WHEN occupation='Doctor' THEN name |
| ----- | ---------- | --------------------------------------- |
| Amit  | Doctor     | Amit                                    |
| Raj   | Actor      | NULL                                    |
| Sara  | Professor  | NULL                                    |
| Meena | Singer     | NULL                                    |

Then `MAX()` picks the only non-null (`Amit`)

Same happens for other occupations.

---

# ❓ Why `MAX()`?

Because we need an aggregate function to **collapse rows** into 1 row **per column**

Other valid options:

* `MIN(name)`
* `GROUP_CONCAT(name)` → if multiple names per role

---

# 🧠 When to use Conditional Aggregation?

| Use case                                 | Example              |
| ---------------------------------------- | -------------------- |
| Pivot rows to columns                    | This example         |
| Create cross-tab reports                 | Metrics per category |
| Convert month rows → Jan, Feb, … columns | finance reporting    |
| Dynamic number of columns                | segmentation         |

---

# ⚠️ Limitations

| Issue                                     | Workaround                         |
| ----------------------------------------- | ---------------------------------- |
| Every value creates a new column manually | Dynamic SQL                        |
| Not ideal for huge category lists         | Pre-aggregation or pivot functions |

---

# 🚀 Quick Practice Exercise for You

Using `de_sql_basics` DB:

👉 Pivot number of orders by order status into columns:

Expected output:

| DELIVERED | PENDING | CANCELLED | SHIPPED |
| --------- | ------- | --------- | ------- |
| X         | Y       | Z         | W       |

Try writing using:

```sql
COUNT(CASE WHEN status = '...' THEN 1 END)
```

If you want, I can:
✔ Check your answer
✔ Give more pivot challenges
✔ Show advanced dynamic pivot version

---

Would you like more real-world data engineering examples of this pivot pattern next?

Nice — this is a classic interview puzzle (vertical pivot by rank). I’ll break the query into small pieces, show what each part does, why it’s written that way, and give a tiny worked example so you can *see* the transformation.

First — the full query you posted:

```sql
SELECT 
  MAX(Doctor),
  MAX(Professor),
  MAX(Singer),
  MAX(Actor)
FROM (
  SELECT
    name,
    occupation,
    ROW_NUMBER() OVER (PARTITION BY occupation ORDER BY name) AS rn,
    (CASE WHEN occupation = 'Doctor' THEN name END)    AS Doctor,
    (CASE WHEN occupation = 'Professor' THEN name END) AS Professor,
    (CASE WHEN occupation = 'Singer' THEN name END)    AS Singer,
    (CASE WHEN occupation = 'Actor' THEN name END)     AS Actor
  FROM OCCUPATIONS
) AS dd
GROUP BY rn;
```

---

## 1) What the problem asks (in plain words)

You must display **four columns** — `Doctor`, `Professor`, `Singer`, `Actor` — and under each column list the names for that occupation **alphabetically**, vertically aligned by position. If one occupation has fewer names than another, show `NULL` in that cell.

So result looks like:

| Doctor | Professor | Singer | Actor |
| ------ | --------- | ------ | ----- |
| Amit   | Sara      | Meena  | Raj   |
| John   | NULL      | NULL   | NULL  |
| ...    | ...       | ...    | ...   |

---

## 2) Why we need two steps (inner subquery + outer aggregation)

* We first need to number the names **within each occupation** according to alphabetical order (so we can align the 1st doctor with the 1st professor, 2nd doctor with 2nd professor, etc.). That is done with `ROW_NUMBER() OVER (PARTITION BY occupation ORDER BY name)`.
* Once we have that row-number (call it `rn`), we can pivot by grouping on `rn`. Each `rn` will produce a single output row containing the nth name for each occupation.
* Aggregation (e.g., `MAX`) collapses rows for a given `rn` into one row and extracts the non-NULL name for each occupation (since in a given input row only one of the CASE columns is non-NULL). `MAX` works because the non-NULL string is the only non-NULL in that group — `MIN` would work equally well.

---

## 3) Inner query explained (the subquery `dd`)

```sql
SELECT
  name,
  occupation,
  ROW_NUMBER() OVER (PARTITION BY occupation ORDER BY name) AS rn,
  CASE WHEN occupation = 'Doctor'    THEN name END AS Doctor,
  CASE WHEN occupation = 'Professor' THEN name END AS Professor,
  CASE WHEN occupation = 'Singer'    THEN name END AS Singer,
  CASE WHEN occupation = 'Actor'     THEN name END AS Actor
FROM OCCUPATIONS
```

* `ROW_NUMBER() OVER (PARTITION BY occupation ORDER BY name) AS rn`
  For each distinct `occupation`, rows are ordered by `name` and assigned sequential numbers starting at 1.
  Example for occupation = Doctor: names [Amit, John, Neha] → rn 1,2,3.

* Each `CASE WHEN occupation = '...' THEN name END` produces a column that is:

  * the `name` for rows of that occupation
  * `NULL` for rows of other occupations

So inner result (conceptually) looks like:

| name  | occupation | rn | Doctor | Professor | Singer | Actor |
| ----- | ---------- | -- | ------ | --------- | ------ | ----- |
| Amit  | Doctor     | 1  | Amit   | NULL      | NULL   | NULL  |
| John  | Doctor     | 2  | John   | NULL      | NULL   | NULL  |
| Neha  | Doctor     | 3  | Neha   | NULL      | NULL   | NULL  |
| Sara  | Professor  | 1  | NULL   | Sara      | NULL   | NULL  |
| Meena | Singer     | 1  | NULL   | NULL      | Meena  | NULL  |
| Raj   | Actor      | 1  | NULL   | NULL      | NULL   | Raj   |
| ...   | ...        | .. | ...    | ...       | ...    | ...   |

Note that multiple rows share the same `rn` value but for **different occupations**. For example `rn = 1` appears for Doctor, Professor, Singer, Actor rows.

---

## 4) Outer query explained

```sql
SELECT
  MAX(Doctor),
  MAX(Professor),
  MAX(Singer),
  MAX(Actor)
FROM ( ... ) AS dd
GROUP BY rn;
```

* We `GROUP BY rn` — that groups together the 1st names of every occupation (rn = 1), then the 2nd names (rn = 2), etc.
* Within each `rn` group, columns `Doctor`, `Professor`, `Singer`, `Actor` each have at most **one** non-NULL value (because the inner rows put a name into exactly one of those columns per row). Using an aggregate like `MAX()` picks that non-NULL value.
* If some occupation has no nth name (for example, only one professor exists, but there are two doctors), then for `rn = 2` the `Professor` column will be NULL — exactly what the question asks for.

Why `MAX`? Because we need an aggregate to collapse multiple input rows (one per occupation) into a single output row per `rn`. `MAX`/`MIN` behave the same here (they return the non-NULL string), so either works.

---

## 5) Step-by-step small example

Input `OCCUPATIONS`:

| name  | occupation |
| ----- | ---------- |
| Amit  | Doctor     |
| John  | Doctor     |
| Neha  | Doctor     |
| Sara  | Professor  |
| Meena | Singer     |
| Raj   | Actor      |

Inner subquery (with rn and CASEs):

| name  | occupation | rn | Doctor | Professor | Singer | Actor |
| ----- | ---------- | -- | ------ | --------- | ------ | ----- |
| Amit  | Doctor     | 1  | Amit   | NULL      | NULL   | NULL  |
| John  | Doctor     | 2  | John   | NULL      | NULL   | NULL  |
| Neha  | Doctor     | 3  | Neha   | NULL      | NULL   | NULL  |
| Sara  | Professor  | 1  | NULL   | Sara      | NULL   | NULL  |
| Meena | Singer     | 1  | NULL   | NULL      | Meena  | NULL  |
| Raj   | Actor      | 1  | NULL   | NULL      | NULL   | Raj   |

Group by `rn` and take `MAX`:

* rn = 1 → MAX(Doctor)=Amit, MAX(Professor)=Sara, MAX(Singer)=Meena, MAX(Actor)=Raj
* rn = 2 → MAX(Doctor)=John, others NULL
* rn = 3 → MAX(Doctor)=Neha, others NULL

Final output:

| Doctor | Professor | Singer | Actor |
| ------ | --------- | ------ | ----- |
| Amit   | Sara      | Meena  | Raj   |
| John   | NULL      | NULL   | NULL  |
| Neha   | NULL      | NULL   | NULL  |

Perfect match for the requirement.

---

## 6) Notes, variations and gotchas

* **Order inside each column is alphabetical** because `ROW_NUMBER()` used `ORDER BY name`.
* **If you want columns in a specific order** in the result, list them explicitly in the outer `SELECT` (you did: Doctor, Professor, Singer, Actor). SQL result column order follows the SELECT clause.
* **Using `MIN()` instead of `MAX()` would give the same result** in this scenario.
* **If you wanted all names concatenated per occupation in one row**, use `GROUP_CONCAT` (MySQL) or `STRING_AGG` (Postgres) — that produces a different layout (single row, comma-separated lists).
* **This approach works in engines that support window functions** (MySQL 8+, PostgreSQL, SQL Server, Oracle, Snowflake). If your DB doesn’t support window functions, you need a more complex workaround (e.g., simulate row numbers using variables in older MySQL).
* **Performance:** For large tables this is fine but be aware `ROW_NUMBER()` requires sorting per partition; ensure you only process necessary rows (filter if possible).

---

## 7) Short annotated version (commented query)

```sql
-- 1) Assign rank per occupation (alphabetical) and create occupation-specific columns
SELECT
  name,
  occupation,
  ROW_NUMBER() OVER (PARTITION BY occupation ORDER BY name) AS rn,
  CASE WHEN occupation = 'Doctor'    THEN name END AS Doctor,
  CASE WHEN occupation = 'Professor' THEN name END AS Professor,
  CASE WHEN occupation = 'Singer'    THEN name END AS Singer,
  CASE WHEN occupation = 'Actor'     THEN name END AS Actor
FROM OCCUPATIONS;

-- 2) Group by the rank and pick the non-null value per occupation column
SELECT
  MAX(Doctor) AS Doctor,
  MAX(Professor) AS Professor,
  MAX(Singer) AS Singer,
  MAX(Actor) AS Actor
FROM ( ...above... ) dd
GROUP BY rn;
```

---

If you want, I can:

* Run this with the sample `OCCUPATIONS` data and show exact output (if you paste the data), or
* Provide an alternate solution using `GROUP_CONCAT` (single-row lists), or
* Show how to make the solution dynamic if occupation categories are not known in advance.

Which would you like next?
