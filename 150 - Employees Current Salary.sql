WITH EmployeePromotionMultiplier AS (
    -- Step 1: For each employee, calculate the total promotion multiplier.
    -- We use the mathematical property: product(x) = exp(sum(ln(x)))
    -- to find the product of all promotion multipliers.
    SELECT
        emp_id,
        EXP(SUM(LN(1 + percent_increase / 100.0))) AS total_multiplier
    FROM
        promotions
    GROUP BY
        emp_id
)
-- Step 2: Join back to the employees table to calculate the final salary.
SELECT
    e.id,
    e.name,e.joining_salary as initial_salary,
    -- Apply the multiplier to the joining salary.
    -- If an employee has no promotions (total_multiplier is NULL),
    -- COALESCE defaults the multiplier to 1, keeping the original salary.
    ROUND(
        e.joining_salary * COALESCE(epm.total_multiplier, 1),
        1
    ) AS current_salary
FROM
    employees e
LEFT JOIN
    EmployeePromotionMultiplier epm ON e.id = epm.emp_id
ORDER BY
    e.id;
