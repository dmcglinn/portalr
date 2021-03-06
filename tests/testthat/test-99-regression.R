context("Regression tests for rodent, ant and plant output")

portal_data_path <- tempdir()

test_that("data generated by default setting is same", {
  data <- abundance(portal_data_path, level = 'Site',
                    type = "Rodents", plots = "all", unknowns = FALSE,
                    min_plots = 24, shape = "crosstab", time = "period") %>%
    dplyr::filter(period < 434)
  attributes(data) <- attributes(data)[sort(names(attributes(data)))]
  expect_identical(digest::digest(data), "f7365a1b64bd3aa30579abd37c6de863")
})

test_that("data generated by level = treatment, plots = longterm is same", {
  data <- abundance(portal_data_path, level = 'treatment', plots = "longterm") %>%
    dplyr::filter(period < 434)
  attributes(data) <- attributes(data)[sort(names(attributes(data)))]
  expect_identical(digest::digest(data), "5516d861d63a1305ff4b39b62c29e5a1")
})

test_that("data generated by level = plot, time = newmoon, type = granivore, shape = flat is same", {
  data <- abundance(portal_data_path, level = 'plot', type = "granivores",
                    shape = "flat", time = "newmoon") %>%
    dplyr::filter(newmoonnumber < 465)
  attributes(data) <- attributes(data)[sort(names(attributes(data)))]
  expect_identical(digest::digest(data), "edcd782e39d3a642b3d6273d893f8ed1")
})

test_that("data generated by unknowns = T, min_plots = 1 is same", {
  data <- abundance(portal_data_path, min_plots = 1, unknowns = TRUE) %>%
    dplyr::filter(period < 434) %>%
    dplyr::select(period, BA, DM, DO, DS, "NA", OL, OT, other, PB,
                  PE, PF, PH, PI, PL, PM, PP, RF, RM, RO, SF, SH, SO)
  attributes(data) <- attributes(data)[sort(names(attributes(data)))]
  expect_identical(digest::digest(data), "716cba45b04466dea49bccd2844ef5da")
})

test_that("data generated by plots = c(4, 8, 10, 12) is same", {
  data <- summarize_rodent_data(path = portal_data_path, plots = c(4, 8, 10, 12),
                          na_drop = TRUE, zero_drop = FALSE) %>%
    dplyr::filter( period < 450)
  attributes(data) <- attributes(data)[sort(names(attributes(data)))]
  expect_identical(digest::digest(data), "c4eb4083894c3790ceeba6b8ef8d3579")
})

test_that("biomass data generated by level = plot is same", {
  data <- biomass(portal_data_path, level = "plot") %>%
    dplyr::filter(period < 434)
  attributes(data) <- attributes(data)[sort(names(attributes(data)))]

  # correct for NAs in output
  expect_identical(digest::digest(is.na(data)), "0db04ad8786ee1182b135a431cc7671f")
  data[is.na(data)] <- -999999
  expect_identical(digest::digest(data), "3f739b2606521b30ebefd87234219c59")
})

test_that("biomass data generated by min_plots = 1 is same", {
  data <- biomass(portal_data_path, min_plots = 1) %>%
    dplyr::filter(period < 434)
  attributes(data) <- attributes(data)[sort(names(attributes(data)))]
  expect_identical(digest::digest(data), "78312c1d686891d5b7b4e2f116878221")
})

test_that("data generated by default setting is same (plants)", {
  data <- plant_abundance(portal_data_path, level = 'Site',
                          type = "All", plots = "all", unknowns = FALSE,
                          correct_sp = TRUE, shape = "flat", na_drop = TRUE,
                          zero_drop = TRUE, min_quads = 1, effort = TRUE) %>%
    dplyr::filter(year < 2015) %>%
    dplyr::mutate(species = as.character(species))
  attributes(data) <- attributes(data)[sort(names(attributes(data)))]
  expect_identical(digest::digest(data), "81500538a4442da85886e2f55727bb85")
})

test_that("data generated by type = Shrubs, unknowns = T, correct_sp = F is same (plants)", {
  data <- plant_abundance(portal_data_path, level = 'Site',
                          type = "Shrubs", plots = "all", unknowns = TRUE,
                          correct_sp = FALSE, shape = "flat", na_drop = TRUE,
                          zero_drop = TRUE, min_quads = 1, effort = TRUE) %>%
    dplyr::filter(year < 2015)
  attributes(data) <- attributes(data)[sort(names(attributes(data)))]
  expect_identical(digest::digest(data), "6ff115fb81c7f50ebc1da72f62458ae7")
})

