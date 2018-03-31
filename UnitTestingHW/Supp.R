# DESCRIPTION:
# This is an essential function for using the t-walk algorithm since
# it checks if the parameters that represent the mean vector (mu) and
# precision matrix (A) of a multivariate normal distribution belong to
# to the support of the objective function (a posterior distribution).

# ARGUMENTS:
# th --- must be a numeric vector of length = lenght(mu) + (ncol(A)*(ncol(A)+1)/2)
# for example: in case of a bivariate normal distribution, length(mu)=2 and ncol(A)=3
# then length(th) = 2 + (2*3)/2 = 5 (degrees of freedom)

# OUTPUTS:
# TRUE --- if valid values of mu and A are contained in the vector th
# FALSE --- if one or both parameters are out of the support of the objective function

# NOTES:
# 1) Since this function is later used by the main function from the t-walk package,
# it can not include more arguments or have a different kind of output, instead,
# we fix the variables mu, A and detA as global variables when we call this function
# so we can use them later in the main code.
# 2) Variable mu.lim must be defined before using this function.
# 3) In order to make this function work for any number of dimensions, we
# must have an auxiliar variable that this function can use to split the
# entries of th in the right way.

# CODE:
Supp <- function(th)
{ 
  # Define the vector mu and the matrix A using entries from th

  # Check if entry from mu belongs to the intervals defined in the vector mu.lim

  # Test if the matrix A is positive denitite

  # If both mu and A passed the test, return TRUE
}
