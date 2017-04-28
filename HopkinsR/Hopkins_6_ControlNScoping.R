rm(list = ls())

# control
########################################################################
#if-else
if(x >3){
        y <- 10
}else{
        y <- 0
}

y <- if(x > 3){
        10
}else{
        0
}

#for-loop
for (i in 1:10){
        print(i)
}

x <- c("a", "b","c","d")

for(i in 1:4){
        print(x[i])
}

#!! seq_along
for(i in seq_along(x)){
        print(x[i])
}

for(letter in x){
        print(letter)
}

for(i in 1:4) print(x[i])

#nested for loops
x <- matrix(1:6,2,3)

#!! seq_len
for(i in seq_len(nrow(x))){
        for(j in seq_len(ncol(x))){
                print(x[i,j])
        }
}

#while loop
count <- 0
while(count < 10){
        print(count)
        count <- count + 1
}

z <- 5
output1 <- NULL
while(z >= 1 && z <= 10){
        output1 <- paste(output1,z)
        coin <- rbinom(1, 1, 0.5)
        if(coin == 1){
                z <- z+1
        }else{
                z <- z-1
        }
}
output1

#repeat
x0 <- 1
to1 <- 1e-8
repeat{
        x1 <- computeEstimate()
        if(abs(x1 - x0) < to1){
                break
        }else{
                x0 <- x1
        }
}

#next, return
for(i in 1:100){
        if(i <= 20){
                next
                print("skip the first 20 iterations")
        }
        print("do something here")
}

# first function

x <- 1:50

above10 <- function(x){
        use <- x > 10
        return(x[use])
}

above <- function(x, n = 10){
        use <- x > n
        return(x[use])
}

# function
################################################################################
#!! colume mean calculation
columnmean <- function(y, removeNA = TRUE){
        nc <- ncol(y) #get number of col
        meanvector <- numeric(nc) #init a numeric vector
        for(i in 1:nc){
                meanvector[i] <- mean(y[ , i] , na.rm = removeNA)
        }
        return(meanvector)
}

#lazy function
f <- function(a,b){
        return(a^2)
}
f(45)

f1 <- function(a,b){
        print(a)
        print(b)
}
f1(45)

# ...
myplot <- function(x, y, type ="l", ...){
        plot(x, y, type = type, ...)
}

args(paste)
paste("a", "b", sep=":")
paste("a","b", se=":") # no partial argument match after ...

#!!!lexical scoping
#######################################################################
search()

#!!! function within a function (env within env)
make.power <- function(n){
        pow <- function(x)
                return(x^n)
        return(pow)
}

cube <- make.power(3) #create a power function of cube
square <- make.power(2) #create a power function of square
cube(4)
square(4)

ls(environment(cube))
get("n",environment(cube)) #get n in cube env.
ls(environment(square))
get("n",environment(square)) #get n in square env

y <- 10
f <- function(x){
        y <- 2
        y^2 + g(x)
}
g <- function(x){
        x*y   #!!! y is looked up in env in which g is defined, so y is 10 (lexical scoping)
}
f(3)

g <- function(x){
        a <- 3
        x+a+z
}
g(2)
z <- 3
g(2)


make.NegLogLik <- function(data, fixed=c(FALSE,FALSE)) {
        params <- fixed
        function(p) {
                params[!fixed] <- p
                mu <- params[1]
                sigma <- params[2]
                a <- -0.5*length(data)*log(2*pi*sigma^2)
                b <- -0.5*sum((data-mu)^2) / (sigma^2)
                return(-(a + b))
        }
}

set.seed(1)
normals <- rnorm(100, 1, 2)
nLL <- make.NegLogLik(normals)
nLL
ls(environment(nLL)) #lexical scoping, all variables are within the local function

optim(c(mu = 0, sigma = 1), nLL)$par
nLL <- make.NegLogLik(normals, c(FALSE, 2))
optimize(nLL, c(-1,3))$minimum
nLL <- make.NegLogLik(normals, c(1, FALSE))
optimize(nLL, c(1e-6, 10))$minimum

nLL <- make.NegLogLik(normals, c(1, FALSE))
x <- seq(1.7, 1.9, len = 100)
y <- sapply(x, nLL)
plot(x, exp(-(y - min(y))), type = "l")

nLL <- make.NegLogLik(normals, c(FALSE, 2))
x <- seq(0.5, 1.5, len = 100)
y <- sapply(x, nLL)
plot(x, exp(-(y - min(y))), type = "l")
