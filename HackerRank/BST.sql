/* 🔗 Problem:
https://www.hackerrank.com/challenges/binary-search-tree-1/problem?isFullScreen=true

📌 Title:
BST

📌 Platform:
HackerRank

📌 Concept:
Binary Search Tree / Tree Traversal

📌 Difficulty:
Easy

🎯 Goal:
<What needs to be accomplished>

⚠️ Things I learned:
- Basic BST concept ( nodes,root,leafs )
- How to use Exists clause in SQL (Good concept)
- <Anything new>

🧠 Mistakes to avoid next time:
- was not clear regarding the sytaxs 
- <Syntax issue, concept confusion>

Hint:
If P IS NULL → Root
Else if N does not appear as any P → Leaf
Else → Inner

In SQL you can implement “does N appear as a parent?” in two common ways:
Use an EXISTS subquery: check EXISTS (SELECT 1 FROM BST b2 WHERE b2.P = b1.N)
Or use a self LEFT JOIN from the table to itself on b1.N = b2.P and see if a match exists.

*/

Solution:

select n,
case
    when p is null then 'Root'
    when exists (select 1 from Bst b2 where b1.n=b2.p) then 'Inner'
    else 'Leaf'
end
from BST b1 order by n;

Exists concept:
--
Exists will return True/False if a particular condition is met in the subquery.(Think of as inner table and outer table relationship)
The EXISTS operator in SQL is used to check for the existence of any rows returned by a subquery. 
It is a powerful way to test whether a relationship exists between tables without actually retrieving the data from the subquery itself.
The EXISTS condition returns TRUE if the subquery returns one or more rows, and FALSE if the subquery returns zero rows. 

Key Characteristics of EXISTS
1) Efficiency: The database engine stops processing the subquery as soon as it finds the first match. It doesn't need to count all matching rows.
2) Correlated Subquery: EXISTS is almost always used with a correlated subquery, 
meaning the inner query relies on a value from the outer query to run correctly 
(e.g., matching a CustomerID from the outer table to the inner table).

Examples
Example 1: Finding Customers Who Placed at Least One Order
We want to list customer names, but only those who appear in the Orders table.

SELECT
    C.customer_name
FROM
    Customers AS C
WHERE
    EXISTS (
        SELECT 1 -- We just select a constant '1' because we only care if a row is returned, not the data itself
        FROM Orders AS O
        WHERE O.customer_id = C.customer_id
    );
