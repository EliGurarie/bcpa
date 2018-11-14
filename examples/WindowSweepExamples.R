# Using the included simulated  movement data
require(bcpa)
data(Simp)
plot(Simp)
Simp.VT <- GetVT(Simp)
## note: column names of Simp.VT include:
###  "S" - step length
### "Theta" - turning angle
###  T.start" "T.end"   "T.mid"  "T.POSIX" - time variables

Simp.ws <- WindowSweep(Simp.VT, "V*cos(Theta)", windowsize = 50, windowstep = 1, progress=TRUE)
plot(Simp.ws, threshold=7)
plot(Simp.ws, type="flat", clusterwidth=3)
PathPlot(Simp, Simp.ws)
PathPlot(Simp, Simp.ws, type="flat")
DiagPlot(Simp.ws)

# Example of application on one dimensional data (e.g. depth)

require(magrittr)
require(lubridate)

# simulate some data with three change points: surface, medium, deep, surface

## random times
n.obs <- 100
time = (Sys.time() - dhours(runif(n.obs, 0, n.obs))) %>% sort

d1 <- 50; d2 <- 100
t1 <- 25; t2 <- 65; t3 <- 85
sd1 <- 1; sd2 <- 5; sd3 <- 10

dtime <- difftime(time, min(time), units="hours") %>% as.numeric
phases <- cut(dtime, c(-1, t1, t2, t3, 200), labels = c("P1","P2","P3","P4")) 
means <- c(0,d1,d2,0)[phases]
sds <- c(sd1,sd2,sd3,sd1)[phases]
depth <- rnorm(n.obs,means, sds)
# make all depths positive!
depth <- abs(depth)
mydata <- data.frame(time, depth)

# perform windowsweep
ws <- WindowSweep(mydata, "depth", time.var = "time", windowsize = 30, windowstep = 1, progress=TRUE)
plot(ws)
plot(ws, type = "flat", cluster = 6)
ChangePointSummary(ws, cluster = 6)
