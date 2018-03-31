# DESCRIPTION:
# This is an essential function for using the t-walk algorithm since
# it defines the objective function called Energy which is equals to -log(posterior).
# It defines the algebraic expression of the posterior distribution of the parameters
# of interest, mu and A, in a logaritmic scale and with a negative sign.
# The expression must be a combination of the likelihood function and the
# a priori densities.

# ARGUMENTS: see NOTES
# th --- vector that contains the current values of parameters mu and A

# OUTPUTS:
# The value of the objective function at th

# NOTES:
# This function is called right after Supp: mu, A and detA are defined,
# so th is ignored. However, this is the way we need to specify the function
# in order to be able to use the t-walk algorithm.

Energy <- function(th) 
{ 
  # define terms that come from the likelihood function
  
  # define terms the come form the a priori densities
  
  # combine the two terms and return this value
  
}
