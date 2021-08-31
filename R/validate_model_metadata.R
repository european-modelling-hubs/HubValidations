#' Validate model metadata file
#'
#' @param metadata_file Path to the metadata `.yml` file
#' @param metadata_schema Path to the `.yml` schema file
#'
#' @return An object of class `fhub_validations`.
#'
#' @importFrom yaml read_yaml
#' @importFrom jsonlite toJSON
#' @importFrom jsonvalidate json_validate
#'
#' @export
#'
#' @examples
#' validate_model_metadata(
#'   system.file("testdata", "example-model", "metadata-example-model.yml",
#'               package = "ForecastHubValidations"),
#'   system.file("testdata", "metadata-schema.yml",
#'               package = "ForecastHubValidations")
#' )
#'
validate_model_metadata <- function(metadata_file, metadata_schema) {

  metadata <- read_yaml(metadata_file)

  # For some reason, jsonvalidate doesn't like it when we don't unbox
  metadata_json <- toJSON(metadata, auto_unbox = TRUE)
  schema_json <- toJSON(read_yaml(metadata_schema), auto_unbox = TRUE)

  validations <- list(
    fhub_check(
      metadata_file,
      "Metadata file", "using the `.yml` extension",
      fs::path_ext(metadata_file) == "yml"
    ),
    fhub_check(
      metadata_file,
      "Metadata filename", "starting with 'metadata-'",
      grepl("^metadata-",
            fs::path_file(metadata_file))
    ),
    fhub_check(
      metadata_file,
      "Metadata filename", "the same as `model_abbr`",
      grepl(metadata$model_abbr,
            fs::path_file(metadata_file))
    ),
    fhub_check(
      metadata_file,
      "Metadata file", "consistent with schema specifications",
      # Default engine (imjv) doesn't support schema version above 4 so we
      # switch to ajv that supports all versions
      json_validate(metadata_json, schema_json, engine = "ajv",
                    verbose = TRUE, greedy = TRUE)
    )
  )

  class(validations) <- c("fhub_validations", "list")

  return(validations)
}