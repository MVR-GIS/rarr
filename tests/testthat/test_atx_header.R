h1 <- atx_header(1)
h2 <- atx_header(2)
h3 <- atx_header(3)
h4 <- atx_header(4)

test_that("valid header level values", {
  expect_equal(h1, "#")
  expect_equal(h2, "##")
  expect_equal(h3, "###")
  expect_equal(h4, "####")
})

test_that("invalid header level values", {
  expect_error(atx_header(0))
  expect_error(atx_header(1.5))
  expect_error(atx_header(6))
  expect_error(atx_header("1"))
})
