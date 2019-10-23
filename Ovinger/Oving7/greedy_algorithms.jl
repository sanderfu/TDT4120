function usegreed(coins)
    for i=1:length(coins)-1
        if (coins[i] % coins[i+1])!=0        #If the modulo is different from 0, the division does not generate a natural number.
            return false
        end
    end
    return true
end

printstyled("\n\n\n---------------\nKjører tester\n---------------\n"; color = :magenta)

using Test
@testset "Tester" begin
	@test usegreed([20, 10, 5, 1]) == true
  @test usegreed([20, 15, 10, 5, 1]) == false
  @test usegreed([100, 1]) == true
  @test usegreed([5, 4, 3, 2, 1]) == false
  @test usegreed([1]) == true
end

###############################################################################
#Q2
###############################################################################
#Point with greedy algorithms: Takes the optimal choice for each step in order to try and find the optimal solution
function mincoinsgreedy(coins, value)
    left = value
	num_of_coins = 0
	for i = 1:length(coins)
		#Subtract the maximum amount of coins[i]
		temp_num_of_coins = trunc(Int,left/coins[i])
		left -= temp_num_of_coins*coins[i]
		num_of_coins+=temp_num_of_coins
	end
	return num_of_coins
end

using Test
@testset "Tester" begin
	@test mincoinsgreedy([1000,500,100,20,5,1],1226) == 6
  @test mincoinsgreedy([20,10,5,1],99) == 10
  @test mincoinsgreedy([5,1],133) == 29
end

###############################################################################
#Q3
##############################################################################
#Solution based on dynamic programming (QUDOS to TOLLSTEIN for inspiration)

function mincoinsdynamic(coins, value)
    counts=[0]
    for i in 2:value+1
        push!(counts, counts[i-1]+1)
        for coin in coins
            if coin < i && counts[i-coin]+1<counts[i]
                counts[i] = counts[i-coin]+1
            end
        end
    end
        return counts[value+1]
end
function mincoins(coins, value)
    # Om du ikke trenger inf kan du fjerne den
    inf = typemax(Int)
    # Din kode her
    if usegreed(coins)
        return mincoinsgreedy(coins, value)
    end
    return mincoinsdynamic(coins, value)
end

using Test
@testset "Tester" begin
	@test mincoins([4,3,1],18) == 5
  @test mincoins([1000,500,100,30,7,1],14) == 2
  @test mincoins([40, 30, 20, 10, 1], 90) == 3
end
