## Project description 

This project demonstrates SQL-based data transformation and data quality testing with dbt and DuckDB. It uses synthetic employee and project records, along with weekly allocations of employee hours to projects.

The CSV files in data/raw/ are declared as dbt sources in models/staging/_sources.yml. Staging models cast the source fields to appropriate data types. An intermediate review model preserves the allocation rows and flags negative hours, superseded duplicates, and allocations referencing nonexistent employees or projects. A clean model filters out flagged rows.

The fct_staffing_weekly model joins valid allocations with employee and project details. It calculates each employee’s total allocated hours per week and capacity utilization, defined as total weekly allocated hours divided by weekly capacity. The fact table’s grain is one row per employee-project-week allocation.

Data tests check that allocation IDs are unique and present, and that employee and project IDs in the fact table are present and match existing records. 
In this sample run, 40 allocation rows were reviewed; 5 were flagged and excluded, leaving 35 rows in both the clean model and the fact table.

## Run locally

Before running the project:

1. Install dbt and a compatible DuckDB adapter.
2. Configure a local `~/.dbt/profiles.yml`. Its profile name must be `staffing_analytics`, matching the `profile` setting in `dbt_project.yml`, and its DuckDB database path must point to a location on your machine. Keep this machine-specific profile out of Git.
3. Load the CSV files in `data/raw/` into the configured DuckDB database as the `employees`, `projects`, and `allocations` source tables. `dbt build` transforms these tables; it does not load the CSV files.

Then, from the project root, run:

```bash
dbt build --select +fct_staffing_weekly
```

That command builds the selected fact model and its upstream models in dependency order, and runs their applicable tests. [dbt build documentation](https://docs.getdbt.com/reference/commands/build)
