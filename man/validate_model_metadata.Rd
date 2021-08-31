% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/validate_model_metadata.R
\name{validate_model_metadata}
\alias{validate_model_metadata}
\title{Validate model metadata file}
\usage{
validate_model_metadata(metadata_file, metadata_schema)
}
\arguments{
\item{metadata_file}{Path to the metadata \code{.yml} file}

\item{metadata_schema}{Path to the \code{.yml} schema file}
}
\value{
An object of class \code{fhub_validations}.
}
\description{
Validate model metadata file
}
\examples{
validate_model_metadata(
  system.file("testdata", "example-model", "metadata-example-model.yml",
              package = "ForecastHubValidations"),
  system.file("testdata", "metadata-schema.yml",
              package = "ForecastHubValidations")
)

}