#x og y er to sorterte arrays, coordinate angir koordinat akse
function mergearrays(x,y,coordinate)
    A = reshape([],0,2)                           #Initializing a nx2 matrix by making a 0x2 array that we later append to
    x_i = 1
    y_i = 1
    finished = false
    x_done = false
    y_done =false
    while !finished
        if y_done
            A = [A; reshape(x[x_i,:],1,2)]          #Must use reshape to get list onto array form
            x_i += 1
            if x_i > length(x)/2                    #length(x)/2 because length interpets x as a one-dimensional array
                x_i = trunc(Int, length(x)/2)       #trunc to convert from float to int
                x_done=true
            end
        elseif x_done
            A = [A; reshape(y[y_i,:],1,2)]
            y_i += 1
            if y_i>length(y)/2
                y_i = trunc(Int,length(y)/2)        #trunc to convert from float to int
                y_done=true
            end
        elseif (x[x_i,coordinate]<=y[y_i,coordinate])
            A = [A; reshape(x[x_i,:],1,2)]
            x_i += 1
            if x_i > length(x)/2                    #length(x)/2 because length interpets x as a one-dimensional array
                x_i = trunc(Int, length(x)/2)       #trunc to convert from float to int
                x_done=true
            end
        else
            A = [A; reshape(y[y_i,:],1,2)]
            y_i += 1
            if y_i>length(y)/2
                y_i = trunc(Int,length(y)/2)        #trunc to convert from float to int
                y_done=true
            end
        end
        if y_done && x_done
            finished=true
        end
    end
    return A
end

#x usortert array, coordinate angir koordinat akse vi skal sortere langs
function mergesort(x, coordinate)
    if length(x)>2
        q = floor(Int,(length(x)/2)/2)
        x[1:q,:] = mergesort(x[1:q,:],coordinate)                                                   #We must remember to save the changes to the part of the variable we are working with!
        x[q+1:trunc(Int,length(x)/2),:] = mergesort(x[q+1:trunc(Int,length(x)/2),:],coordinate)     #Similarly here, not sure why not call by refrence though, ask STUDASS!
        println("Run merge on")
        println(x[1:q,:])
        println(x[q+1:trunc(Int,length(x)/2),:])
        x = (mergearrays(x[1:q,:],x[q+1:trunc(Int,length(x)/2),:],coordinate))
    end
    return x

    println("x after merge: ", x)
end

#X = [1 2; 4 6; 8 12; 74 102]
#Y = [2 4; 3 6; 3000 49]
#Z = [49 12; 23 15; 4 37; 3 2]
#T = mergearrays(X,Y,2)
#println(T)
#T2 = mergesort(Z,2)

###############################################################################
##Q2: Binary search for interval
###############################################################################

#Comment: This is not binary, its quadratic
function binaryintervalsearch(x, delta, coordinate)
    #Find the median
    if (length(x)/2)%2!=0
        median = x[floor(Int,(length(x)/2)/2)+1,coordinate]
    else
        x_1 = x[floor(Int,(length(x)/2)/2),coordinate]
        x_2 = x[floor(Int,(length(x)/2)/2)+1,coordinate]
        median = (x_1+x_2)/2
    end
    #Functionality teste up to his point: OK
    interval_lower_limit = median-delta
    interval_higher_limit = median+delta
    println("Interval: ",interval_lower_limit,"-",interval_higher_limit)

    #Task: Find number closest to lower_limit
    #Knows: All values are integerers and are sorted w. respect to the coordinate selected in input
    A = []
    for i = 1:length(x[:,coordinate])
        println("x[i,coordinate]= ", x[i,coordinate])
        if (x[i,coordinate]>=interval_lower_limit) && (x[i,coordinate]<=interval_higher_limit)
            push!(A, i)
        end
    end
    println("A:",A)
    if length(A)>=2
        return (A[1], A[length(A)])
    elseif length(A)==1
        return (A[1],A[1])
    else
        return (-1,-1)
    end
end

X_1 = [1 2; 2 3; 3 0; 4 0; 5 1; ]
X_2 = [1 2; 2 0; 3 3; 4 4]
X_3 = [1 0; 2 0; 2 0; 3 0 ; 4 0 ; 5 0 ; 5 0]
X_4 = [1.0 0.0; 2.0 0.0; 3.0 0.0]
delta_1=1.5
delta_2=0.25
delta_3=1
delta_4 = 0.50
coordinate=1

res_1 = binaryintervalsearch(X_1, delta_1, coordinate)
res_2 = binaryintervalsearch(X_2,delta_2,coordinate)
res_3 = binaryintervalsearch(X_3, delta_3, coordinate)
res_4 = binaryintervalsearch(X_4, delta_4, coordinate)


function binaryintervalsearch_v2(x, delta, coordinate)
    #Assumption: List is 2d and only contains integerers
    if length(x)==0
        return [-1 -1]
    end

    median = median_finder(x, coordinate)   #Return [median_value median_index]
    low_value = ceil(median[1]-delta)
    high_value = floor(median[1]+delta)

    lower_index = binarysearch_lower(x, 1, median[2], low_value, coordinate)
    higher_index = binarysearch_higher(x, median[2]+1, length(x[:,1]), high_value, coordinate)

    if lower_index > higher_index
        return [-1 -1]
    end
    return [lower_index higher_index]

