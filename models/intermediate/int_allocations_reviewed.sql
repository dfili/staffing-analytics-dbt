WITH ranked_allocations AS (
    SELECT
        *,
        ROW_NUMBER() OVER (
            PARTITION BY employee_id, project_id, week_start
            ORDER BY last_updated DESC
        ) AS duplicate_rank
    FROM {{ ref('stg_allocations') }}
)

SELECT
    a.*,
    (a.allocated_hours < 0) as has_negative_hours,
    (a.duplicate_rank > 1) as is_superseded_duplicate,
    (a.project_id IS NOT NULL AND p.project_id IS NULL) as has_nonexistent_project,
    (a.employee_id IS NOT NULL AND e.employee_id IS NULL) as has_nonexistent_employee
FROM ranked_allocations as a LEFT JOIN {{ref('stg_projects')}} as p ON a.project_id=p.project_id
left JOIN {{ref('stg_employees')}} as e on a.employee_id=e.employee_id