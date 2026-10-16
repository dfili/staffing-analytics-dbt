SELECT 
    CAST(allocation_id as VARCHAR) AS allocation_id, 
    CAST (employee_id AS VARCHAR) as  employee_id, 
    CAST (project_id as VARCHAR) as  project_id,
    CAST (week_start as DATE) as week_start, 
    CAST (allocated_hours as BIGINT) as allocated_hours, 
    CAST (last_updated as DATE) as last_updated
from {{ source('raw', 'allocations') }};