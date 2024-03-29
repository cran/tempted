% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/TEMPTED.R
\name{bernoulli_kernel}
\alias{bernoulli_kernel}
\title{Caculate the Bernoulli kernel}
\usage{
bernoulli_kernel(x, y)
}
\arguments{
\item{x, y}{Two values between which the Bernoulli kernel is calculated.}
}
\value{
The calculated kernel between \code{x} and \code{y}.
}
\description{
This function is used to calculate the kernel matrix for the
RKHS regression that iteratively updates the temporal loading function.
}
\references{
Han, R., Shi, P. and Zhang, A.R. (2023) \emph{Guaranteed functional tensor singular value decomposition}. Journal of the American Statistical Association, pp.1-13. doi: 10.1080/01621459.2022.2153689.
}
