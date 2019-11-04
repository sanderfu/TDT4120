function findclusters(E, n, k)

    #params:
        #E: list of edges; format: tuple(w, u, v)
        #n: number of nodes
        #k: number of clusters to find; assume 1<=k<=n

    #returns:
        #list of k sublists with nodeindexes (u)
        #note: order of sublists and numbers in sublists is inconsequential


    #Create nodes for every node u
    nodes = Vector{DisjointSetNode}()
    for i=1:n
        node = DisjointSetNode()
        push!(nodes,node)
    end

    #Secondly sort edges by weight w (necessary step for Kruskals algorithm)
    sort!(E)

    # In the beginning all nodes are in independet sets
    subsets = n

    # Unifies the nodes of nodes, until we have k sets left.
    j = 1
    while subsets>k
        println(j)
        if findset(nodes[E[j][2]]) != findset(nodes[E[j][3]])
            union!(nodes[E[j][2]], nodes[E[j][3]])
            subsets-=1
        end
        j+=1
        if j>length(E)
            break
        end
    end

    #Reduce all trees to 2-level tall trees with this trick
    for node in nodes
        findset(node)
    end

    #Create cluster array
    clusters = Vector{Vector{Int}}()

    #Create subarrays for each cluster and push to cluster array
    for i in 1:n
        if nodes[i] == nodes[i].p
            #We have a root node
            cluster = []
            for j=1:n
                if nodes[j].p == nodes[i]
                    push!(cluster,j)
                end
            end
            push!(clusters,cluster)
        end
    end


    return clusters
end

test = findclusters([(1, 3, 4), (3, 1, 3), (5, 1, 4), (6, 2, 1), (7, 2, 3), (8, 3, 1), (9, 3, 2),
(10, 4, 1), (11, 4, 2), (12, 4, 3), (4, 2, 4), (2, 1, 2)], 4, 3)

printstyled("\n\n\n---------------\nKjører tester!!\n---------------\n"; color = :magenta)


using Test
@testset "Tester" begin
    @test sort([sort(x) for x in findclusters([(1, 3, 4), (3, 1, 3), (5, 1, 4), (6, 2, 1), (7, 2, 3), (8, 3, 1), (9, 3, 2),
    (10, 4, 1), (11, 4, 2), (12, 4, 3), (4, 2, 4), (2, 1, 2)], 4, 2)]) == sort([[1, 2], [3, 4]])
    @test sort([sort(x) for x in findclusters([(1, 3, 4), (3, 1, 3), (5, 1, 4), (6, 2, 1), (7, 2, 3), (8, 3, 1), (9, 3, 2),
    (10, 4, 1), (11, 4, 2), (12, 4, 3), (4, 2, 4), (2, 1, 2)], 4, 3)]) == sort([[1], [2], [3, 4]])
end

println("\nFungerte det? Prøv å kjør koden i inginious!")
println("Husk at disse testene ikke sjekker alle grensetilfellene")
println("---------------------------------------------------------\n\n")
