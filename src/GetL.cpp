#include <Rcpp.h>
#include <math.h>
#include <Rmath.h> // use for normal distribution

using namespace Rcpp;

RNGScope scope;

NumericVector SubSet(NumericVector A, int start, int end)
{
	NumericVector B(A.begin() + start, A.begin() + end);
	return B;
}


//' Obtain likelihood estimates of gappy Gaussian time series
//' 
//' Obtain likelihood of gappy standardized Gaussian time series "x" sampled at
//' times "t" given parameter "rho" (autocorrelation).  Alternatively computes
//' the characteristic time scale "tau".
//' 
//' @name GetL
//' 
//' @param x Time series
//' @param t Sampling times
//' @param rho Auto-correlation
//' @param tau logical: Whether or not to compute characteristic time scale
//' instead of rho.
//' @return Returns the log-likelihood of the data.
//' @author Eliezer Gurarie
//' @seealso Core function of BCPA, used directly in \code{\link{GetRho}}
//' @examples 
//' # simulate autocorrelated time series
//'   rho.true <- 0.8
//'   x.full <- arima.sim(1000, model=list(ar = rho.true))
//'   t.full <- 1:1000
//'   
//' # subsample time series
//'   keep <- sort(sample(1:1000, 200))
//'   x <- x.full[keep]
//'   t <- t.full[keep]
//'   plot(t,x, type="l")
//'   
//' # Obtain MLE of rho
//'   rhos <- seq(0,.99,.01)
//'   L <- sapply(rhos, function(r) GetL(x, t, r))
//'   rho.hat <- rhos[which.max(L)]
//'   plot(rhos, L, type = "l")
//'   abline(v = c(rho.true, rho.hat), lty=3:2, lwd=2)
//'   legend("bottomleft", legend=c("true value","MLE"), lty=3:2, lwd=2, 
//'          title = expression(rho))
//'          
//' # Why tau is better
//'   tau.true <- -1/log(rho.true)
//'   taus <- seq(1,10,.1)
//'   L <- sapply(taus, function(r) GetL(x, t, r, tau = TRUE))
//'   tau.hat <- taus[which.max(L)]
//' 
//'   plot(taus, L, type = "l")
//'   abline(v = c(tau.true, tau.hat), lty=3:2, lwd=2)
//'   legend("bottomleft", legend=c("true value","MLE"), lty=3:2, lwd=2, 
//'          title = expression(tau))
      
// [[Rcpp::export]]
double GetL(NumericVector x, NumericVector t, double rho, bool tau = false)
{
	NumericVector Time(t);
	NumericVector X(x);
	double Rho = rho;
  bool Tau = tau;
	
	int N = Time.size()-1;
	
	double mux = mean(X); 
	double sigmax = sd(X);
	
	NumericVector dT(N);
	NumericVector RhoToTheDt(N); 

	NumericVector Xstart = SubSet(X, 0, N);
	NumericVector Xend = SubSet(X, 1, N+1);
	dT = diff(Time); 

  if(Tau == false)
	for(int i = 0; i < N; i++)
    RhoToTheDt[i] = pow(Rho, dT[i]);
    
  else
  for(int i = 0; i < N; i++)
    RhoToTheDt[i] = exp(-dT[i]/Rho);

	NumericVector Mu = RhoToTheDt*(Xstart-mux) + mux;
	NumericVector Sigma = sigmax*sqrt(1-RhoToTheDt*RhoToTheDt);
  	
	double LL = 0;
	
	for(int i = 0; i < N; i++)
   LL = LL + R::dnorm(Xend[i], Mu[i], Sigma[i], 1);

	return LL;
}
