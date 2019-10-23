function lislength(s)
    mls = zeros(Int, size(s))
    mls[1] = 1
    for i = 2:length(s)
        for j = 1:i
            if s[i]>s[j]
                potential_value = mls[j]+1
                if potential_value>mls[i]
                    mls[i]=potential_value
                end
            end
        end
        if mls[i]==0
            mls[i]=1
        end
        println("Number is: ", s[i], " Longest sublength is: ", mls[i])
    end
    return maximum(mls) # Returnerer det største tallet i listen
end

function lislength_mlsreturn(s)
    mls = zeros(Int, size(s))
    mls[1] = 1
    for i = 2:length(s)
        for j = 1:i
            if s[i]>s[j]
                potential_value = mls[j]+1
                if potential_value>mls[i]
                    mls[i]=potential_value
                end
            end
        end
        if mls[i]==0
            mls[i]=1
        end
        println("Number is: ", s[i], " Longest sublength is: ", mls[i])
    end
    return mls # Returnerer det største tallet i listen
end

printstyled("\n\n\n---------------\nKjører tester på Q1\n---------------\n"; color = :magenta)

using Test
@testset "Tester" begin
	@test lislength([5,3,3,6,7]) == 3
	@test lislength([2,2,2,2]) == 1
	@test lislength([100,50,25,10]) == 1
	@test lislength([0, 8, 4, 12, 2, 10, 6, 14, 1, 9, 5, 13, 3, 11, 7, 15]) == 6
	@test lislength([682, 52, 230, 441, 1000, 22, 678, 695, 0, 681]) == 5
	@test lislength([441, 1000, 22, 678, 695, 0, 681, 956, 48, 587, 604, 857, 689, 346, 425, 513, 476, 917, 114, 43, 327, 172, 162, 76, 91, 869, 549, 883, 679, 812, 747, 862, 228, 368, 774, 838, 107, 738, 717, 25, 937, 927, 145, 44, 634, 557, 850, 965]) == 12
end

println("\nFungerte alt? Prøv å kjør koden i inginious!")
println("Husk at disse testene ikke alltid sjekker alle edge-cases")
println("---------------------------------------------------------\n\n")

#Vil nå finne hvilken delføge som er den lengste. Hvis flere er like lange skal den bakerste benyttes
function lis(s, mls)
    ml = maximum(mls)
    lis = zeros(Int, ml)
    for i = length(mls):-1:1
        if mls[i]==ml
            lis_head = length(lis)
            lis[lis_head] = s[i]
            lis_head-=1
            longest_sublength_in_lowest_lis_pos_filled = mls[i]
            for j = i:-1:1
                if s[i]>s[j] && mls[j]+1==longest_sublength_in_lowest_lis_pos_filled
                    longest_sublength_in_lowest_lis_pos_filled = mls[j]
                    lis[lis_head]=s[j]
                    lis_head-=1
                end
            end
            break
        end
    end
    return lis
end

using Test
@testset "Tester" begin
	@test lis([5,3,3,6,7],[1, 1, 1, 2, 3]) == [3,6,7]
	@test lis([2,2,2,2],[1, 1, 1, 1]) == [2]
	@test lis([100,50,25,10],[1, 1, 1, 1]) == [10]
	@test lis([0, 8, 4, 12, 2, 10, 6, 14, 1, 9, 5, 13, 3, 11, 7, 15],[1, 2, 2, 3, 2, 3, 3, 4, 2, 4, 3, 5, 3, 5, 4, 6]) == [0,2,6,9,11,15]
end

###############################################################################
#Q3 Find weights
###############################################################################

weights = [3  6  8 6 3
          7  6  5 7 3
          4  10 4 1 6
          10 4  3 1 2
          6  1  7 3 9]

function cumulative(weights)
	#Make the return pathweights matrix
	rows, cols = size(weights)
	pathweights = zeros(rows,cols)

	for row=1:rows
		for col = 1:cols
			if row ==1
				pathweights[row,col]=weights[row,col]
			else
				#Some code here
				#Find smallest of the three weights in the row above in the pathweights matrix
				smallest = 9999
				for i=col-1:col+1
					if i==0 || i==cols+1
						continue
					else
						if pathweights[row-1,i]<smallest
							smallest = pathweights[row-1,i]
						end
					end
				end
				pathweights[row,col]=weights[row,col]+smallest
			end
		end
	end
	return pathweights
end

pathweights = cumulative(weights)

printstyled("\n\n\n---------------\nKjører tester på Q3\n---------------\n"; color = :magenta)

using Test
@testset "Tester" begin
	@test cumulative([1 1 ; 1 1]) == [1 1 ;2 2]
    #Dette er samme eksempel som det vist i oppgaveteskten
	@test cumulative([3  6  8 6 3; 7  6  5 7 3; 4  10 4 1 6; 10 4  3 1 2;6  1  7 3 9])== [3  6  8  6  3;10 9  11 10 6;13 19 13 7  12;23 17 10 8  9;23 11 15 11 17]
end


println("\nFungerte alt? Prøv å kjør koden i inginious!")
println("Husk at disse testene ikke alltid sjekker alle edge-cases")
println("---------------------------------------------------------\n\n")

###############################################################################
#Q4
###############################################################################

function backtrack(pathweights)
    list = []
	rows, cols = size(pathweights)
	#Find index of lowest element in last row
	minindex = argmin(pathweights[rows])

	#Push the first coordinate to the list
	push!(list,(rows,minindex))
	for row = rows-1:-1:1
		smallest = 9999
		for i=minindex-1:minindex+1
			if i==0 || i ==cols+1
				continue
			else
				if pathweights[row,i]<smallest
					smallest = pathweights[row,i]
					minindex = i
				end
			end
		end
		push!(list,(row,minindex))
	end
	return list
end

list = backtrack(pathweights)

row2 = pathweights(5,;)
