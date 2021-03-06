\name{scatterGenes}
\alias{scatterGenes}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Create a Scatter Plot Between Two Genes
}
\description{
Creates a scatter plot between two genes within a supplied data matrix. Many customizable options to color according to expression levels or annotations.
}
\usage{
scatterGenes(data, gene1, gene2, is.raw.Ct = FALSE, na.fix = 2, color.by = "blue", custom.color.vec = FALSE, xlimits = FALSE, ylimits = FALSE, squish1 = FALSE, squish2 = FALSE, point.size = 5, transparency = 1,legend.position = "none", percent.mad = 0.5)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{data}{
numeric data matrix with samples/observations in the columns and genes/variables in the rows
}
  \item{gene1}{
first gene to be plotted, must be present in rownames of input data
}
  \item{gene2}{
second gene to be plotted, must be present in rownames of input data
}
  \item{is.raw.Ct}{
logical: If set to TRUE, will reverse the scale of the data to indicate low values as high expression as in the case of raw Ct values from qPCR, in this case, missing values will also be set to a high value to reflect low expression level.
}
  \item{na.fix}{
option to treat missing/NA values as an offset from the minimum value. Ex a value of 2 will set missing values to min(data) - 2. If coloring by a specific gene, will still be colored black. In na.fix=F missing values will be removed
}
  \item{color.by}{
How the points are colored. There are several different options that this argument can take. If set to a single color (the default, blue), all points will be colored by that color. A gene name (must be present in the rownames of the input data but need not be the genes being plotted) can be supplied where the points will be colored according to the expression level of the indicated gene, see \link[dataVisEasy]{myColorRamp5}. The name of an annotation can be provided that must match the colnames of the annotations dataframe stored in the params list object. If the colors of this annotation are also specified in annot_cols, also stored in the params list object, those colors will be used for the indicated levels of the annotation. If the colors are not provided, default colors will be used.
}
  \item{custom.color.vec}{
option to provide a custom color vector not linked to annotations or gene expression level. In this case, the order of the colors should correspond to the order of the samples/columns in the input data.
}
  \item{xlimits}{
FALSE or numerical vector of length 2. Default of FALSE will allow limits to be set automatically based on the data. Supply desired limits on the x axis to override.
}
  \item{ylimits}{
FALSE or numerical vector of length 2. Default of FALSE will allow limits to be set automatically based on the data. Supply desired limits on the y axis to override.
}
  \item{squish1}{
FALSE or numerical vector of length 2. Should data corresponding to gene1 be limited to a specific range. In this case, values above and below the specified range will be set to the maximum and minimum respectively. Distinct from setting x or y limits as setting the limits will remove all points outside the specfied range. The squish option will restrict the range of the data to the specified range and will set the limits accordingly.
}
  \item{squish2}{
FALSE or numerical vector of length 2. Should data corresponding to gene2 be limited to a specific range. In this case, values above and below the specified range will be set to the maximum and minimum respectively. Distinct from setting x or y limits as setting the limits will remove all points outside the specfied range. The squish option will restrict the range of the data to the specified range and will set the limits accordingly.
}
  \item{point.size}{
size of points to be plotted
}
  \item{transparency}{
transparency or alpha value of the points
}
  \item{legend.position}{
should the legend be shown and if so where should it be placed. No legend will be shown if colored by gene or a custom color vector is supplied.
}
  \item{percent.mad}{
if coloring points by expression level. Passed to \link[dataVisEasy]{myColorRamp5} to determine how the data is binned
}
}
\details{
A scatter plot will be generated from the input data for the two genes provided. Options to color the plotted points are most easily acheived through use of the annotations dataframe stored in the params list object (although this is not necessary and custom color can be provided as well as coloring by a single color or by expression level). See \link[dataVisEasy]{params}, \link[dataVisEasy]{set_annotations}, and \link[dataVisEasy]{set_annot_cols} for more information on setting up annotations.
}
\value{
A ggplot object. Additional layers can be added to the returned ggplot object to further customize theme and aesthetics.
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
For more information on customizing the returned ggplot object, please see ggplot2 helpfiles, specifically those related to setting the theme.

See \link[dataVisEasy]{params}, \link[dataVisEasy]{set_annotations}, and \link[dataVisEasy]{set_annot_cols} for more information on setting up annotations and associated colors.
}
\examples{
##---- Should be DIRECTLY executable !! ----
##-- ==>  Define data, use random,
##--	or do  help(data=index)  for the standard data sets.

## The function is currently defined as
function (data, gene1, gene2, is.raw.Ct = FALSE, na.fix = 2,
    color.by = "blue", custom.color.vec = FALSE, xlimits = FALSE,
    ylimits = FALSE, squish1 = FALSE, squish2 = FALSE, point.size = 5,
    legend.position = "none", percent.mad = 0.5)
{
    if (gene1 \%notin\% rownames(data)) {
        stop("gene1 not found in rownames data")
    }
    if (gene2 \%notin\% rownames(data)) {
        stop("gene2 not found in rownames data")
    }
    dat1 <- data[which(rownames(data) \%in\% gene1), ]
    if (is.raw.Ct == F & na.fix != F) {
        dat1[which(is.na(dat1))] <- (min(dat1, na.rm = T) - na.fix)
    }
    if (is.raw.Ct == T & na.fix != F) {
        dat1[which(is.na(dat1))] <- (max(dat1, na.rm = T) + na.fix)
    }
    dat2 <- data[which(rownames(data) \%in\% gene2), ]
    if (is.raw.Ct == F & na.fix != F) {
        dat2[which(is.na(dat2))] <- (min(dat2, na.rm = T) - na.fix)
    }
    if (is.raw.Ct == T & na.fix != F) {
        dat2[which(is.na(dat2))] <- (max(dat2, na.rm = T) + na.fix)
    }
    temp.annotations <- params$annotations
    dat.to.plot <- data.frame(Gene1 = dat1, Gene2 = dat2)
    dat.to.plot <- cbind(dat.to.plot, temp.annotations)
    if (color.by \%in\% rownames(data) | sum(custom.color.vec !=
        FALSE) > 0) {
        if (color.by \%in\% rownames(data)) {
            genedat <- data[which(rownames(data) == color.by),
                ]
            cols <- myColorRamp5(params$expression_gradient.colors,
                genedat, percent.mad = percent.mad)
        }
        else {
            cols <- custom.color.vec
        }
        if (((xlimits == FALSE) && (ylimits == FALSE)) == TRUE) {
            suppressWarnings(if (squish1 != FALSE) {
                dat.to.plot$Gene1 <- scales::squish(dat.to.plot$Gene1,
                  squish1)
            })
            suppressWarnings(if (squish2 != FALSE) {
                dat.to.plot$Gene2 <- scales::squish(dat.to.plot$Gene2,
                  squish2)
            })
            if (is.raw.Ct == T) {
                p <- ggplot(dat.to.plot, aes(x = Gene1, y = Gene2,
                  fill = cols)) + geom_point(pch = 21, color = "black",
                  size = 5) + scale_fill_identity() + labs(x = paste(gene1),
                  y = paste(gene2)) + ggtitle(paste(gene2, "vs.",
                  gene1)) + theme_bw() + theme(panel.grid = element_blank(),
                  plot.title = element_text(hjust = 0.5, size = 40),
                  axis.text = element_text(size = 25), axis.title = element_text(size = 30),
                  legend.position = legend.position) + scale_x_reverse() +
                  scale_y_reverse()
            }
            else {
                p <- ggplot(dat.to.plot, aes(x = Gene1, y = Gene2,
                  fill = cols)) + geom_point(pch = 21, color = "black",
                  size = 5) + scale_fill_identity() + labs(x = paste(gene1),
                  y = paste(gene2)) + ggtitle(paste(gene2, "vs.",
                  gene1)) + theme_bw() + theme(panel.grid = element_blank(),
                  plot.title = element_text(hjust = 0.5, size = 40),
                  axis.text = element_text(size = 25), axis.title = element_text(size = 30),
                  legend.position = legend.position)
            }
        }
        if ((xlimits || ylimits) == TRUE) {
            if (is.raw.Ct == T) {
                p <- ggplot(dat.to.plot, aes(x = Gene1, y = Gene2,
                  fill = cols)) + geom_point(pch = 21, color = "black",
                  size = 5) + scale_fill_identity() + labs(x = paste(gene1),
                  y = paste(gene2)) + ggtitle(paste(gene2, "vs.",
                  gene1)) + theme_bw() + theme(panel.grid = element_blank(),
                  plot.title = element_text(hjust = 0.5, size = 40),
                  axis.text = element_text(size = 25), axis.title = element_text(size = 30),
                  legend.position = legend.position) + xlim(c(xlimits)) +
                  ylim(c(ylimits))
            }
            else {
                p <- ggplot(dat.to.plot, aes(x = Gene1, y = Gene2,
                  fill = cols)) + geom_point(pch = 21, color = "black",
                  size = 5) + scale_fill_identity() + labs(x = paste(gene1),
                  y = paste(gene2)) + ggtitle(paste(gene2, "vs.",
                  gene1)) + theme_bw() + theme(panel.grid = element_blank(),
                  plot.title = element_text(hjust = 0.5, size = 40),
                  axis.text = element_text(size = 25), axis.title = element_text(size = 30),
                  legend.position = legend.position) + xlim(c(xlimits)) +
                  ylim(c(ylimits))
            }
        }
    }
    else {
        if (color.by \%in\% colnames(temp.annotations)) {
            if (sum(colnames(data) \%notin\% rownames(temp.annotations)) !=
                0) {
                stop("colnames of input data do not match rownames of annotations, cannot link annotations to data")
            }
            temp.annotations <- temp.annotations[match(colnames(data),
                rownames(temp.annotations)), , drop = FALSE]
            if (color.by \%in\% names(params$annot_cols)) {
                cols <- as.factor(dat.to.plot[, which(colnames(dat.to.plot) ==
                  color.by)])
                colors <- params$annot_cols[[which(names(params$annot_cols) ==
                  color.by)]]
            }
            else {
                cols <- as.factor(pca.data[, which(colnames(pca.data) ==
                  color.by)])
                colors <- hue_pal()(length(levels(cols)))
            }
        }
        else {
            cols <- color.by
            colors <- color.by
        }
        if (((xlimits == FALSE) && (ylimits == FALSE)) == TRUE) {
            suppressWarnings(if (squish1 != FALSE) {
                dat.to.plot$Gene1 <- scales::squish(dat.to.plot$Gene1,
                  squish1)
            })
            suppressWarnings(if (squish2 != FALSE) {
                dat.to.plot$Gene2 <- scales::squish(dat.to.plot$Gene2,
                  squish2)
            })
            if (is.raw.Ct == T) {
                p <- ggplot(dat.to.plot, aes(x = Gene1, y = Gene2,
                  fill = cols)) + geom_point(pch = 21, color = "black",
                  size = point.size) + scale_fill_manual(values = colors) +
                  labs(x = paste(gene1), y = paste(gene2)) +
                  ggtitle(paste(gene2, "vs.", gene1)) + theme_bw() +
                  theme(panel.grid = element_blank(), plot.title = element_text(hjust = 0.5,
                    size = 40), axis.text = element_text(size = 25),
                    axis.title = element_text(size = 30), legend.position = legend.position) +
                  scale_x_reverse() + scale_y_reverse()
            }
            else {
                p <- ggplot(dat.to.plot, aes(x = Gene1, y = Gene2,
                  fill = cols)) + geom_point(pch = 21, color = "black",
                  size = point.size) + scale_fill_manual(values = colors) +
                  labs(x = paste(gene1), y = paste(gene2)) +
                  ggtitle(paste(gene2, "vs.", gene1)) + theme_bw() +
                  theme(panel.grid = element_blank(), plot.title = element_text(hjust = 0.5,
                    size = 40), axis.text = element_text(size = 25),
                    axis.title = element_text(size = 30), legend.position = legend.position)
            }
        }
        if ((xlimits || ylimits) == TRUE) {
            if (is.raw.Ct == T) {
                p <- ggplot(dat.to.plot, aes(x = Gene1, y = Gene2,
                  fill = cols)) + geom_point(pch = 21, color = "black",
                  size = point.size) + scale_fill_manual(values = colors) +
                  labs(x = paste(gene1), y = paste(gene2)) +
                  ggtitle(paste(gene2, "vs.", gene1)) + theme_bw() +
                  theme(panel.grid = element_blank(), plot.title = element_text(hjust = 0.5,
                    size = 40), axis.text = element_text(size = 25),
                    axis.title = element_text(size = 30), legend.position = legend.position) +
                  xlim(c(xlimits)) + ylim(c(ylimits))
            }
            else {
                p <- ggplot(dat.to.plot, aes(x = Gene1, y = Gene2,
                  fill = cols)) + geom_point(pch = 21, color = "black",
                  size = point.size) + scale_fill_manual(values = colors) +
                  labs(x = paste(gene1), y = paste(gene2)) +
                  ggtitle(paste(gene2, "vs.", gene1)) + theme_bw() +
                  theme(panel.grid = element_blank(), plot.title = element_text(hjust = 0.5,
                    size = 40), axis.text = element_text(size = 25),
                    axis.title = element_text(size = 30), legend.position = legend.position) +
                  xlim(c(xlimits)) + ylim(c(ylimits))
            }
        }
    }
    return(p)
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
