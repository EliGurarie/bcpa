## Resubmission

### Update 2022-05-27

Eliminated lubridate as a dependency, placed progress bars in "interactive only" mode.  


### Update 2022-05-26

I finally understood the `require(circular)` error in GetVT.  The help file has been modified as follows:

```
if (requireNamespace("circular", quietly = TRUE)) 
   circular::rose.diag(Simp.VT$Theta, bins=24) else
     hist(Simp.VT$Theta)
```

### Update 2022-05-24

This is an resubmission of an update of an existing release.  I believe I've fixed the warnings / notes pointed out here: https://www.stats.ox.ac.uk/pub/bdr/noSuggests/bcpa.out.

I believe most of these have to do with some dependencies in the examples, notably of `circular` (fatal) and `stats` (minor).  

Otherwise, I have updated the documentation, Roxynated all of the help files, improved some key examples, and added a new vignette (for unidimensional analysis). 