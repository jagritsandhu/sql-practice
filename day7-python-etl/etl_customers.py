import pandas as pd
import sqlite3

#Extract
df = pd.read_csv("customers.csv")

#Transform
df.columns = df.columns.str.lower().str.replace(" ", "_")
df['signup_date'] = pd.to_datetime(df['signup_date'], errors='coerce')
df.dropna(subset=['signup_date'], inplace=True) #Remove incomplete records

#Load
conn = sqlite3.connect("etl.db")
df.to_sql("customers_cleaned", conn, if_exists="replace", index=False)
print("✅ ETL process complete.")