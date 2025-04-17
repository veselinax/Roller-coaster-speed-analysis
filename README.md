# Roller Coaster Speed Analysis

This project investigates how roller coaster design characteristics—specifically track type, height, and length—affect coaster speed. Using R, the analysis applies statistical testing, regression modeling, and predictive techniques to understand and estimate coaster performance.

---

## Project Files

- `roller_coaster.R`: Complete analysis script including data cleaning, modeling, and visualization
- The dataset `coasters-2015.txt`

---

## Methods & Tools

- R programming language
- Data wrangling and preprocessing
- Exploratory data analysis (EDA)
- Normality testing (Shapiro-Wilk, Kolmogorov-Smirnov)
- Group comparison using ANOVA and Bartlett's test
- Linear regression modeling (simple and multiple)
- Residual diagnostics and model validation
- Predictive modeling and plotting

---

## Analysis Workflow

1. **Data Cleaning**  
   Verified structure and removed any duplicated rows. No missing values were found in the core variables (`Speed`, `Height`, `Length`).

2. **Descriptive & Visual Analysis**  
   Summary statistics and histograms were used to understand variable distributions.

3. **Hypothesis Testing**  
   Compared speed distributions between steel and wooden track types using one-way ANOVA.

4. **Regression Modeling**  
   Built models to predict speed from height and length. A simplified model using only height was selected after validating performance.

5. **Outlier Management**  
   One extreme outlier was identified and removed to improve model quality.

6. **Model Diagnostics**  
   Residual plots and normality tests confirmed that the linear regression assumptions were reasonably met.

7. **Prediction**  
   Used the final model to estimate speeds for new coaster designs with varying heights.

---

## Sample Predictions

| Height (m) | Predicted Speed (km/h) |
|------------|------------------------|
| 50         | 37.5                   |
| 100        | 49.4                   |
| 150        | 61.3                   |
| 200        | 73.1                   |
| 250        | 85.0                   |
| 300        | 96.9                   |

---

## Key Findings

- Steel coasters have statistically higher speeds than wooden coasters.
- Coaster height is strongly correlated with speed.
- The final linear model accurately predicts coaster speed from height.
- Residual analysis confirmed the model's validity.
- Predictive modeling provides a valuable tool for estimating performance in new coaster designs.

---

## Author

Veselina Veselinova 
veselina.vx@gmail.com  
 
