                                 ### Coasters Analysis ###
rm(list = ls())

# Loading dataset
coasters <- read.delim("coasters-2015.txt", stringsAsFactors = FALSE)

# Clean data: remove missing values and duplicate rows for key variables
coasters <- coasters[complete.cases(coasters[, c("Speed", "Height", "Length")]), ]
coasters <- coasters[!duplicated(coasters), ]

# Convert 'Track' column to factor
coasters$Track <- factor(coasters$Track, levels = c("Steel", "Wood"))

# Basic structure and summary
str(coasters)
summary(coasters)

# Check if Speed follows normal distribution
hist(coasters$Speed, main = "Histogram of Speed", probability = TRUE)
qqnorm(coasters$Speed, main = "Q-Q Plot of Speed"); qqline(coasters$Speed, col = 2)
shapiro.test(coasters$Speed)

# KS test against a normal distribution
set.seed(1)
ndata <- rnorm(1000, mean = mean(coasters$Speed), sd = sd(coasters$Speed))
ks.test(coasters$Speed, "pnorm", mean = mean(coasters$Speed), sd = sd(coasters$Speed))

# Compare Speed across Track types
tapply(coasters$Speed, coasters$Track, mean)
tapply(coasters$Speed, coasters$Track, sd)
bartlett.test(Speed ~ Track, data = coasters)
oneway.test(Speed ~ Track, data = coasters, var.equal = FALSE)

# Boxplot: Speed vs Track
boxplot(Speed ~ Track, data = coasters,
        main = "Speed by Track Type", xlab = "Track", ylab = "Speed",
        col = "lightgray", las = 1)

# Correlation check
cor(coasters[, c("Speed", "Height", "Length")])
cor.test(coasters$Speed, coasters$Height)

# Model 1: Full model with Height & Length
model_full <- lm(Speed ~ Height + Length, data = coasters)
summary(model_full)

# Model 2: Simple model with only Height
model_simple <- lm(Speed ~ Height, data = coasters)
summary(model_simple)

# Remove outlier (row 139) for improved model
coasters_new <- coasters[-139, ]

# Final model: Speed ~ Height (cleaned data)
model_final <- lm(Speed ~ Height, data = coasters_new)
summary(model_final)

# Residual analysis
shapiro.test(resid(model_final))  # Check for normal distribution of residuals
plot(fitted(model_final), resid(model_final),
     main = "Residuals vs Fitted Values",
     xlab = "Fitted Speed", ylab = "Residuals",
     pch = 16, col = "darkgray")
abline(h = 0, col = "red", lty = 2)

# Predict speeds for new coaster designs
new_designs <- data.frame(Height = c(50, 100, 150, 200, 250, 300))
predicted_speeds <- predict(model_final, newdata = new_designs)
prediction_results <- cbind(new_designs, Predicted_Speed = round(predicted_speeds, 2))
print(prediction_results)

# Plot: Final regression fit with predictions
plot(coasters_new$Height, coasters_new$Speed,
     main = "Final Regression Fit with Predictions",
     xlab = "Height", ylab = "Speed", pch = 16, col = "gray")
abline(model_final, col = "red", lwd = 2)

# Add predicted points
points(new_designs$Height, predicted_speeds, col = "blue", pch = 19)
text(new_designs$Height, predicted_speeds,
     labels = paste0(round(predicted_speeds, 1), " km/h"),
     pos = 3, col = "blue", cex = 0.8)

# Add legend
legend("topleft",
       legend = c("Existing Coasters", "Regression Line", "Predicted Speeds"),
       col = c("gray", "red", "blue"),
       pch = c(16, NA, 19),
       lty = c(NA, 1, NA),
       pt.cex = c(1, NA, 1),
       lwd = c(NA, 2, NA),
       bty = "n")

# Key Insights from This Analysis
# Track Type Affects Speed → Steel roller coasters may be faster than wooden ones.
# Height & Length Correlate with Speed → Taller and longer roller coasters tend to be faster.
# Regression Models Predict Speed → The model helps estimate coaster speed based on design features.
# Outliers Impact Accuracy → Removing extreme values improves predictions.
# Residuals Validate the Model → Residuals are random, supporting linear regression assumptions.
