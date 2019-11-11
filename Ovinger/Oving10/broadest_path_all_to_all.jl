function floyd_warshall(adjacency_matrix, nodes, f, g)
    #Find number of nodes based on rows in adjacency matrix
    n = nodes

    #Define return matrix to first be equal to adjacency_matrix
    D = adjacency_matrix

    for k=1:n
        for i=1:n
            for j=1:n
                D[i,j]=f(D[i,j],g(D[i,k],D[k,j]))
            end
        end
    end
    return D
end

# Husk å bruke: f, g

adjacency_matrix = [0 7 2; Inf 0 Inf; Inf 4 0]
nodes = 3
f = min
g = +

tester = floyd_warshall(adjacency_matrix,nodes,f,g)

function transitive_closure(adjacency_matrix, nodes)
    n = nodes
    #By using f=min and g=+ this act as a normal Floyd-Warshall implementation
    T = copy(floyd_warshall(adjacency_matrix,nodes,min,+))
    for i=1:n
        for j=1:n
            if T[i,j]<Inf
                T[i,j]=1
            else
                T[i,j]=0
            end
        end
    end
    return T
end

# Husk å bruk generalisert Floyd-Warshall fra forrige oppgave

test_tc = transitive_closure(adjacency_matrix,nodes)
