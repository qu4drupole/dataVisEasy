\name{assessScale}
\alias{assessScale}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Determine how much of a datamatrix lies within a specific scale range
}
\description{
Function to assess how much of the data matrix supplied lies within the range specifies in scale.range stored in the parameters list object, specifically for heatmaps
}
\usage{
assessScale(data)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{data}{
numeric data matrix with samples/observations in the columns and genes/variables in the rows
}
}
\details{
Based off of the scale range stored in params, will calculate what proportion of the non-missing values in the data.matrix lie below, within, and above the scale.range. Helpful for determining the appropriate range of data for a heatmap
}
\value{
Printed output indicating percentage of data below, within, and above the set scale range
}
\references{
%% ~put references to the literature/web site here ~
}
\author{
~~Alison Moss~~
}
\note{
%%  ~~further notes~~
}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
%% ~~objects to See Also as \code{\link{help}}, ~~~
}
\examples{
##---- Should be DIRECTLY executable !! ----
##-- ==>  Define data, use random,
##--	or do  help(data=index)  for the standard data sets.

## The function is currently defined as
function (data)
{
    above <- sum(data > params$scale.range[2], na.rm = T)/sum(!is.na(data))
    within <- sum(data <= params$scale.range[2] & data >= params$scale.range[1],
        na.rm = T)/sum(!is.na(data))
    below <- sum(data < params$scale.range[1], na.rm = T)/sum(!is.na(data))
    report <- c(below, within, above)
    names(report) <- c("Percent Below Range", "Percent Within Range",
        "Percent Above Range")
    return(report)
  }
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory (show via RShowDoc("KEYWORDS")):
% \keyword{ ~kwd1 }
% \keyword{ ~kwd2 }
% Use only one keyword per line.
% For non-standard keywords, use \concept instead of \keyword:
% \concept{ ~cpt1 }
% \concept{ ~cpt2 }
% Use only one concept per line.
