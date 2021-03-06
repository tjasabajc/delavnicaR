# vectors ----------------------------------------------------------------------
m <- 9
x <- seq(-2, 2, length.out = m)
y <- x^2
z <- y / x
mean(z)
data.frame(x, y, z)


# data frame -------------------------------------------------------------------
names      <- c("Jeff", "Sandy", "Tom", "Patrick", "Tina", "Maria")
sex        <- c("m", "f", "m", "m", "f", "f")
height     <- c(180, 181, 177, 188, 170, 172)
weight     <- c(80, 70, 81, 100, 50, 62)
age        <- c(18, 21, 50, 35, 31, 45)

df <- data.frame(names, sex, height, weight, age)

summary(df)

df[df$sex == "f", ]

df[df$sex == "m" & df$height > 180, ]

aggregate(df$age, by = list(sex = df$sex), FUN = mean)


# functions --------------------------------------------------------------------
num_greater <- function (x, y, z) {
  return(sum(x + y > z))
}


# debugging --------------------------------------------------------------------
# Use browser() on line 9 and then iteratively inspect if the values are as
# they should be. The problem is in line 12, where there should be brackets
# around i - 1.
get_primes <- function (n_max) {
  if (n_max == 0) {
    return (NULL)
  } else if (n_max == 1) {
    return (NULL)
  } else if (n_max == 2) {
    return (2) 
  } else {
    all_primes <- c(2)
    for (i in 3:n_max) {
      is_prime <- TRUE
      for (j in 2:(i - 1)) {
        tmp <- i / j
        if (round(tmp) == tmp)
          is_prime <- FALSE
      }
      if (is_prime)
        all_primes <- c(all_primes, i)
    }
    return (all_primes)
  }
}
get_primes(10)


# matrices ---------------------------------------------------------------------
set.seed(0)
A <- matrix(rnorm(16), nrow = 4)
B <- matrix(rnorm(10), nrow = 2)
C <- matrix(rnorm(20), nrow = 5)

mean(A)

var(as.vector(A))

max(c(A,B,C))

A + t(A)

A * t(A)

B %*% C

det(t(B) %*% B)


# Fibonacci --------------------------------------------------------------------
my_fibonacci <- function (n) {
  if (n == 0) {
    return (0)
  } else if (n == 1) {
    return (c(0, 1))
  } else {
    tmp <- c(0, 1)
    for (i in 3:(n + 1)) {
      tmp[i] <- tmp[i - 1] + tmp[i - 2]
    }
    return (tmp)
  }
}
my_fibonacci(10)