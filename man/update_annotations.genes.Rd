\name{update_annotations.genes}
\alias{update_annotations.genes}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Update Gene Annotations
}
\description{
Update gene annotations stored in annotations.genes parameter of the params list object. See \link[dataVisEasy]{set_annotations.genes} for intially setting the annotations.
}
\usage{
update_annotations.genes(annotation, values)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{annotation}{
title of annotation to be updated or added. If already found in the colnames of the annotations.genes data frame, the previous values for that column will be replaced with the supplied values here. If not found in the colnames of the annotations.genes data frame, values will be added as a new annotation column under the name indicated.
}
  \item{values}{
values corresponding to the annotation to be updated or added.
}
}
\details{
Length of values must be equal to number of rows in original annotations.genes dataframe. See all.genes option in \link[dataVisEasy]{extractClusters} if added annotations are identifications of cluster groups.  If new or updated values should be shown in the heatmap, must rerun  \link[dataVisEasy]{set_annot_genes}. To add specific colors for the new annotations, see \link[dataVisEasy]{set_annot_cols} and \link[dataVisEasy]{update_annot_cols}
}
\value{
%%  ~Describe the value returned
%%  If it is a LIST, use
%%  \item{comp1 }{Description of 'comp1'}
%%  \item{comp2 }{Description of 'comp2'}
%% ...
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
function (annotation, values)
{
    if (annotation \%in\% colnames(annotations.genes)) {
        params$annotations.genes[, which(colnames(params$annotations.genes) ==
            annotation)] <<- values
    }
    else {
        params$annotations.genes$V1 <<- values
        colnames(params$annotations.genes)[colnames(params$annotations.genes) ==
            "V1"] <<- annotation
    }
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
