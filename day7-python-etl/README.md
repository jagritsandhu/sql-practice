# Day 7: Python ETL with Pandas

This project demonstrates a basic ETL (Extract, Transform, Load) pipeline using Python and Pandas.

## 📁 Files
- `customers.csv`: Sample input dataset
- `etl_customers.py`: The ETL script
- `etl.db`: Output SQLite database

## 🔁 What It Does
- Reads a raw CSV
- Transforms column names and removes rows with missing signup dates
- Loads cleaned data into SQLite

## 💡 How to Run

```bash
python3 -m venv venv
source venv/bin/activate
pip install pandas
python etl_customers.py
