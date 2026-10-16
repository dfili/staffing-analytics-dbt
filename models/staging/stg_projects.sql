SELECT
    CAST(project_id as VARCHAR) as project_id, 
    CAST(product as VARCHAR) as product, 
    CAST(project_name as VARCHAR) as project_name, 
    CAST(start_date as DATE) as start_date, 
    CAST(end_date as DATE) as end_date
FROM {{source('raw', 'projects' )}}