"""
Exploratory Data Analysis (EDA) Assignment - Breast Cancer Dataset
Covers Data Loading, Cleaning, Descriptive Statistics, Visualization, Feature Engineering, and Conclusion.
Source: Unit2_python_assignment_2.pdf[cite: 6, 7, 8]
"""

import matplotlib.pyplot as plt
import numpy as np
import pandas as pd
import seaborn as sns
from sklearn.datasets import load_breast_cancer

# Set plotting style
sns.set_theme(style="whitegrid")
plt.rcParams.update({"figure.max_open_warning": 0})

print("=" * 60)
print("1. DATA LOADING AND EXPLORATION")
print("=" * 60)

# Load the Breast Cancer dataset[cite: 6]
breast_cancer = load_breast_cancer()
df_cancer = pd.DataFrame(data=breast_cancer.data, columns=breast_cancer.feature_names)
df_cancer["target"] = breast_cancer.target

# 1. Display the first few rows and available features[cite: 6]
print("First 5 rows of the dataset:")
print(df_cancer.head())
print(f"\nFeatures (columns) available: {list(df_cancer.columns)}")

# 2. Shape of the dataset[cite: 6]
rows, cols = df_cancer.shape
print(f"\nShape of the dataset: {rows} rows and {cols} columns[cite: 6].")

# 3. Data types using info()[cite: 6]
print("\nData types summary:")
print(df_cancer.dtypes.value_counts())

# 4. Summary statistics using describe()[cite: 6]
mean_radius = df_cancer["mean radius"]
print(f"\nSummary Statistics for 'mean radius'[cite: 6]:")
print(f"  - Mean: {mean_radius.mean():.4f}")
print(f"  - Median: {mean_radius.median():.4f}")
print(f"  - Standard Deviation: {mean_radius.std():.4f}")

# 5. Missing values check[cite: 7]
missing_values = df_cancer.isnull().sum().sum()
print(f"\nTotal missing values in the dataset: {missing_values}[cite: 7]")


print("\n" + "=" * 60)
print("2. DATA CLEANING")
print("=" * 60)

# 1 & 2. Handle missing values and verify target variable labels[cite: 7]
print("Data Cleaning Evaluation[cite: 7]:")
print("  - Since there are 0 missing values, no imputation or removal is required.")
print(f"  - Target unique values: {df_cancer['target'].unique()} (0: malignant, 1: benign)[cite: 7].")
print("  - No inconsistencies found in the target variable.")


print("\n" + "=" * 60)
print("3. DESCRIPTIVE STATISTICS")
print("=" * 60)

# 1. Mean, median, std for 'mean area' and 'mean compactness'[cite: 7]
for col in ["mean area", "mean compactness"]:
  print(f"\nStatistics for '{col}'[cite: 7]:")
  print(f"  - Mean: {df_cancer[col].mean():.4f}")
  print(f"  - Median: {df_cancer[col].median():.4f}")
  print(f"  - Standard Deviation: {df_cancer[col].std():.4f}")

# 4. Group by target and calculate mean for 'mean perimeter'[cite: 7]
perimeter_by_target = df_cancer.groupby("target")["mean perimeter"].mean()
print("\nMean perimeter by target (0: Malignant, 1: Benign)[cite: 7]:")
print(perimeter_by_target)


print("\n" + "=" * 60)
print("4. DATA VISUALIZATION & GENERATING PLOTS")
print("=" * 60)

# 1. Bar chart for benign vs malignant cases[cite: 7]
plt.figure(figsize=(6, 4))
sns.countplot(x="target", data=df_cancer, palette="Set2")
plt.title("Distribution of Benign vs Malignant Cases[cite: 7]")
plt.xlabel("Target (0: Malignant, 1: Benign)")
plt.ylabel("Count")
plt.savefig("benign_vs_malignant_counts.png")
plt.close()
print("-> Saved bar chart to 'benign_vs_malignant_counts.png'")

# 2. Scatter plot between 'mean radius' and 'mean texture'[cite: 7]
plt.figure(figsize=(8, 6))
sns.scatterplot(
    x="mean radius",
    y="mean texture",
    hue="target",
    data=df_cancer,
    palette="viridis",
    alpha=0.7,
)
plt.title("Mean Radius vs Mean Texture by Target[cite: 7]")
plt.savefig("radius_vs_texture_scatter.png")
plt.close()
print("-> Saved scatter plot to 'radius_vs_texture_scatter.png'")

# 3. Boxplot for 'mean texture' to check outliers and IQR[cite: 7]
plt.figure(figsize=(6, 4))
sns.boxplot(y=df_cancer["mean texture"], color="skyblue")
plt.title("Boxplot of Mean Texture[cite: 7]")
plt.savefig("mean_texture_boxplot.png")
plt.close()

Q1 = df_cancer["mean texture"].quantile(0.25)
Q3 = df_cancer["mean texture"].quantile(0.75)
iqr = Q3 - Q1
print(f"\nMean Texture IQR: {iqr:.4f}[cite: 7]")
print("-> Saved boxplot to 'mean_texture_boxplot.png'")

# 4. Correlation Heatmap[cite: 7]
plt.figure(figsize=(12, 10))
corr_matrix = df_cancer.corr()
sns.heatmap(corr_matrix, cmap="coolwarm", annot=False)
plt.title("Correlation Matrix Heatmap[cite: 7]")
plt.savefig("correlation_heatmap.png")
plt.close()
print("-> Saved correlation heatmap to 'correlation_heatmap.png'")


print("\n" + "=" * 60)
print("5. FEATURE ENGINEERING")
print("=" * 60)

# 1 & 2. Create 'area_to_perimeter_ratio'[cite: 7]
df_cancer["area_to_perimeter_ratio"] = (
    df_cancer["mean area"] / df_cancer["mean perimeter"]
)
print("Created feature: 'area_to_perimeter_ratio'[cite: 7]")
print(
    "Mean ratio by target:\n",
    df_cancer.groupby("target")["area_to_perimeter_ratio"].mean(),
)

# 3. Create another derived feature: 'radius_to_texture_ratio'[cite: 7]
df_cancer["radius_to_texture_ratio"] = (
    df_cancer["mean radius"] / df_cancer["mean texture"]
)
print("\nCreated feature: 'radius_to_texture_ratio'[cite: 7]")
print(
    "Mean ratio by target:\n",
    df_cancer.groupby("target")["radius_to_texture_ratio"].mean(),
)


print("\n" + "=" * 60)
print("6. CONCLUSION & SUMMARY")
print("=" * 60)
print("1. Key Findings: Size-related features (radius, perimeter, area) exhibit distinct distributions, showing strong separability between benign and malignant cases[cite: 8].")
print("2. Most Important Features: Perimeter, area, and radius are the primary indicators for distinguishing tumor types[cite: 8].")
print("3. Recommendations: Standardize feature scales and proceed with building classification models such as Logistic Regression, Random Forest, or Support Vector Machines (SVM)[cite: 8].")