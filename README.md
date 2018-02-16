### Overview

This is a collection of functions that allows one to perform the behavioral change point analysis (BCPA) as described by Gurarie et al. (2009). The key features are estimation of discrete changes in time-series data, notably linear and turning components of gappy velocity times series extracted from movement data.

This package is on [CRAN](https://cran.r-project.org/web/packages/bcpa/index.html), and its development on the Git page is minimum, mainly because a <font color = "red"> far, far superior tool for estimating behavioral changes from mechanistic continuous time movement models is available in the `smoove` package: https://github.com/EliGurarie/smoove. </font>  Animal movement analysts are encouraged to switch to using those tools instead (also, read: Gurarie et al. 2017).

That said, `bcpa` can be very useful for the analysis of one-dimensional, Gaussian, irregularly sampled time-series, whether they be  


### References

Gurarie, E., R. Andrews and K. Laidre. 2009. A novel method for identifying behavioural changes in animal movement data. *Ecology Letters* 12: 395-408.

Gurarie, E., C. Fleming, W.F. Fagan, K. Laidre, J. Hernández-Pliego, O. Ovaskainen. 2017. Correlated velocity models as a fundamental unit of animal movement: synthesis and applications. [*Movement Ecology*](https://movementecologyjournal.biomedcentral.com/articles/10.1186/s40462-017-0103-3). 