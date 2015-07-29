#' @name mfrt
#' @title MFRT in Sweden 1751-1970
#' @description Martial fertility rates in Sweden 1751 to 1970 by county.
#' @docType data
#' @usage data(mfrt)
#' @format A data frame with 1678 rows and 6 variables:
#' \describe{
#'   \item{from}{Start year}
#'   \item{to}{End year}
#'   \item{context}{Context name, county or Sweden total}
#'   \item{age}{Age group}
#'   \item{fert}{Fertility rate}
#'   \item{county_code}{County code}
#' }
#' @source Table 2.3 Marital fertility rates for period, 1751-1970;
#'   Table 6.18 Age specific rates of marital fertlity for the counties
#'   1881-1962. Hofsten, E. & Lundström, H. (1976). Swedish population
#'   history: main trends from 1750 to 1970. [Stockholm]: [LiberFörlag].
NULL


#' @name imr
#' @title Infant mortality rates
#' @description County level inafant mortality rates 1811-1972
#' @docType data
#' @usage imr
#' @format A data frame with 550 rows and 4 variables:
#' \describe{
#'   \item{county}{County code}
#'   \item{imr}{Infant mortality rate}
#'   \item{from}{Start year}
#'   \item{to}{End year}
#' }
#' @source 1811-1859, Tabellverket. 1860-1866
#'   from Th. Berg, Om dödligheten i första lefnadsåret, Statistisk
#'   tidskrift 1869. 1871-1952, Hofsten Lundström Swedish Population History
NULL


#' @name pop_age
#' @title National population by age and gender 1750-2014
#' @description Population by age and gender 1750-2014 in Sweden on a national level
#' @docType data
#' @usage data(pop_age)
#' @format A data frame with 31240 rows and 5 variables:
#' \describe{
#'   \item{year}{Year}
#'   \item{gender}{Male, female or all}
#'   \item{pop}{Population}
#'   \item{age}{Star age of age group}
#'   \item{span}{Age span of age group}
#' }
#' @source Statistiska centralbyrån. \url{http://www.scb.se/en_/Finding-statistics/
#'   Statistics-by-subject-area/Population/Population-composition/Population-statistics/
#'   Aktuell-Pong/25795/Yearly-statistics--The-whole-country/105505/};
#'   Hofsten, E. & Lundström, H. (1976). Swedish population
#'   history: main trends from 1750 to 1970. [Stockholm]: [LiberFörlag].
NULL
