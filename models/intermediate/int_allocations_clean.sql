SELECT *
FROM {{ref('int_allocations_reviewed')}} 
WHERE has_negative_hours = FALSE 
    AND is_superseded_duplicate = FALSE 
    AND has_nonexistent_project = FALSE
    AND has_nonexistent_employee = FALSE