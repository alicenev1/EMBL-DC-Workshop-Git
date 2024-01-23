weight_g <- c(50, 60, 65, 82)

animals <- c("mouse", "rat", "dog")

#get the length of the vector
length(animals)

#get the type of data contained in the vector
class(animals)
class(weight_g)

#structure of the object
str(animals)

# how to add an element to the beginning of a vector 
animals <- c("cincilla", animals)
# how to add an element to the end of a vector 
animals <- c(animals, "frog")


typeof(animals)

#what happens in the next cases
num_char <- c(1, 2, 3, "a")
num_logical <- c(1, 2, 3, TRUE)
char_logical <- c("a", "b", "c", TRUE)
tricky <- c(1, 2, 3, "4")
tricky
#logical - > numeric -> character
#logical -> character

#subsetting a vector
animals[2]
animals[c(1,2)]

more_animals <- animals[c(1,2,3,2,1,4)]
more_animals

weight_g
weight_g[c(FALSE, FALSE, TRUE, TRUE)]

# < less than, > greater than, == equal to, != different than
# <= less than or equal to, >= greater than or equal to

weight_g > 63
weight_g[weight_g > 63]
weight_g[weight_g > 63 & weight_g < 80]
we, i, t, NA, ght_g < 58 | weight_g > 80]
weight_g == 65

animals[animals == "rat" | animals == "frog"]

# %in% helps us find all elements corrsponding to a vector of elemnets of our choice
# which of the thing I am writing is part of this vector
animals %in% c("rat", "frog", "cat", "duck", "dog")

#an example of a vector with missing data
heights <- c(2, 4, 4, NA, 6)
mean(heights)
# how to remove na from a calculation
mean(heights, na.rm = T)
max(heights, na.rm = T)

# how to check for the presence of a na
is.na(heights)

#omit the missing data
na.omit(heights)
#extract the complete cases
heights[complete.cases(heights)]

heights <- c(63, 69, 60, 65, NA, 68, 61, 70, 61, 59, 64, 69, 63)
heights_no_na <- na.omit(heights)
heights_no_na[heights_no_na > 67]
length(heights_no_na[heights_no_na < 67])
length(heights_no_na[heights_no_na > 67])
sum(heights_no_na > 67)



#challenge
heights <- c(63, 69, 60, 65, NA, 68, 61)
heights_no_na <- na.omit(heights)
