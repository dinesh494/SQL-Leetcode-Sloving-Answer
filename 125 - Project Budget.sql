SELECT
    p.title,
    p.budget,
    CASE
        WHEN (SUM(e.salary) * DATEDIFF(p.end_date, p.start_date) / 365) > p.budget 
        THEN 'over budget'
        ELSE 'within budget'
    END AS label
FROM
    projects p
JOIN
    project_employees pe ON p.id = pe.project_id
JOIN
    employees e ON pe.employee_id = e.id
GROUP BY
    p.id, p.title, p.budget, p.start_date, p.end_date
ORDER BY
    p.title;
