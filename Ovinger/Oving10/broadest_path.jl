using DataStructures: PriorityQueue, enqueue!, dequeue!

mutable struct Node
    name::String # used to distinguish nodes when debugging
    d::Union{Float64, Nothing} # d for distance
    p::Union{Node, Nothing} # p for predecessor
end
Node(name) = Node(name, nothing, nothing) # constructor used for naming nodes

mutable struct Graph
    V::Array{Node} # V for Vertices
    Adj::Dict{Node, Array{Node}} # Adj for Adjacency
end

function initialize!(G,s)
    return 0
end

function update!(u,v,weight)
    return 0
end

function general_dijkstra!(G, w, s, reverse=false)
    """
    Uses update! (RELAX) and initialize! to find shortest path to all nodes in G

    param G: is the graph struct
    param w: is hash-table of edge-weights - w[(u, v)]
    param s: is the first element in G.V, and has name "A"
    param reverse: if the priority queue should be reversed
    return: nothing, algorithm is inplace
    """
    initialize!(G,s)

    if !reverse
        Q = PriorityQueue(u => u.d for u in G.V)
    else
        Q = PriorityQueue(Base.Order.Reverse, u => u.d for u in G.V)
    end

    while !isempty(Q)
        u = dequeue!(Q)
        for v in G.Adj[u]
            update!(u,v,w)
            #Now update weight of v if v is still in Q.
            if haskey(Q, v)
                Q[v] = v.d
            end
        end
    end
end

### NOW we shall find the broadest path, using general_dijkstra
### Must put reverse=true to go for lowest priority queue
### (takes out the ones with the highest bandwidth first)
###We must also modify initialize!() and update!

function initialize!(G, s)
    for v in G.V
        #.d is here bandwidth, so -inf is the worst possible
        v.d = - typemax(Float64)
        v.p = nothing
    end
    #We say the source node has inf bandwidth to itself
    s.d = typemax(Float64)
end


function update!(u, v, w)
    #We are looking for the widest path in this task, not the shortest
    if v.d < min(u.d, w[(u, v)])
        v.d = min(u.d, w[(u, v)])
        v.p = u
    end
end
