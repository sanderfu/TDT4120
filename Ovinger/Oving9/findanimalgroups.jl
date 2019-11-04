function findanimalgroups(animals, k)

    #params
    #    list with (animal,DNA)-tuples -> animals
    #    the number of clusters -> k
    #returns
    #    clusters of similar animals, represented by only the animal names


    #Generate list E
    E=[]
    for i=1:length(animals)
        for j = 1:length(animals)
            #Avoid connction an animal with itself
            if i ==j
                continue
            end
            u = i
            v = j

            #Check if nodes already connected
            edge_generated = false
            for edge in E
                if (edge[1]==v && edge[2]==u)
                    edge_generated = true
                end
            end
            if edge_generated
                continue
            end

            #Generate weight based on hammingdistance
            w = hammingdistance(animals[i][2],animals[j][2])
            edge = tuple(w,u,v)
            push!(E,edge)
        end
    end

    #Geneate clusters
    clusters = findclusters(E,length(animals),k)

    #Convert animal iDs back to string names
    animal_clusters = Vector{Vector{String}}()
    for cluster in clusters
        animal_cluster = Vector{String}()
        for animal in cluster
            name = 1
            dna = 2
            push!(animal_cluster,animals[animal][name])
        end
        push!(animal_clusters,animal_cluster)
    end

    return animal_clusters
end
animals = [("Ugle", "CGGCACGT"), ("Elg", "ATTTGACA"), ("Hjort", "AATAGGCC")]
k = 0
test = findanimalgroups(animals, 2)

printstyled("\n\n\n---------------\nKjører tester!!\n---------------\n"; color = :magenta)


using Test
@testset "Tester" begin
    @test sort([sort(x) for x in findanimalgroups([("Ugle", "CGGCACGT"), ("Elg", "ATTTGACA"), ("Hjort", "AATAGGCC")], 2)]) == sort([["Ugle"], ["Elg", "Hjort"]])

    @test sort([sort(x) for x in findanimalgroups([("Hval", "CGCACATA"), ("Ulv", "AGAAACCT"), ("Delfin", "GGCACATA"), ("Hund", "GGAGACAA"),
    ("Katt", "TAACGCCA"), ("Leopard", "TAACGCCT")], 3)]) == sort([["Hund", "Ulv"], ["Delfin", "Hval"], ["Katt", "Leopard"]])
end

println("\nFungerte det? Prøv å kjør koden i inginious!")
println("Husk at disse testene ikke sjekker alle grensetilfellene")
println("---------------------------------------------------------\n\n")
