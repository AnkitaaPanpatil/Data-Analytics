"""
Python Programming Assignment Solutions
Covers Basic Operations, Lists, Dictionaries, Strings, NumPy, and Pandas[cite: 4, 5]
"""

import random
import numpy as np
import pandas as pd

print("=" * 50)
print("1. Basic Data Types and Operations")
print("=" * 50)
try:
    num1 = float(input("Enter first number: "))
    num2 = float(input("Enter second number: "))
except (ValueError, EOFError):
    num1, num2 = 12.0, 4.0  # Fallback default values if input is unavailable
    print(f"Using default numbers: {num1} and {num2}")

print(f"Addition: {num1} + {num2} = {num1 + num2}")
print(f"Subtraction: {num1} - {num2} = {num1 - num2}")
print(f"Multiplication: {num1} * {num2} = {num1 * num2}")
if num2 != 0:
    print(f"Division: {num1} / {num2} = {num1 / num2}")
else:
    print("Division: Cannot divide by zero.")


print("\n" + "=" * 50)
print("2. List Operations")
print("=" * 50)
random_list = [random.randint(1, 100) for _ in range(10)]
print(f"Original List: {random_list}")
print(f"Sorted (Ascending): {sorted(random_list)}")
print(f"Sorted (Descending): {sorted(random_list, reverse=True)}")
print(f"Minimum Value: {min(random_list)}")
print(f"Maximum Value: {max(random_list)}")
print(f"Average: {sum(random_list) / len(random_list)}")


print("\n" + "=" * 50)
print("3. Dictionary Operations")
print("=" * 50)
students_marks = {"Alice": 85, "Bob": 92, "Charlie": 78, "Diana": 95, "Ethan": 88}
print(f"Student Names: {list(students_marks.keys())}")
print(f"Marks: {list(students_marks.values())}")
top_student = max(students_marks, key=students_marks.get)
print(f"Student with highest marks: {top_student} ({students_marks[top_student]})")


print("\n" + "=" * 50)
print("4. String Manipulation")
print("=" * 50)
sentence = "Data Science and Python Programming are amazing."
print(f"Original Sentence: {sentence}")
print(f"Uppercase: {sentence.upper()}")
vowels = "aeiouAEIOU"
vowel_count = sum(1 for char in sentence if char in vowels)
print(f"Number of vowels: {vowel_count}")
print(f"Reversed sentence: {sentence[::-1]}")


print("\n" + "=" * 50)
print("5. NumPy Array Basics")
print("=" * 50)
arr_1d = np.arange(1, 11)
print(f"1D Array (1 to 10): {arr_1d}")
arr_2x5 = arr_1d.reshape(2, 5)
print(f"Reshaped 2x5 Matrix:\n{arr_2x5}")
print(f"Mean: {np.mean(arr_1d)}")
print(f"Median: {np.median(arr_1d)}")
print(f"Standard Deviation: {np.std(arr_1d)}")
print(f"Elements at even indices: {arr_1d[::2]}")


print("\n" + "=" * 50)
print("6. DataFrame Creation")
print("=" * 50)
df_data = {
    "Name": ["John", "Anna", "Peter"],
    "Age": [28, 32, 25],
    "Salary": [50000, 62000, 48000]
}
df = pd.DataFrame(df_data)
print("First two rows of the DataFrame:")
print(df.head(2))
df["Department"] = ["HR", "IT", "Finance"]
df = df.drop(columns=["Age"])
print("\nModified DataFrame (Added Department, Removed Age):")
print(df)


print("\n" + "=" * 50)
print("7. Reading and Writing CSV Files")
print("=" * 50)
# Writing to CSV for demonstration purposes
csv_filename = "employee_sample.csv"
df.to_csv(csv_filename, index=False)

# Read data from CSV into a Pandas DataFrame
df_read = pd.read_csv(csv_filename)
print("First five rows read from CSV:")
print(df_read.head(5))

# Modify a column and write to a new CSV file
df_read["Salary"] = df_read["Salary"] * 1.05  # Apply 5% bonus adjustment
new_csv_filename = "updated_employee_sample.csv"
df_read.to_csv(new_csv_filename, index=False)
print(f"\nDataFrame modified and written to new CSV: {new_csv_filename}")


print("\n" + "=" * 50)
print("8. Group By Operations")
print("=" * 50)
gb_data = {
    "Department": ["HR", "IT", "Finance", "HR", "IT"],
    "Employee": ["John", "Anna", "Peter", "Mike", "Linda"],
    "Salary": [50000, 62000, 48000, 52000, 58000]
}
df_gb = pd.DataFrame(gb_data)
print("Original GroupBy DataFrame:")
print(df_gb)
grouped = df_gb.groupby("Department")
print("\nAverage salary for each department:")
print(grouped["Salary"].mean())


print("\n" + "=" * 50)
print("9. Date-Time Operations")
print("=" * 50)
date_records = {"Join_Date": ["2023-01-15", "2024-06-10", "2025-11-05"]}
df_dates = pd.DataFrame(date_records)
df_dates["Join_Date"] = pd.to_datetime(df_dates["Join_Date"])

df_dates["Year"] = df_dates["Join_Date"].dt.year
df_dates["Month"] = df_dates["Join_Date"].dt.month
df_dates["Day"] = df_dates["Join_Date"].dt.day
print("DataFrame with extracted Year, Month, and Day:")
print(df_dates)

date_diff = df_dates["Join_Date"].max() - df_dates["Join_Date"].min()
print(f"\nDifference between latest and earliest date: {date_diff}")


print("\n" + "=" * 50)
print("10. Handling Missing Data")
print("=" * 50)
missing_data = {
    "Name": ["John", "Anna", "Peter", "Mike"],
    "Score": [85, None, 90, 78],
    "Age": [28, 32, None, 29]
}
df_missing = pd.DataFrame(missing_data)
print("Original DataFrame with missing values:")
print(df_missing)

print("\nIdentify missing values (IsNull mask):")
print(df_missing.isnull())

# Fill missing values with the mean of the respective column
df_missing["Score"] = df_missing["Score"].fillna(df_missing["Score"].mean())
df_missing["Age"] = df_missing["Age"].fillna(df_missing["Age"].mean())
print("\nDataFrame after filling missing values with column means:")
print(df_missing)

# Drop any rows that still contain missing values
df_cleaned = df_missing.dropna()
print("\nDataFrame after dropping remaining missing rows:")
print(df_cleaned)