end

function median_finder(x, coordinate)
    median_index = 0
    median_value = 0

    if (length(x)/2)%2!=0
        median_index = floor(Int,(length(x)/2)/2)+1
        median_value = x[floor(Int,(length(x)/2)/2)+1,coordinate]
    else
        #If even, chooses lower index
        median_index = floor(Int,(length(x)/2)/2)
        x_1 = x[median_index,coordinate]
        x_2 = x[median_index+1,coordinate]
        median_value = (x_1+x_2)/2
    end
    return [median_value median_index]
end

function binarysearch_lower(x,left, right,value, coordinate)
    #Searching for a value worth less than value, return next index
    if left<=right
        #q: Index of middle element
        q=Int(floor((left+right)/2))
        if x[q,coordinate]<value && x[q+1,coordinate]>=value
            return q+1
        elseif value<=x[q,coordinate]
            return binarysearch_lower(x,left, q-1, value, coordinate)
        else
            return binarysearch_lower(x,q+1,right,value,coordinate)
        end
    else
        return Int(left) #This happens if all values are within delta-range
    end
end

function binarysearch_higher(x,left, right, value, coordinate)
    #Searching for a value worth more than value, return previous index
    if left<=right
        q=Int(floor((left+right)/2))
        if (x[q,coordinate]>value) && (x[q-1,coordinate]<value)
            return q-1
        elseif x[q,coordinate]>value
            return binarysearch_higher(x,left,q-1,value,coordinate)
        else
            return binarysearch_higher(x,q+1,right,value,coordinate)
        end
    else
        return Int(right)
    end
end

X_1 = [1 2; 2 3; 3 0; 4 0; 5 1; ]
X_2 = [1 2; 2 0; 3 3; 4 4]
X_3 = [1 0; 2 0; 2 0; 3 0 ; 4 0 ; 5 0 ; 5 0]
X_4 = [1.0 0.0; 2.0 0.0; 3.0 0.0]
delta_1=1.5
delta_2=0.25
delta_3=1
delta_4 = 0.50
coordinate=1

res_1 = binaryintervalsearch_v2(X_1, delta_1, coordinate)
res_2 = binaryintervalsearch_v2(X_2,delta_2,coordinate)
res_3 = binaryintervalsearch_v2(X_3, delta_3, coordinate)
res_4 = binaryintervalsearch_v2(X_4, delta_4, coordinate)

##############################################################################
#Q3: Brute force løsning
##############################################################################
function bruteforce(x)
    shortest = -1
    for i in 1:trunc(Int,(length(x[:,1]))/2)
        for j in trunc(Int,((length(x[:,1]))/2+1)):length(x[:,1])
            distance = sqrt((x[i,1]-x[j,1])^2+(x[i,2]-x[j,2])^2)
            if (shortest == -1) || distance<shortest
                shortest = distance
            end
        end
    end
    return shortest
end

#Test of brute force:
x = [1 1; 10 0; 2 2; 5 5]
println(bruteforce(x))


###############################################################################
#Q4: Splittsteget
###############################################################################

#Arguments:
    #x: Coordinates sorted by x
    #y: Coordinates sorted by y
    #Note: These are the SAME coordinate pairs on both matrices

#Comment:
    #This does NOT run in linear time, I did not find a solution for that..
function inarray(sub, x)
    for i in 1:length(x[:,1])
        xi = x[i, :]
        if sub[1] == xi[1] && sub[2] == xi[2]
            return true
        end
    end
    return false
end

function splitintwo(x,y)
    x_left = []
    x_right = []
    y_left = reshape([],(0,2))
    y_right = reshape([],(0,2))
    #Lets first check if we have odd or even number of coordinates
    xIsOdd = false
    yIsOdd = false
    if length(x[:,1])%2!=0
        xIsOdd=true
    end
    if length(y[:,1])%2!=0
        yIsOdd = true
    end

    #Now lets split x:
    if xIsOdd
        println("X is odd")
        x_left = x[1:Int(floor(length(x[:,1])/2+1)),:]        #Makes sure the middle element is put in the left array
        x_right = x[Int(ceil(length(x[:,1])/2+1)):Int(length(x[:,1])),:]
    else
        x_left = x[1:trunc(Int,length(x[:,1])/2),:]
        x_right = x[trunc(Int,length(x[:,1])/2+1):Int(length(x[:,1])),:]
    end

    #Now lets split y (in such a way that the coordinates appear in the same order as in x)
    for i in 1:Int(length(y[:,1]))
        element = reshape(y[i,:],(1,2))
        if inarray(element,x_left)
            y_left = [y_left; element]
        else
            y_right = [y_right; element]
        end
    end

    return x_left, x_right, y_left, y_right
end

#Test
x = [1.0 2.0; 2.0 3.0; 3.0 2.0; 4.0 5.0; 6.0 6.0]
y = [1.0 2.0; 3.0 2.0; 2.0 3.0; 4.0 5.0; 6.0 6.0]

x_2 = [2.0 0.0; 3.0 2.0; 4.0 0.0; 4.0 5.0; 5.0 4.0]
y_2 = mergesort(x_2,2)

x_left, x_right, y_left, y_right = splitintwo(x_2,y_2)
