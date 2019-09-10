###########################
#Control flow
###########################

#Arrays
list1 = [1:10;]
list2 = [10:20;]
append!(list1,list2)
append!(list1,999)
push!(list1,989)
for number = list1
    println("$number is a number")
end

for number in list1
    println("$number is a number")
end

#Dictionaries and iterating over them
dict1 = Dict("dog" => "mammal", "cat" => "mammal", "mouse" => "mammal")
for pair in dict1
    from,to = pair
    println("$from is a $to")
end

#Handle exeptions
try
    error("Help")
catch e
    println("caught it $e")
end

##################
##Functions
##################
function add(x,y)
    println("x is $x and y is $y")
    x+y
end
println(add(5,6))

#NOTICE: If a function makes changes to any of its input variables we use a exclemation mark to say so
function arrayModifier!(A)
    for i = 1:length(A)
        A[i]=i^2
    end
    return A
end
A = [1:10;]
println(arrayModifier!(A))

#########################
##Types
#########################
println(typeof(5))
println(typeof(55555555555555555555555555555555555))

struct Tiger
    taillength::Float64
    coatcolor #not including type notation is the same as '::Any'
end
pussy_cat = Tiger(3.5, "orange")
sherekhan = typeof(pussy_cat)(5.6,"fire")
println(sherekhan)

#abstract name
abstract type Cat end

#Abstract types cannot be instantiated, but can have subtypes
#Ex: Number is an abstract type
println(subtypes(Number))
println(subtypes(Cat))

#Every type has a super type; use the 'supertype' function to get it
println(typeof(5))
println(supertype(Int64))
println(supertype(Signed))
println(supertype(Integer))
println(supertype(Real))
println(supertype(Number))

# <: is a subtyping operator
struct Lion <: Cat #Lion is subtype of Cat
    maneColor
    roar::AbstractString
end
