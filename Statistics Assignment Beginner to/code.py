# Statistics Assignment Solutions[cite: 3]
import statistics
import numpy as np
from scipy import stats

print("=== Statistics Assignment Solutions ===\n")

# Q1: Calculate the mean, median, and mode of the dataset[cite: 3]
q1_data = [12, 15, 12, 14, 19, 16, 18, 12, 16, 15]
mean_q1 = statistics.mean(q1_data)
median_q1 = statistics.median(q1_data)
mode_q1 = statistics.mode(q1_data)

print("Q1: Measures of Central Tendency")
print(f"  Dataset: {q1_data}")
print(f"  - Mean: {mean_q1}")
print(f"  - Median: {median_q1}")
print(f"  - Mode: {mode_q1}\n")


# Q2: Calculate the standard deviation and variance of test scores[cite: 3]
q2_scores = [45, 55, 65, 75, 85, 95, 100, 85, 90, 75]
variance_q2 = statistics.variance(q2_scores)
stdev_q2 = statistics.stdev(q2_scores)

print("Q2: Variance and Standard Deviation")
print(f"  Scores: {q2_scores}")
print(f"  - Variance (Sample): {variance_q2:.2f}")
print(f"  - Standard Deviation (Sample): {stdev_q2:.2f}\n")


# Q3: Calculate the range and interquartile range (IQR) of sales[cite: 3]
q3_sales = [50, 60, 55, 65, 60, 70]
range_q3 = max(q3_sales) - min(q3_sales)
q1_val, q3_val = np.percentile(q3_sales, [25, 75])
iqr_q3 = q3_val - q1_val

print("Q3: Range and Interquartile Range (IQR)")
print(f"  Sales per week: {q3_sales}")
print(f"  - Range: {range_q3}")
print(f"  - IQR: {iqr_q3}\n")


# Q4: Calculate the probability of selecting someone who prefers Product B[cite: 3]
total_people = 100
product_b_pref = 35
prob_product_b = product_b_pref / total_people

print("Q4: Probability Calculation")
print(f"  Preferences -> Product A: 40, Product B: 35, Product C: 25 (Total: 100)")
print(f"  - Probability of selecting Product B: {prob_product_b} (or {prob_product_b * 100}%)\n")


# Q5: Calculate the probability that a randomly selected person has a height > 180 cm[cite: 3]
mean_height = 170  # in cm
std_height = 10    # in cm
target_height = 180 # in cm

# Calculate Z-score
z_score = (target_height - mean_height) / std_height
# Probability of height > 180 cm is 1 - CDF at z_score
prob_height_greater = 1 - stats.norm.cdf(z_score)

print("Q5: Normal Distribution Probability")
print(f"  Mean Height: {mean_height} cm, Standard Deviation: {std_height} cm")
print(f"  - Z-score for 180 cm: {z_score}")
print(f"  - Probability (Height > 180 cm): {prob_height_greater:.4f} (or {prob_height_greater * 100:.2f}%)")