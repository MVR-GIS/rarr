text       <- "TR-001"
level      <- 1
identifier <- "tr-001"

# `pandoc_header` uses `cat` to create report output and must be captured
p0 <- capture_output(pandoc_header(text, level,
                                   number = TRUE, list = TRUE))
p1 <- capture_output(pandoc_header(text, level, identifier,
                                   number = TRUE, list = TRUE))
p2 <- capture_output(pandoc_header(text, level, identifier,
                                   number = FALSE, list = TRUE))
p3 <- capture_output(pandoc_header(text, level, identifier,
                                   number = TRUE, list = FALSE))
p4 <- capture_output(pandoc_header(text, level, identifier,
                                   number = FALSE, list = FALSE))

test_that("check header structure", {
  expect_equal(p0, "\n# TR-001 {}")
  expect_equal(p1, "\n# TR-001 {#tr-001}")
  expect_equal(p2, "\n# TR-001 {#tr-001 .unnumbered}")
  expect_equal(p3, "\n# TR-001 {#tr-001 .unlisted}")
  expect_equal(p4, "\n# TR-001 {#tr-001 .unlisted .unnumbered}")
})

test_that("check errors", {
  expect_error(pandoc_header(7))
  expect_error(pandoc_header(text, "3"))
  expect_error(pandoc_header(text, 7))
})
