# Hospital Operations Healthcare Analytics Using SQL

SQL analysis of hospital operations data, including patients, doctors, departments, hospital stays, and medical expenses.

## Files

- `Hospital_Data.csv` - Source dataset containing 100 hospital operation records.
- `hospital_database.sql` - SQLite table definition, CSV import command, and analysis queries.

## Analyses Included

The SQL script includes queries for:

1. Total number of patients
2. Average number of doctors per hospital
3. Top 3 departments by patient count
4. Hospital with the maximum recorded medical expenses
5. Daily average medical expenses per hospital
6. Longest hospital stay
7. Total patients treated per city
8. Average length of stay per department
9. Department with the lowest patient count
10. Monthly medical expenses report

## Running the SQL Script

Install SQLite, then run this command from the project directory:

```bash
sqlite3 hospital_data.db ".read hospital_database.sql"
```

The script creates the `hospital_data` table, imports the CSV records, and executes the analysis queries.

## Data Notes

- The source dates use the `DD-MM-YYYY` format.
- Medical expenses are stored as decimal values.
- Patient totals are calculated by summing `Patients Count` across records.
- Monthly expenses are grouped by admission month.

The expected total number of patients is **9,347**.
