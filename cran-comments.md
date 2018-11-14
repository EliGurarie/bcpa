## Resubmission

This is an resubmission of an update of an existing release.  I believe I've fixed the warnings / notes pointed out here: https://win-builder.r-project.org/incoming_pretest/180216_072546_bcpa_12/00check.log.  Specifically:

- removed line-breaks in some plotting files which I think caused the following: `Warning in plot.xy(xy.coords(x, y), type = type, ...) : plot type 'black' will be truncated to first character` 

- added `digest` to "Suggests", to address: `WARNING: You used a knitr feature that depends on the digest package`

Other minor tweaks and corrections. 