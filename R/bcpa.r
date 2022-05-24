#' Behavioral Change Point Analysis
#' 
#' A collection of functions that allows one to perform the behavioral change
#' point analysis (BCPA) as described by Gurarie et al. (2009, Ecology Letters,
#' 12: 395-408).  The key features are estimation of discrete changes in
#' time-series data, notable linear and turning components of gappy velocity
#' times series extracted from movement data.
#' 
#' @details  For more movement-appropriate change point analysis, users are
#' encouraged to apply correlated velocity change point analysis as implemented
#' in the `smoove` package (as of this writing on GitHub at
#' <https://github.com/EliGurarie/smoove>) 
#' which implements methods described in Gurarie et al. 2017.
#' 
#' There is a fairly detailed vignette - type in `vignette("bcpa")`, and an
#' updated vignette `vignette("UnivariateBCPA")` with a univariate example. 
#' The key analysis function is [`WindowSweep()`](WindowSweep.html), and
#' reading its documentation is a good way to start using this package. 
#' 
#' [`WindowSweep()`](WindowSweep.html) uses a suite of functions that might be 
#' useful for more narrow analysis, listed hierarchically (from bottom-up) 
#' below: 
#' - [`GetRho()`](GetRho.html)  maximizes the likelihood to estimate
#' autocorrelation rho or characteristic time-scale tau.
#' - [`GetDoubleL()`](GetDoubleL.html)  estimates the parameters and returns the
#' log-likelihood at either side of a given break
#' - [`GetBestBreak()`](GetBestBreak.html)  finds the single best change point 
#' according to the likelihood returned by  [`GetDoubleL()`](GetDoubleL)  
#' -  [`GetModels()`](GetModels.html)   uses a (modified) BIC model selection 
#' for all combinations from M0 (\eqn{\mu_1 = \mu_2}, \eqn{\sigma_1 = \sigma_2}, 
#' \eqn{\rho_1 = \rho_2}) to M7 (\eqn{\mu_1 \neq \mu_2}, 
#' \eqn{\sigma_1 \neq \sigma_2}, \eqn{\rho_1 \neq \rho_2}) to
#' characterize the "Best Break"
#'  - Finally, [`WindowSweep()`](WindowSweep.html) sweeps a longer time series 
#'  with the Best Break / Model Selection analysis, identifying most likely break 
#'  points and BIC selected models across the time series.
#' 
#' Summary, diagnostic, and plotting functions are: 
#' - [`PartitionParameters()`](PartitionParameters.html) - outputs estimated 
#' parameters of a BCPA.
#' - [`ChangePointSummary()`](ChangePointSummary.html)  - summary table of
#' the change points.
#' - [`plot.bcpa()`](plot.bcpa.html) - a plotting method for
#' visualizing the time series with vertical lines as change points.
#' - [`PathPlot()`](PathPlot.html) - a method for drawing a color-coded track of 
#' the analysis.
#' - [`DiagPlot()`](DiagPlot.html) - diagnostic plots for BCPA.
#' 
#' A few preprocessing functions are also available: 
#' 
#' - [`plot.track()`](plot.track.html) - method for plotting a generic "track"
#' object.
#' - [`GetVT()`](GetVT.html) - returns step-lengths, absolute and turning angles 
#' from track data.

#' 
#' @md
#' 
#' @name bcpa-package
#' @aliases bcpa-package bcpa
#' @docType package
#' @author Eliezer Gurarie <egurarie@@esf.edu>
#' @references 
#' - Gurarie, E., R. Andrews and K. Laidre. 2009. A novel method for
#' identifying behavioural changes in animal movement data. Ecology Letters.
#' 12: 395-408.  
#' 
#' - Gurarie, E., C. Fleming, W.F. Fagan, K. Laidre, J.
#' Hernandez-Pliego, O. Ovaskainen. 2017. Correlated velocity models as a
#' fundamental unit of animal movement: synthesis and applications. Movement
#' Ecology, 5:13.
#' @keywords bcpa
#' @examples
#' 
#' # Running through a complete analysis:
#' ## loading data
#'   data(Simp)
#' ## plotting the track (using the plot.track method)
#'   plot(Simp)
#' ## Obtaining the movement summary table (with turning angles and step lengths)
#'   Simp.VT <- GetVT(Simp)
#' ## Applying the analysis
#'   Simp.ws <- WindowSweep(Simp.VT, "V*cos(Theta)", windowsize = 50, 
#'                          windowstep = 1, progress=TRUE)
#' ## plotting outpots
#'   plot(Simp.ws, threshold=7)
#'   plot(Simp.ws, type="flat", clusterwidth=3)
#'   PathPlot(Simp, Simp.ws)
#'   PathPlot(Simp, Simp.ws, type="flat")
#' ## Diagnostic of assumptions
#'   DiagPlot(Simp.ws)
#' 
"_PACKAGE"