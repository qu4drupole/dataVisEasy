\name{myHeatmapByAnnotation}
\alias{myHeatmapByAnnotation}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Create a Customizable Heatmap of Expression Data while Separating the Data to be Grouped by a Specified Annotation
}
\description{
Creates a heatmap of supplied expression data with options to subset for specific genes/variables and with a variety of customizable options for aesthetics. Draws from params list object for parameters such as the range of the plotted data, the colors used. Annotations are drawn from annotations for samples/observations and annotations.genes for genes/variables both stored in the params list object(although other options are available, see below). See params for more information on these parameters and how to specify them.
}
\usage{
myHeatmapByAnnotation(data, list = NULL, exact = TRUE, groupings, groupings.gaps = NULL, groupings.genes = FALSE, groupings.genes.gaps = NULL, method = "pearson", linkage = "complete", NA.handling = "pairwise.complete.obs", clust.rows = TRUE, clust.cols = TRUE, row.groups = NA, col.groups = NA, gaps.row = TRUE, gaps.row.spec = NULL, gaps.col = TRUE, gaps.col.spec = NULL, gap.width = 1, main = NULL, order.by.gene = NULL, order.by.sample = NULL, fontsize.row = 10, fontsize.col = 10, show.rownames = T, show.colnames = F, treeheight.row = 20, treeheight.col = 20, cell.width = NA, cell.height = NA, hide.plot = FALSE, na.fix = FALSE, na.offset = 2, is.raw.Ct = FALSE, show.legend = TRUE, show.annotations = TRUE, drop.annot.levels = TRUE)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{data}{
numeric data matrix with samples/observations in the columns and genes/variables in the rows
}
  \item{list}{
character vector of genes/variables to be pulled out of the data matrix for viewing. If left as NULL, all the rownames of the supplied data matrix will be plotted
}
  \item{exact}{
whether or not to search for exact or inexact matches of 'list' in 'data'. If exact = T (default) heatmap will plot genes/variables that exactly match the list supplied. If set to FALSE, will search for inexact matches.
}
  \item{groupings}{
groupings describing how the columns should be split, must be supplied or set to FALSE if separating columns by annotation is not desired. If params$annotations have been set, can accept a character vector of length 1 to 3 referring to the annotations data frame stored in params. If character vector is of length 2 or 3, samples will be sorted by each annotation consecutively allowing a variety of organizations for samples with multiple annotations. Can also accept a named factor or a data frame where the first column of the data frame will be used for the annotations and the names and rownames of the factor and data frame respectively match the colnames of the data. In all of these cases, the order and length of the named annotations need not match that of the colnames of the data supplied. Subsetting and ordering will be done within the function. The final option is to supply an unnamed factor, in which case the annotations indicated by the factor must match the order of the colnames in the data for accurate representation. See params and set_annotations for more information.
}
  \item{groupings.gaps}{
numeric vector the same length as a character vector supplied to groupings if it points to annotations in params$annotations. The default of NULL will result in a gap in between each annotation specified. Mostly useful in scenarios where 2 or 3 levels are provided and allows flexibility in how they will be displayed. Numeric values provided also work in tandem with each other. For example a vector of c(1,1) for a supplied groupings vector of length 2 will place 1 space in between levels of the first annotation and an additional space in between levels of the second annotaiton. A vector of c(0,1) will still order the samples by the annotations as indicated but will only place gaps in between the levels of the second annotation supplied.
}
  \item{groupings.genes}{
groupings describing how the rows should be split if desired. If params$annotations.genes have been set, can accept a character vector of length 1 to 3 referring to the annotations data frame stored in params. If character vector is of length 2 or 3, genes/variables will be sorted by each annotation consecutively allowing a variety of organizations for genes with multiple annotations. Can also accept a named factor or a data frame where the first column of the data frame will be used for the annotations and the names and rownames of the factor and data frame respectively match the rownames of the data. In all of these cases, the order and length of the named annotations need not match that of the rownames of the data supplied. Subsetting and ordering will be done within the function. The final option is to supply an unnamed factor, in which case the annotations indicated by the factor must match the order of the rownames in the data for accurate representation. See params and set_annotations.genes for more information.
}
  \item{groupings.genes.gaps}{
same as groupings.gaps but corresponding to the annotations supplied in groupings.genes
}
  \item{method}{
method to be used to calculate distance matrix for clustering. Accepts values to be passed to cor() such as "pearson" (default), "spearman", and "kendall" which well then be coerced to a distance matrix or any options accepted by dist()
}
  \item{linkage}{
linkage clustering method used for clustering and to be passed to hclust().  Accepts all methods accepted by hclust()
}
  \item{NA.handling}{
how missing values should be handled in the case of correlations, passed to the "use" argument of cor()
}
  \item{clust.rows}{
should rows be clustered, default = TRUE. When TRUE, rows will be clustered within each annotation
}
  \item{clust.cols}{
should columns be clustered, default = TRUE. When TRUE, columns will be clustered within each annotation
}
  \item{row.groups}{
numeric to be passed to cutree(). Will split the dendrogram into the number of groups indicated. Only usable if groupings.genes is not provided
}
  \item{col.groups}{
numeric to be passed to cutree(). Will split the dendrogram into the number of groups indicated. Only usable if groupings is set to FALSE
}
  \item{gaps.row}{
logical: if gaps should be inserted between annotations of rows. Can also be achieved by setting groupings.genes.gaps to 0 if referring to annotations.genes stored in params. In the case of supplied factor or dataframe, gaps will be placed between each level of the annotation unless set to FALSE
}
  \item{gaps.row.spec}{
option to specify and override the gaps inserted in between the annotations in the rows. Numeric vector indicating specific placements of gaps along the rows
}
  \item{gaps.col}{
logical: if gaps should be inserted between annotations of columns. Can also be achieved by setting groupings.gaps to 0 if referring to annotations stored in params. In the case of supplied factor or dataframe, gaps will be placed between each level of the annotation unless set to FALSE
}
  \item{gaps.col.spec}{
option to specify and override the gaps inserted in between the annotations in the columns. Numeric vector indicating specific placements of gaps along the columns
}
  \item{gap.width}{
numeric indicating the width of gaps along both rows and columns. Works in tandem with both gaps.row.spec/gaps.col.spec and groupings.gaps/groupings.genes.gaps where the indicated gaps from the previous arguments will be widened by the factor indicated.
}
  \item{main}{
title of heatmap. Default will display "Genes of Interest:" followed by the genes supplied in the list argument
}
  \item{order.by.gene}{
optional character equal to one of the rownames of the data to order the columns of the data by increasing levels of indicated row. If groupings is supplied, each group of the annotations will be ordered by the supplied gene.
}
  \item{order.by.sample}{
optional character equal to one of the colnames of the data to order the rows of the data by increasing levels of indicated column. If groupings.genes is supplied, each group of the row annotaitons will be ordered by the supplied sample.
}
  \item{fontsize.row}{
size of font for row names
}
  \item{fontsize.col}{
size of font for column names
}
  \item{show.rownames}{
logical: value determining if rownames should be displayed, default = TRUE
}
  \item{show.colnames}{
logical: value determining if colnames should be displayed, default = FALSE
}
  \item{treeheight.row}{
the height of a dendrogram tree for rows, if these are clustered. Default value 20 points.
}
  \item{treeheight.col}{
the height of a dendrogram tree for columns if these are clustered. Default value 20 points.
}
  \item{cell.width}{
individual cell width in points. If left as NA, then the values depend on the size of plotting window.
}
  \item{cell.height}{
individual cell height in points. If left as NA, then the values depend on the size of plotting window.
}
  \item{hide.plot}{
should the plot be displayed
}
  \item{na.fix}{
logical: should missing values be treated as NA or be set to a low value (see na.offset). Values will still be colored gray in heatmap but may aid in clustering when many missing values are present.
}
  \item{na.offset}{
option to treat missing/NA values as an offset from the minimum value. Ex a value of 2 will set missing values to min(data) - 2. Values will still be colored gray in heatmap but may aid in clustering when many missing values are present.
}
  \item{is.raw.Ct}{
logical. If set to TRUE, will reverse the scale of the data to indicate low values as high expression as in the case of raw Ct values from qPCR, in this case, missing values will also be set to a high value to reflect low expression level.
}
  \item{show.legend}{
logical: should legend be shown
}
  \item{show.annotations}{
logical: should annotation legend be shown
}
  \item{drop.annot.levels}{
logial: should annotations not included in the output heatmap be shown in the annotation legend.
}
}
\details{
This function utilizes pheatmap to display a heatmap of supplied data with the options to group both samples and genes by any annotations attributed to them. User can specify the genes/variables to be displayed in the heatmap which will be subset within the function itself. All samples/observations supplied will be plotted. myHeatmapByAnnotation() draws many of its parameters from the params object. params$scale.range indiates the range of data to be displayed in the heatmap. Values outside this range will be squished to fit this range after clustering where values above will be indicated with the highest expression levels and values below will be indicated with the lowest expression level. params$scale.colors holds the colors used in the heatmap and params$n.colors.range is a numeric value indicating how many diffrent colors should be allowed. For both groupings and groupings.genes, the function will refer to annotations and annotations.genes respectively within the params object. Subset of the annotations present in annot_samps and annot_genes within the params object indicate which annotations should be present along the top and left side of the heatmap.If the colors corresponding to the levels of these annotations are specified in params$annot_cols, the inicated colors will be used, if not supplied, defualt colors will be assigned to show the annotation levels. For more information on the setting of parameters found in the params list object, see params and the associated functions to set and update these values with set_'parameter' where 'parameter' is equal to any of the above parameters listed above.A subtitle for the heatmap indicates the method for clustering/creation of a distance matrix and the linkage method used for clustering.

For more details on how the groupings and groupings.genes as well as the corresponding gaps are created from an input of a character vector pointing to annotations and annotations.genes stored in the params list object, see \link[dataVisEasy]{makefactorgroup}
}
\value{
a pheatmap object
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
See \link[dataVisEasy]{params}, \link[dataVisEasy]{set_scale.range}, \link[dataVisEasy]{set_scale.colors}, \link[dataVisEasy]{set_n.colors.range},\link[dataVisEasy]{set_annotations}, \link[dataVisEasy]{set_annotations.genes}, \link[dataVisEasy]{set_annot_samps}, \link[dataVisEasy]{set_annot_genes}, and \link[dataVisEasy]{set_annot_cols} for more information on setting up annotations and associated colors.
}
\examples{
##---- Should be DIRECTLY executable !! ----
##-- ==>  Define data, use random,
##--	or do  help(data=index)  for the standard data sets.

## The function is currently defined as
function (data, list = NULL, exact = TRUE, groupings, groupings.gaps = NULL,
    groupings.genes = FALSE, groupings.genes.gaps = NULL, method = "pearson",
    linkage = "complete", NA.handling = "pairwise.complete.obs",
    clust.rows = TRUE, clust.cols = TRUE, row.groups = NA, col.groups = NA,
    gaps.row = TRUE, gaps.row.spec = NULL, gaps.col = TRUE, gaps.col.spec = NULL,
    gap.width = 1, main = NULL, order.by.gene = NULL, order.by.sample = NULL,
    fontsize.row = 10, fontsize.col = 10, show.rownames = T,
    show.colnames = F, treeheight.row = 20, treeheight.col = 20,
    cell.width = NA, cell.height = NA, hide.plot = FALSE, na.fix = FALSE,
    na.offset = 2, is.raw.Ct = FALSE, show.legend = TRUE, show.annotations = TRUE,
    drop.annot.levels = TRUE)
{
    if (is.null(main) == TRUE) {
        main <- paste("Genes of Interest:", paste(list, collapse = ","))
    }
    if (is.null(list) == TRUE) {
        list <- rownames(data)
    }
    if (exact == TRUE) {
        data.subset <- as.matrix(data[which(rownames(data) \%in\%
            list), ])
        colnames(data.subset) <- colnames(data)
        if (length(data.subset) == 0) {
            stop("exact matches for list not found in rownames data")
        }
    }
    else {
        data.subset <- as.matrix(data[grep(paste(list, collapse = "|"),
            rownames(data)), ])
        colnames(data.subset) <- colnames(data)
        if (length(data.subset) == 0) {
            stop("exact matches for list not found in rownames data")
        }
    }
    suppressWarnings(if (is.na(params$annotations) == FALSE) {
        if (sum(colnames(data.subset) \%notin\% rownames(params$annotations)) !=
            0) {
            stop("colnames of input data do not match rownames of annotations, cannot link annotations to data")
        }
        temp.annotations <- params$annotations[match(colnames(data.subset),
            rownames(params$annotations)), , drop = FALSE]
    })
    suppressWarnings(if (is.na(params$annotations.genes) == FALSE) {
        if (sum(rownames(data.subset) \%notin\% rownames(params$annotations.genes)) !=
            0) {
            stop("rownames of input data do not match rownames of annotations.genes, cannot link annotations to data")
        }
        temp.annotations.genes <- params$annotations.genes[match(rownames(data.subset),
            rownames(params$annotations.genes)), , drop = FALSE]
    })
    if (class(groupings) == "character") {
        if (sum(groupings \%notin\% colnames(temp.annotations)) !=
            0) {
            stop("supplied character vector for groupings not found in sample annotations")
        }
        factorgroupings <- makefactorgroup(temp.annotations,
            groupings, specify.gaps = groupings.gaps, return.gaps = TRUE)
        groupings <- factorgroupings$factor.group
        gaps.groupings <- c(factorgroupings$gaps)
    }
    else {
        if (class(groupings) == "data.frame") {
            groupings <- droplevels(groupings[match(colnames(data.subset),
                rownames(groupings)), 1]) \%>\% as.factor()
            if (sum(is.na(groupings) != 0)) {
                groupings <- as.character(groupings)
                groupings[is.na(groupings)] <- "No_Annot"
                groupings <- as.factor(groupings)
            }
        }
        if (class(groupings) == "factor") {
            if (is.null(names(groupings)) == FALSE) {
                groupings <- droplevels(groupings[match(colnames(data.subset),
                  names(groupings))]) \%>\% as.factor()
                if (sum(is.na(groupings) != 0)) {
                  groupings <- as.character(groupings)
                  groupings[is.na(groupings)] <- "No_Annot"
                  groupings <- as.factor(groupings)
                }
            }
            else {
                if (length(groupings) != ncol(data.subset)) {
                  stop("unnamed factor supplied to groupings not the same length as number of columns in data")
                }
            }
        }
    }
    if (class(groupings.genes) == "character") {
        if (sum(groupings.genes \%notin\% colnames(temp.annotations.genes)) !=
            0) {
            stop("supplied character vector for groupings.genes not found in gene annotations")
        }
        factorgroupings.genes <- makefactorgroup(temp.annotations.genes,
            groupings.genes, specify.gaps = groupings.genes.gaps,
            return.gaps = TRUE)
        groupings.genes <- factorgroupings.genes$factor.group
        gaps.groupings.genes <- c(factorgroupings.genes$gaps)
    }
    else {
        if (class(groupings.genes) == "data.frame") {
            groupings.genes <- droplevels(groupings.genes[match(rownames(data.subset),
                rownames(groupings.genes)), 1]) \%>\% as.factor()
            if (sum(is.na(groupings.genes) != 0)) {
                groupings.genes <- as.character(groupings.genes)
                groupings.genes[is.na(groupings.genes)] <- "No_Annot"
                groupings.genes <- as.factor(groupings.genes)
            }
        }
        if (class(groupings.genes) == "factor") {
            if (is.null(names(groupings.genes)) == FALSE) {
                groupings.genes <- droplevels(groupings.genes[match(rownames(data.subset),
                  names(groupings.genes))]) \%>\% as.factor()
                if (sum(is.na(groupings.genes) != 0)) {
                  groupings.genes <- as.character(groupings.genes)
                  groupings.genes[is.na(groupings.genes)] <- "No_Annot"
                  groupings.genes <- as.factor(groupings.genes)
                }
            }
            else {
                if (length(groupings.genes) != nrow(data.subset)) {
                  stop("unnamed factor supplied to groupings.genes not the same length as number of rows from data or number of rows after subsetting for supplied list")
                }
            }
        }
    }
    if (na.fix == TRUE) {
        if (is.raw.Ct == TRUE) {
            data.subset[which(is.na(data.subset))] <- max(data,
                na.rm = T) + na.offset
        }
        if (is.raw.Ct == FALSE) {
            data.subset[which(is.na(data.subset))] <- min(data,
                na.rm = T) - na.offset
        }
    }
    if (is.null(order.by.gene) == FALSE) {
        if ((order.by.gene \%in\% rownames(data.subset)) == FALSE) {
            order.by.gene <- NULL
        }
    }
    if (is.null(order.by.sample) == FALSE) {
        if ((order.by.sample \%in\% colnames(data.subset)) == FALSE) {
            order.by.sample <- NULL
        }
    }
    if (sum(groupings != FALSE, na.rm = T) != 0) {
        ind.col = 0
        gaps.col.n = NULL
        samp.order <- NULL
        for (i in 1:length(unique(groupings))) {
            subset <- as.matrix(data.subset[, which(groupings ==
                levels(groupings)[i])])
            colnames(subset) <- colnames(data.subset)[which(groupings ==
                levels(groupings)[i])]
            if (ncol(subset) > 1) {
                if (clust.cols == TRUE) {
                  if (method \%in\% c("spearman", "pearson", "kendall")) {
                    clust.samps <- (as.dist(1 - cor(subset, method = method,
                      use = NA.handling)))
                  }
                  if (method \%in\% c("euclidean", "maximum", "manhattan",
                    "canberra", "binary", "minkowski")) {
                    clust.samps <- dist(t(subset), method = method)
                  }
                  tryclustcols <- try(hclust(clust.samps, linkage),
                    silent = T)
                  if (class(tryclustcols) == "try-error") {
                    stop("cannot cluster columns, if too many NAs present, set na.fix = T to treat NA values as low expression instead of missing, otherwise set clust.cols = F or specify order.by.gene")
                  }
                  a <- hclust(clust.samps, method = linkage)
                  samp.order <- c(samp.order, a$labels[a$order])
                }
                if (clust.cols == FALSE) {
                  samp.order <- c(samp.order, colnames(subset))
                }
            }
            if (ncol(subset) == 1) {
                samp.order <- c(samp.order, colnames(data.subset)[which(groupings ==
                  levels(groupings)[i])])
            }
            if (is.null(order.by.gene) == FALSE) {
                if (is.raw.Ct == FALSE) {
                  subset <- subset[, order(subset[which(rownames(subset) \%in\%
                    order.by.gene), ], na.last = F)]
                }
                if (is.raw.Ct == TRUE) {
                  subset <- subset[, order(subset[which(rownames(subset) \%in\%
                    order.by.gene), ], na.last = T)]
                }
                clust.cols <- F
            }
            if (i == 1) {
                combined <- subset
            }
            if (i != 1) {
                combined <- cbind(combined, subset)
            }
            if (exists("factorgroupings") == FALSE) {
                if (gaps.col == TRUE) {
                  ind.col <- ind.col + ncol(subset)
                  gaps.col.n <- c(gaps.col.n, ind.col)
                }
            }
        }
        if (is.null(order.by.gene) == TRUE) {
            combined <- combined[, samp.order]
        }
        if (sum(groupings.genes == FALSE, na.rm = T) != 0) {
            if (is.null(order.by.sample) == FALSE) {
                if (is.raw.Ct == FALSE) {
                  combined <- combined[order(combined[, which(colnames(combined) \%in\%
                    order.by.sample)], na.last = F), ]
                }
                if (is.raw.Ct == TRUE) {
                  combined <- combined[order(combined[, which(colnames(combined) \%in\%
                    order.by.sample)], na.last = T), ]
                }
                clust.rows <- F
            }
            else {
                if (method \%in\% c("spearman", "pearson", "kendall")) {
                  clust.genes <- (as.dist(1 - cor(t(combined),
                    method = method, use = NA.handling)))
                }
                if (method \%in\% c("euclidean", "maximum", "manhattan",
                  "canberra", "binary", "minkowski")) {
                  clust.genes <- dist((combined), method = method)
                }
            }
            gaps.row <- NULL
        }
        if (gaps.col == TRUE) {
            if (exists("factorgroupings") == FALSE) {
                gaps.col <- gaps.col.n[-length(gaps.col.n)]
            }
            else {
                gaps.col <- gaps.groupings
            }
            gaps.col <- sort(rep(gaps.col, gap.width))
        }
        clust.cols <- F
        data.subset <- combined
    }
    if (sum(groupings.genes != FALSE, na.rm = T) != 0) {
        ind.row = 0
        gaps.row.n = NULL
        gene.order <- NULL
        for (i in 1:length(unique(groupings.genes))) {
            subset <- as.matrix(data.subset[which(groupings.genes ==
                levels(groupings.genes)[i]), ])
            if (ncol(subset) > 1) {
                rownames(subset) <- rownames(data.subset)[which(groupings.genes ==
                  levels(groupings.genes)[i])]
                if (clust.rows == TRUE) {
                  if (method \%in\% c("spearman", "pearson", "kendall")) {
                    clust.genes <- (as.dist(1 - cor(t(subset),
                      method = method, use = NA.handling)))
                  }
                  if (method \%in\% c("euclidean", "maximum", "manhattan",
                    "canberra", "binary", "minkowski")) {
                    clust.genes <- dist((subset), method = method)
                  }
                  tryclustrows <- try(hclust(clust.genes, linkage),
                    silent = T)
                  if (class(tryclustrows) == "try-error") {
                    stop("cannot cluster rows, if too many NAs present, set na.fix = T to treat NA values as low expression instead of missing, otherwise set clust.rows = F or specify order.by.sample")
                  }
                  a <- hclust(clust.genes, linkage)
                  gene.order <- c(gene.order, a$labels[a$order])
                }
                if (clust.rows == FALSE) {
                  gene.order <- c(gene.order, rownames(subset))
                }
            }
            if (ncol(subset) == 1) {
                colnames(subset) <- rownames(data.subset)[which(groupings.genes ==
                  levels(groupings.genes)[i])]
                gene.order <- c(gene.order, colnames(subset))
                subset <- t(subset)
            }
            if (is.null(order.by.sample) == FALSE) {
                if (nrow(subset) > 1) {
                  if (is.raw.Ct == FALSE) {
                    subset <- subset[order(subset[, which(colnames(subset) \%in\%
                      order.by.sample)], na.last = F), ]
                  }
                  if (is.raw.Ct == TRUE) {
                    subset <- subset[order(subset[, which(colnames(subset) \%in\%
                      order.by.sample)], na.last = T), ]
                  }
                  clust.rows <- F
                }
            }
            if (i == 1) {
                combined <- subset
            }
            if (i != 1) {
                combined <- rbind(combined, subset)
            }
            if (exists("factorgroupings.genes") == FALSE) {
                if (gaps.row == TRUE) {
                  ind.row <- ind.row + nrow(subset)
                  gaps.row.n <- c(gaps.row.n, ind.row)
                }
            }
        }
        if (is.null(order.by.sample) == TRUE) {
            combined <- combined[gene.order, ]
        }
        if (sum(groupings == FALSE, na.rm = T) != 0) {
            if (is.null(order.by.gene) == FALSE) {
                if (is.raw.Ct == FALSE) {
                  combined <- combined[, order(combined[which(rownames(combined) \%in\%
                    order.by.gene), ], na.last = F)]
                }
                if (is.raw.Ct == TRUE) {
                  combined <- combined[, order(combined[which(rownames(combined) \%in\%
                    order.by.gene), ], na.last = T)]
                }
                clust.cols <- F
            }
            else {
                if (method \%in\% c("spearman", "pearson", "kendall")) {
                  clust.samps <- (as.dist(1 - cor(combined, method = method,
                    use = NA.handling)))
                }
                if (method \%in\% c("euclidean", "maximum", "manhattan",
                  "canberra", "binary", "minkowski")) {
                  clust.samps <- dist(t(combined), method = method)
                }
            }
            gaps.col <- NULL
        }
        if (gaps.row == TRUE) {
            if (exists("factorgroupings.genes") == FALSE) {
                gaps.row <- gaps.row.n[-length(gaps.row.n)]
            }
            else {
                gaps.row <- gaps.groupings.genes
            }
            gaps.row <- sort(rep(gaps.row, gap.width))
        }
        clust.rows <- F
        data.subset <- combined
    }
    if (is.null(gaps.col.spec) == FALSE) {
        gaps.col <- gaps.col.spec
        gaps.col <- sort(rep(gaps.col, gap.width))
    }
    if (is.null(gaps.row.spec) == FALSE) {
        gaps.row <- gaps.row.spec
        gaps.row <- sort(rep(gaps.row, gap.width))
    }
    if (clust.rows == T) {
        heightrow <- treeheight.row
    }
    if (clust.cols == T) {
        heightcol <- treeheight.col
    }
    data.subset1 <- data.subset
    data.subset <- scales::squish(data.subset, params$scale.range)
    breaks <- seq(params$scale.range[1], params$scale.range[2],
        length.out = params$n.colors.range)
    my_cols = colorRampPalette(params$scale.colors)(n = params$n.colors.range -
        1)
    if (is.raw.Ct == TRUE) {
        my_cols <- rev(my_cols)
    }
    if (na.fix == TRUE) {
        if (is.raw.Ct == TRUE) {
            data.subset[which(data.subset1 == max(data.subset1))] <- params$scale.range[2] +
                0.04
            breaks <- c(breaks, params$scale.range[2] + 0.01,
                params$scale.range[2] + 0.05)
            my_cols <- c(my_cols, params$scale.colors[1], "grey90")
        }
        if (is.raw.Ct == FALSE) {
            data.subset[which(data.subset1 == min(data.subset1))] <- params$scale.range[1] -
                0.04
            breaks <- c(params$scale.range[1] - 0.05, params$scale.range[1] -
                0.01, breaks)
            my_cols <- c("grey90", params$scale.colors[1], my_cols)
        }
    }
    temp.annot_samps <- params$annot_samps
    temp.annot_genes <- params$annot_genes
    temp.annot_cols <- params$annot_cols
    if (drop.annot.levels == TRUE) {
        suppressWarnings(if (is.na(temp.annot_samps) == F) {
            temp.annot_samps[] <- lapply(temp.annot_samps, as.factor)
            temp.annot_samps <- temp.annot_samps \%>\% tibble::rownames_to_column("Sample")
            temp.annot_samps <- droplevels(temp.annot_samps[which(temp.annot_samps$Sample \%in\%
                colnames(data.subset)), ]) \%>\% as.data.frame() \%>\%
                tibble::remove_rownames() \%>\% tibble::column_to_rownames(var = "Sample")
            spec.cols <- colnames(temp.annot_samps)[colnames(temp.annot_samps) \%in\%
                names(temp.annot_cols)]
            if (length(spec.cols) != 0) {
                for (annot.i in 1:length(spec.cols)) {
                  annot <- colnames(temp.annot_samps)[annot.i]
                  temp.annot_cols[[which(names(temp.annot_cols) ==
                    annot)]] <- temp.annot_cols[[which(names(temp.annot_cols) ==
                    annot)]][which(names(temp.annot_cols[[which(names(temp.annot_cols) ==
                    annot)]]) \%in\% levels(temp.annot_samps[,
                    which(colnames(temp.annot_samps) == annot)]))]
                }
            }
        })
        suppressWarnings(if (is.na(params$annot_genes) == F) {
            temp.annot_genes[] <- lapply(temp.annot_genes, as.factor)
            temp.annot_genes <- temp.annot_genes \%>\% tibble::rownames_to_column("Gene")
            temp.annot_genes <- droplevels(temp.annot_genes[which(temp.annot_genes$Gene \%in\%
                rownames(data.subset)), ]) \%>\% as.data.frame() \%>\%
                tibble::remove_rownames() \%>\% tibble::column_to_rownames(var = "Gene")
            spec.cols <- colnames(temp.annot_samps)[colnames(temp.annot_genes) \%in\%
                names(temp.annot_cols)]
            if (length(spec.cols) != 0) {
                for (annot.i in 1:length(colnames(temp.annot_genes))) {
                  annot <- colnames(temp.annot_genes)[annot.i]
                  temp.annot_cols[[which(names(temp.annot_cols) ==
                    annot)]] <- temp.annot_cols[[which(names(temp.annot_cols) ==
                    annot)]][which(names(temp.annot_cols[[which(names(temp.annot_cols) ==
                    annot)]]) \%in\% levels(temp.annot_genes[,
                    which(colnames(temp.annot_genes) == annot)]))]
                }
            }
        })
    }
    if (clust.cols == T) {
        tryclustcols <- try(hclust(clust.samps, linkage), silent = T)
        if (class(tryclustcols) == "try-error") {
            stop("cannot cluster columns, if too many NAs present, set na.fix = T to treat NA values as low expression instead of missing, otherwise set clust.cols = F or specify order.by.gene")
        }
    }
    if (clust.rows == T) {
        tryclustrows <- try(hclust(clust.genes, linkage), silent = T)
        if (class(tryclustrows) == "try-error") {
            stop("cannot cluster rows, if too many NAs present, set na.fix = T to treat NA values as low expression instead of missing, otherwise set clust.rows = F or specify order.by.sample")
        }
    }
    pheatmap(data.subset, col = my_cols, breaks = breaks, border_color = NA,
        clustering_method = linkage, annotation_col = temp.annot_samps,
        annotation_colors = temp.annot_cols, clustering_distance_rows = clust.genes,
        clustering_distance_cols = clust.samps, main = paste(main,
            "\n Method_", method, "_Linkage_", linkage), cluster_rows = clust.rows,
        cluster_cols = clust.cols, cutree_rows = row.groups,
        cutree_cols = col.groups, gaps_row = gaps.row, gaps_col = gaps.col,
        fontsize_row = fontsize.row, fontsize_col = fontsize.col,
        cellwidth = cell.width, cellheight = cell.height, show_rownames = show.rownames,
        show_colnames = show.colnames, treeheight_row = heightrow,
        treeheight_col = heightcol, silent = hide.plot, legend = show.legend,
        annotation_legend = show.annotations, annotation_row = temp.annot_genes,
        drop_levels = drop.annot.levels)
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
