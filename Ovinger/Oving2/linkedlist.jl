
mutable struct Node
    next::Union{Node, Nothing} # next kan peke på et Node-objekt eller ha verdien nothing.
    value::Int
end

function createlinkedlist(length)
    # Creates the list starting from the last element
    # This is done so the last element we generate is the head
    child = nothing
    node = nothing

    for i in 1:length
        node = Node(child, rand(1:800))
        child = node
    end
    return node
end

function findindexinlist(linkedlist, index)
    currentNode = linkedlist
    for i in 1:index
        if i == index
            return currentNode.value
        elseif currentNode.next == nothing
            return -1
        else
            currentNode = currentNode.next
        end
    end
end

llist1 = createlinkedlist(9)
println(findindexinlist(llist1,7))
println(findindexinlist(llist1,9))
println(findindexinlist(llist1,10))
###############################################################################
#Question 2: Stack
###############################################################################
s = []
push!(s, 2)
push!(s, 5)
println(s)    # gir lista [2,5]
println(s[1]) # dette gir verdien 2
x = pop!(s)
println(x)    # dette gir verdien 5

function reverseandlimit(array, maxnumber)
    rarray = []
    for index in 1:(length(array)-1)
        number = array[end-index]
        if number > maxnumber
            number = maxnumber
        end
        push!(rarray,number)
    end
    return rarray
end

s = [1:10;]
println(reverseandlimit(s,7))

###############################################################################
#Question 3: Traversere dobbelt lenket liste
###############################################################################

mutable struct NodeDoublyLinked
    prev::Union{NodeDoublyLinked, Nothing} # Er enten forrige node eller nothing
    next::Union{NodeDoublyLinked, Nothing} # Er enten neste node eller nothing
    value::Int # Verdien til noden
end

function createLinkedListDoublyLinked(length)
    current = nothing
    beforeCurrent = nothing
    for i in 1:length
        #Fill out next field only, prve will be filled later
        current = NodeDoublyLinked(nothing,beforeCurrent,rand(-100:100))
        #Link up the node before this node to this node
        if beforeCurrent!=nothing
            beforeCurrent.prev = current
        end
        #Change the beforeCurrent to the current and move on
        beforeCurrent = current
    end
    return current
end

#OBS: linkedlist er IKKE nødvendigvis head!!
function maxofdoublelinkedlist(linkedlist)
    inputNode = linkedlist
    currentNode = linkedlist
    maxValue = -999

    #La oss først gå til enden fra inputNode
    while currentNode.next != nothing
        if currentNode.value >maxValue
            maxValue = currentNode.value
        end
        currentNode = currentNode.next
    end

    #La oss så gå fra inputNode til starten
    while currentNode.prev !=nothing
        if currentNode.value >maxValue
            maxValue = currentNode.value
        end
        currentNode = currentNode.prev
    return maxValue
end


dllist1=createLinkedListDoublyLinked(13)
println(maxofdoublelinkedlist(dllist1))