test_that("data generated by level = Plot, type = Annuals, plots = longterm is same (plants)", {
  data <- plant_abundance(portal_data_path, level = 'Plot',
                          type = "Annuals", plots = "longterm",
                          unknowns = TRUE, correct_sp = TRUE, shape = "flat",
                          na_drop = TRUE, zero_drop = TRUE, min_quads = 1, effort = TRUE) %>%
    dplyr::filter(year < 2015)
  attributes(data) <- attributes(data)[sort(names(attributes(data)))]
  expect_identical(digest::digest(data), "f000fca8bc0e2eb77acf76ba55a93f3b")
})

test_that("data generated by default setting is same (shrub_cover)", {
  data <- shrub_cover(path = portal_data_path, type = "Shrubs",
                      plots = "all", unknowns = FALSE,
                      correct_sp = TRUE) %>%
    dplyr::filter(year < 2015)
  attributes(data) <- attributes(data)[sort(names(attributes(data)))]

  # correct for NAs in output
  expect_identical(digest::digest(is.na(data)), "77da4ca0e34baa323e0384a2c93e8f50")
  data[is.na(data)] <- -999999
  expect_identical(digest::digest(data), "9e5849fa79fc71da82ae58b5ea7b7bf9")
})

test_that("data generated by default setting is same (ant colony_presence_absence)", {
  data <- colony_presence_absence(portal_data_path, level = 'Site', rare_sp = F, unknowns = F) %>%
    dplyr::filter(year < 2015)
  attributes(data) <- attributes(data)[sort(names(attributes(data)))]

  # correct for NAs in output
  expect_identical(digest::digest(is.na(data)), "512fa0d8676aa617e4ee432f826feccd")
  data[is.na(data)] <- -999999
  expect_identical(digest::digest(data), "0fa76fd5b6f0b5e374ee9ce1eee028a9")
})

test_that("data generated by default setting is same (ant bait_presence_absence)", {
  data <- bait_presence_absence(portal_data_path, level = 'Site') %>%
    dplyr::filter(year < 2015)
  attributes(data) <- attributes(data)[sort(names(attributes(data)))]
  expect_identical(digest::digest(data), "aeffcd88c83fbe683c420743dc45403e")
})

test_that("data generated by default setting is same (weather)", {
  data <- weather(path = portal_data_path) %>%
    dplyr::filter(year < 2015)
  attributes(data) <- attributes(data)[sort(names(attributes(data)))]

  # correct for NAs in output
  expect_identical(digest::digest(is.na(data)), "7804c050691c1fc6b4a70d761f7eced9")
  data[is.na(data)] <- -999999
  expect_identical(digest::digest(data), "1afbe4c1f04909de611ba889e9a8ac98")
})

test_that("data generated by fill = TRUE is same (weather)", {
  data <- weather(fill = TRUE, path = portal_data_path) %>%
    dplyr::filter(year < 2015)
  attributes(data) <- attributes(data)[sort(names(attributes(data)))]

  # correct for NAs in output
  expect_identical(digest::digest(is.na(data)), "2daddbffd9a8e607f4c2841e846137eb")
  data[is.na(data)] <- -999999
  expect_identical(digest::digest(data), "d9c2755e4b1c4f85283853743a179957")
})

test_that("get_future_moons returns identical table using sample input", {
  moons <- data.frame(newmoonnumber = c(1, 2),
                      newmoondate = c("1977-07-16", "1977-08-14"),
                      period = c(1, 2),
                      censusdate = c("1977-07-16", "1977-08-19"))

  newmoons <- get_future_moons(moons, num_future_moons = 10)
  attributes(newmoons) <- attributes(newmoons)[sort(names(attributes(newmoons)))]

  # correct for NAs in output
  expect_identical(digest::digest(is.na(newmoons)), "1d6e5a1db8768bfdae56a30819211df2")
  newmoons$newmoondate[is.na(newmoons$newmoondate)] <- as.Date("0000-01-01")
  newmoons$period[is.na(newmoons$period)] <- -999999
  newmoons$censusdate[is.na(newmoons$censusdate)] <- as.Date("0000-01-01")
  expect_identical(digest::digest(newmoons), "aa0ddfd4ee3133525e5c5aedcb21a9a5")
})
