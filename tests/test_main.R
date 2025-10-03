library(testthat)
library(ggplot2)
library(dplyr)

# Source the main script to make its functions available
source("../src/main.R")

# Define a test suite
test_that("main function runs without errors and produces expected output", {
  # Temporarily redirect output to suppress console messages during test
  # This also helps in checking if specific outputs are generated
  output_file <- tempfile(fileext = ".txt")
  sink(output_file)
  
  # Run the main function
  main()
  
  # Restore output
  sink()
  
  # Check if the output file contains expected messages
  output_content <- readLines(output_file)
  expect_true(any(grepl("🚀 Survey Data Analysis Platform", output_content)))
  expect_true(any(grepl("✅ Survey data analysis complete!", output_content)))
  
  # Check if the plot file was created
  plot_path <- "../assets/satisfaction_distribution.png"
  expect_true(file.exists(plot_path))
  
  # Clean up the generated plot file after test
  if (file.exists(plot_path)) {
    file.remove(plot_path)
  }
  
  # Clean up the temporary output file
  if (file.exists(output_file)) {
    file.remove(output_file)
  }
})

# You can add more specific tests here, for example:
# test_that("data generation produces correct dimensions", {
#   # Run main to ensure data is generated (or mock data generation)
#   main()
#   # Assuming survey_data is globally accessible or returned by a function
#   # expect_equal(nrow(survey_data), 100)
#   # expect_equal(ncol(survey_data), 5)
# })

