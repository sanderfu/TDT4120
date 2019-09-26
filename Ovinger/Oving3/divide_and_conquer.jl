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
function binaryintervalsearch(x, delta, coordinate)
    #Find the median
    if (length(x)/2)%2!=0
        median = x[floor(Int,(length(x)/2)/2)+1,coordinate]
    else
        x_1 = x[floor(Int,(length(x)/2)/2),coordinate]
        x_2 = x[floor(Int,(length(x)/2)/2)+1,coordinate]
        median = (x_1+x_2)/2
    end
    println(median)
    #Functionality teste up tot his point: OK
    interval_lower_limit = median-delta
    interval_higher_limit = median+delta

    #Task: Find number closest to lower_limit
    #Knows: All values are integerers and are sorted w. respect to the coordinate selected in input



    #Find number closest to upper_limit


end

X_1 = [1 2; 2 3; 3 0; 4 0; 5 1; ]
X_2 = [1 2; 2 0; 3 3; 4 4]
delta=1.5
coordinate=1

binaryintervalsearch(X_1, delta, coordinate)
binaryintervalsearch(X_2,delta,coordinate)
