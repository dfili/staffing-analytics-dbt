WITH allocation_metrics as (SELECT
    a.allocation_id,
    a.employee_id,
    a.project_id,
    a.week_start,
    a.allocated_hours,
    e.employee_name,
    e.team,
    e.weekly_capacity_hours,
    p.product,
    p.project_name,
    SUM(a.allocated_hours) OVER (
        PARTITION BY a.employee_id,  a.week_start
    ) AS employee_week_allocated_hours
FROM {{ ref('int_allocations_clean') }} AS a
LEFT JOIN {{ ref('stg_employees') }} AS e
    ON a.employee_id=e.employee_id
LEFT JOIN {{ ref('stg_projects') }} AS p
    ON a.project_id=p.project_id
) 

SELECT *, 
    employee_week_allocated_hours / NULLIF(weekly_capacity_hours, 0) AS capacity_utilization
FROM allocation_metrics