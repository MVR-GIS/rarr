#' @title Create Pandoc ATX Header
#'
#' @description Allows programmatic creation of a Pandoc ATX-style header
#'   with attributes. The currently supported set of Pandoc header attributes
#'   is: explicit identifier, numbered-unnumbered, listed-unlisted.
#'
#' @export
#'
#' @param text         character; Text of the header.
#' @param level        integer; Level of the header.
#' @param identifier   character; Text used for specifying an explicit anchor
#'                       link.
#' @param number       logical; Should the header be numbered or unnumbered?
#'                       Default to TRUE (numbered).
#' @param list         logical; Should heading be included in the table
#'                       of contents? Default to TRUE (listed).
#'
#' @details [`pandoc` extension-header_attributes](https://pandoc.org/MANUAL.html#extension-header_attributes)
#'
#' @return None (invisible NULL). Returns the Pandoc ATX-style header using
#'  the `cat` function.
#'
#' @examples
#' pandoc_header("TR-001", 2)
#'
pandoc_header <- function (text,
                           level = 1,
                           identifier = NA,
                           number = TRUE,
                           list = TRUE) {
  # Check inputs
  if (!is.character(text)) { stop("header text must be character")}
  if (!is.numeric(level)) { stop("level must be numeric") }
  if (level < 1 & level <= 6) { stop("level must be between 1 and 6") }
  if (!is.logical(number)) { stop("number must be logical") }
  if (!is.logical(list)) { stop("list must be logical") }

  # Add ATX-style markdown header to text of header
  header <- paste(atx_header(level), text)

  # Add html anchor target hash to identifier
  ident_attribute <- ifelse(is.na(identifier), "",
                            paste0("#", identifier))
  # Set unnumbered pandoc attribute
  number_attribute <- ifelse(number, "", ".unnumbered")

  # Set unlisted attribute
  list_attribute <- ifelse(list, "", ".unlisted")

  # Build space-delimited list of header attributes (and remove white space)
  attributes <- stringr::str_squish(paste(ident_attribute,
                                          list_attribute))
  attributes <- stringr::str_squish(paste(attributes,
                                          number_attribute))
  attributes <- paste0("{", attributes, "}")

  # Combine header and attributes
  header_attributes <- paste(header, attributes)

  # Add newlines before and after header
  header_attributes <- sprintf("\n%s\n", header_attributes)

  # Use `cat` to output header
  cat(header_attributes)
}
