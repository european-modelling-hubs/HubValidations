test_that("print method", {

  res <- expect_silent({
    validate_model_data(
      system.file("testdata", "example-model", "2021-07-26-example-model.csv",
                  package = "HubValidations"),
      system.file("testdata", "schema-data.yml",
                  package = "HubValidations")
    )})

  expect_output(print(res))

})
