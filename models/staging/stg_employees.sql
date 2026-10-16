SELECT 
    CAST(employee_id AS VARCHAR) as employee_id, 
    CAST(employee_name AS VARCHAR) as employee_name, 
    CAST(team as VARCHAR) as team, 
    CAST(weekly_capacity_hours as BIGINT) as weekly_capacity_hours, 
    CAST(active_from as DATE) as active_from, 
    CAST(active_to as DATE) as active_to
FROM {{source('raw', 'employees')}}