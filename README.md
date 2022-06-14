# COVID-19 Database Project (COMP 3150)

## Group Members
* [Ben Chittle](https://github.com/benchittle)
* [Danielle Nguyen](https://github.com/daninguy)
* [Najia Shinneeb](https://github.com/NajiaSb)

## Overview
This repository contains tools and sample data for a COVID-19 database school project. SQL*Plus 12.1.0.2.0 was used as the DBMS. All SQL scripts have been tested on this verson of the DBMS, but may not be compatible with other versions or DBMS software.

- [`docs`](docs/): Contains various documentation for the project.
    - [`COVID-19 Database Overview PPT.pdf`](docs/COVID-19%20Database%20Overview%20PPT.pdf): Slides from a PowerPoint explaining the design of the database, as well as its limitations and applications.
    - [`ER Diagram.pdf`](docs/ER%20Diagram.pdf): An Entity-Relation Diagram describding the final version of the database.
    - [`schema.pdf`](docs/schema.pdf): A prettier version of the database schema. A plain-text version / SQL script to generate the schema in SQL*PLUS can be found at [`scripts/schema.sql`](scripts/schema.sql).

- [`sample`](sample/): Contains sample data that can be used to tinker with scripts and generate a sample database.
    - [`inserts.sql`](sample/inserts.sql): A series of insert statements to populate the database. This file was generated from [`sample_data_2021.xlsx`](sample/sample_data_2021.xlsx) using [`scripts/ExcelToSQL.py`](/scripts/ExcelToSQL.py). Run it in SQL*PLUS with `@inserts.sql` after the schema has been created.
    - [`plot0.jpg`](/sample/plot0.jpg): A plot generated with [`scripts/plot.sh`](scripts/plot.sh).
    - [`queries.sql`](sample/queries.sql): A series of queries and other database manipulations to show off what can be done with the data. Run it in SQL*PLUS with `@queries.sql` after populating the database. 
    - [`sample_data_2021.xlsx`](sample/sample_data_2021.xlsx): An Excel workbook containing sample COVID-19 data for 2021 which can be used to populate the database.

- [`scripts`](scripts/): Contains tools for reading data from Excel, creating the database, and visualizing data.
    - [`dropTables.sql`](scripts/dropTables.sql): An SQL script to drop all tables created for this database. If the table names are changed from the schema, they will not be deleted.
    - [`ExcelToSQL.py`](scripts/ExcelToSQL.py): A Python script to generate SQL insert statements from an Excel workbook.
    - [`plot.sh`](scripts/plot.sh): A bash script to visualize COVID-19 data from an SQL*PLUS database in plots of user-specified data.
        - To run the script, ﬁrst create and populate the database in SQL*PLUS. Then, download the script into a new directory and run `bash plot.sh`. JPEG ﬁles will be generated in the current directory for each plot.
        - This script relies on the default table / column names from the schema. It will not work if these names are changed (i.e. after running `@queries.sql`).
    - [`schema.sql`](scripts/schema.sql): An SQL script to generate the schema of the database. Run it in SQL*PLUS with `@schema.sql`.

