/* 🔗 Problem:
https://www.hackerrank.com/challenges/the-pads/problem?isFullScreen=true

📌 Title: The PADS
📌 Platform: HackerRank
📌 Concept: SELECT, CONCAT, DISTINCT, ORDER BY
📌 Difficulty: Easy (Warmup)

📑 Schema Provided:
Table: OCCUPATIONS
Columns:
  Name VARCHAR
  Occupation VARCHAR

🎯 Goal:
1️⃣ Print "Name(Occupation initials)" sorted alphabetically.
2️⃣ Print "There are a total of [occupation count] [occupation]s."
   sorted by count ascending, then occupation alphabetically.

⚠️ Things I learned:
- CONCAT + SUBSTR for formatting strings (how to get a char from a string )
- ORDER BY alphabetically on two different outputs
- DISTINCT grouping technique
- Query result formatting matters in SQL challenges
*/

select concat(name,'(',left(occupation,1),')') from OCCUPATIONS order by name;

select concat('There are a total of ',count(occupation),' ',lower(occupation),'s.')  
from OCCUPATIONS group by occupation order by count(occupation) asc, occupation asc;

