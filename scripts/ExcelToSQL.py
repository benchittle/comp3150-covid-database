"""
DESCRIPTION: This script allows one to import an Excel workbook into an SQL*PLUS
    database. It translates each row of data on each sheet of the workbook into 
    a series of INSERT statements that are written to a .sql file. This file can 
    then be run from an SQL*PLUS terminal using @@filename where filename is the
    name of the file created by this script. This assumes that the user launched
    their SQL*PLUS terminal in the directory containing the created file.
VERSIONS: Python 3.10.2, pandas 1.4.2, openpyxl 3.0.9
"""

# ------------------------------------------------------------------------------

import pandas as pd

# (Unix) Path to the input Excel workbook.
INPUT_PATH = r"~/Downloads/Database.xlsx"
# (Unix) Path to output file (can be a relative path; will be created or overwritten).
OUTPUT_PATH = r"inserts.sql"

# Read in data from Excel workbook. 
data = pd.read_excel(INPUT_PATH, None)

# List for all INSERT statements.
all_statements = []

# Iterate over each sheet.
for table, df in data.items():
    # List of statements for this sheet.
    statements = []
    # We need to format any date columns correctly for SQL to read them.
    if ("reportedDate" in df.columns):
        df["reportedDate"] = df["reportedDate"].apply(lambda x: x.strftime("%d-%b-%Y"))

    # Iterate over the rows of the sheet.
    for row in df.iterrows():
        # Create an INSERT statement for each row of data.
        statements.append(f"INSERT INTO {table} VALUES {tuple(row[1])};")
    
    # Join the individual INSERT statements into a single string separated by 
    # newlines.
    all_statements.append("\n".join(statements))

# Open / create a file for the output statements.
with open(OUTPUT_PATH, "w") as file:
    # Join each string of statements (we have a string for each sheet) into one
    # long string separated by newlines and write it to a file.
    file.write("\n".join(all_statements))