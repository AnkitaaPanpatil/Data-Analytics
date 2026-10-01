from sqlalchemy import create_engine
import pandas as pd

engine = create_engine(
    "mysql+pymysql://root:2021HC0007@localhost/tennis_project"
)

def load_table(table_name):
    query = f"SELECT * FROM {table_name}"
    return pd.read_sql(query, engine)