# Survey Data Analysis Platform
# Author: Gabriel Demetrios Lafis

# Load necessary libraries
library(ggplot2) # For data visualization
library(dplyr)   # For data manipulation
library(survey)  # For survey data analysis (if applicable, install.packages("survey"))

# Main function for survey data analysis
main <- function() {
    cat("🚀 Survey Data Analysis Platform\n")
    cat("👨‍💻 Created by Gabriel Demetrios Lafis\n\n")
    
    # --- 1. Sample Data Generation (Simulating Survey Data) ---
    # For a real project, you would load data from a CSV, SPSS, etc.
    set.seed(123) # for reproducibility
    survey_data <- data.frame(
        id = 1:100,
        age = sample(18:65, 100, replace = TRUE),
        gender = sample(c("Male", "Female", "Other"), 100, replace = TRUE, prob = c(0.45, 0.50, 0.05)),
        satisfaction = sample(1:5, 100, replace = TRUE, prob = c(0.1, 0.2, 0.3, 0.25, 0.15)), # 1=Very Dissatisfied, 5=Very Satisfied
        income_group = sample(c("Low", "Medium", "High"), 100, replace = TRUE, prob = c(0.3, 0.5, 0.2))
    )
    
    cat("--- Sample Survey Data Head ---\n")
    print(head(survey_data))
    cat("\n")
    
    # --- 2. Descriptive Statistics ---
    cat("--- Descriptive Statistics for Satisfaction ---\n")
    satisfaction_summary <- survey_data %>% 
        group_by(satisfaction) %>% 
        summarise(count = n()) %>%
        mutate(percentage = count / sum(count) * 100)
    print(satisfaction_summary)
    cat("\n")
    
    cat("--- Mean Age by Gender ---\n")
    age_by_gender <- survey_data %>% 
        group_by(gender) %>% 
        summarise(mean_age = mean(age))
    print(age_by_gender)
    cat("\n")
    
    # --- 3. Data Visualization (using ggplot2) ---
    cat("--- Generating Satisfaction Distribution Plot ---\n")
    satisfaction_plot <- ggplot(survey_data, aes(x = factor(satisfaction), fill = factor(satisfaction))) +
        geom_bar(stat = "count", color = "black") +
        labs(
            title = "Distribution of Customer Satisfaction",
            x = "Satisfaction Level (1=Very Dissatisfied, 5=Very Satisfied)",
            y = "Number of Respondents",
            fill = "Satisfaction"
        ) +
        theme_minimal() +
        scale_fill_brewer(palette = "YlGnBu")
    
    # Ensure the assets directory exists
    if (!dir.exists("assets")) {
        dir.create("assets")
    }
    
    # Save the plot to a file
    ggsave(file.path(getwd(), "assets", "satisfaction_distribution.png"), plot = satisfaction_plot, width = 8, height = 6, dpi = 300)

    cat("✅ Satisfaction distribution plot saved to assets/satisfaction_distribution.png\n")
    
    cat("\n✅ Survey data analysis complete!\n")
}

# Run the main function when the script is executed
main()

