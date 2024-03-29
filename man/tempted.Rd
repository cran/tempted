% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/TEMPTED.R
\name{tempted}
\alias{tempted}
\title{Decomposition of temporal tensor}
\usage{
tempted(
  datlist,
  r = 3,
  smooth = 1e-06,
  interval = NULL,
  resolution = 101,
  maxiter = 20,
  epsilon = 1e-04
)
}
\arguments{
\item{datlist}{A length n list of matrices.
Each matrix represents a subject,
with columns representing samples from this subject,
the first row representing the sampling time points,
and the following rows representing the feature values.}

\item{r}{Number of components to decompose into, i.e. rank of the CP type decomposition.
Default is set to 3.}

\item{smooth}{Smoothing parameter for RKHS norm.
Larger means smoother temporal loading functions. Default is set to be 1e-8.
Value can be adjusted depending on the dataset by checking the smoothness of the estimated temporal loading function in plot.}

\item{interval}{The range of time points to ran the decomposition for.
Default is set to be the range of all observed time points.
User can set it to be a shorter interval than the observed range.}

\item{resolution}{Number of time points to evaluate the value of the temporal loading function.
Default is set to 101. It does not affect the subject or feature loadings.}

\item{maxiter}{Maximum number of iteration. Default is 20.}

\item{epsilon}{Convergence criteria for difference between iterations. Default is 1e-4.}
}
\value{
The estimations of the loadings.
\describe{
\item{A_hat}{Subject loading, a subject by r matrix.}
\item{B_hat}{Feature loading, a feature by r matrix.}
\item{Phi_hat}{Temporal loading function, a resolution by r matrix.}
\item{time_Phi}{The time points where the temporal loading function is evaluated.}
\item{Lambda}{Eigen value, a length r vector.}
\item{r_square}{Variance explained by each component. This is the R-squared of the linear regression of the vectorized temporal tensor against the vectorized low-rank reconstruction using individual components.}
\item{accum_r_square}{Variance explained by the first few components accumulated. This is the R-squared of the linear regression of the vectorized temporal tensor against the vectorized low-rank reconstruction using the first few components.}
}
}
\description{
This is the main function of tempted.
}
\examples{
# Take a subset of the samples so the example runs faster

# Here we are taking samples from the odd months
sub_sample <- rownames(meta_table)[(meta_table$day_of_life\%/\%12)\%\%2==1]
count_table_sub <- count_table[sub_sample,]
processed_table_sub <- processed_table[sub_sample,]
meta_table_sub <- meta_table[sub_sample,]

# for count data from longitudinal microbiome studies

datlist <- format_tempted(count_table_sub,
                          meta_table_sub$day_of_life,
                          meta_table_sub$studyid,
                          pseudo=0.5,
                          transform="clr")

mean_svd <- svd_centralize(datlist, r=1)

res_tempted <- tempted(mean_svd$datlist, r=2, smooth=1e-5)

# for preprocessed data that do not need to be transformed
\donttest{
datlist <- format_tempted(processed_table_sub,
                          meta_table_sub$day_of_life,
                          meta_table_sub$studyid,
                          pseudo=NULL,
                          transform="none")

mean_svd <- svd_centralize(datlist, r=1)

res_tempted <- tempted(mean_svd$datlist, r=2, smooth=1e-5)
}
# plot the temporal loading

plot_time_loading(res_tempted, r=2)
}
