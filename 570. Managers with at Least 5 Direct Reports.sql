SELECT
    a.name
FROM
    Employee AS a
JOIN
    Employee AS b ON a.id = b.managerId
GROUP BY
    a.id, a.name
HAVING
    COUNT(b.id) >= 5;
