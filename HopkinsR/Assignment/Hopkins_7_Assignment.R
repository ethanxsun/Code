### for wk 7 looping assignment

rm(list = ls())

#examples
#The first function, makeVector creates a special "vector", which is really a list containing a function to
#set the value of the vector
#get the value of the vector
#set the value of the mean
#get the value of the mean

makeVector <- function(x = numeric()) {
        
        m <- NULL  #makeVector() object has a m
        
        set <- function(y) {
                x <<- y
                m <<- NULL
        }
        get <- function() x
        setmean <- function(mean) m <<- mean
        getmean <- function() m
        
        return(list(set = set, get = get,
             setmean = setmean,
             getmean = getmean))
}

cachemean <- function(x, ...) {
        
        m <- x$getmean()
        
        if(!is.null(m)) {
                message("getting cached data")
                return(m)
        }
        #when mean is null
        data <- x$get()
        
        m <- mean(data, ...)
        x$setmean(m)
        m
}

#assignment answer
makeCacheMatrix <- function(m = matrix()){
        
        solve <- NULL #init solve to null when the func is called
                
        set <- function(n){
                m <<- n #set external matrix n to m within the object
                solve <<- NULL #init solve to NULL
        }
        get <- function(){
                return(m)
        }
        setSolve <- function(s){
                solve <<- s
        }
        getSolve <- function(){
                return(solve)
        }
        return(list(set = set, get = get, setSolve = setSolve, getSolve = getSolve))
}

cacheSolve <- function(m , ...){
        
        result <- m$getSolve()
        
        if(!is.null(result)){
                message("Cache found, getting the solve matrix")
                return(result)
        }
        
        #if not found a cache
        data <- m$get()
        result <- solve(data,...)
        m$setSolve(result)
        return(result)
}

#test
v <- rnorm(100)
l <- makeVector(v)
cachemean(l)

m <- matrix(runif(1000000), 1000,1000)

m1 <- makeCacheMatrix(m)
m1$getSolve()
heatmap(cacheSolve(m1))
