function countingsortletters(A,position)
    #Create return array
    B = []
    #Get it to the same length as A

    #Beautiful option that we cant use due to stupid testing algorithm:
    B_youwish = Array{String}(undef,1,length(A))

    #Stupid option we have to use instead to get the f***ing commas
    for i in 1:length(A)
        push!(B,"")
    end

    #Create a temporary holding array for values and get it to same length
    C = []
    C =zeros(1,26)
    for j in 1:length(A)
        C[chartodigit(A[j][position])]+=1
    end
    #C [i] now contains the number of elements equal to i

    #Assume only small letters between a=1 and z=26
    largestValue = 26
    for i in 2:largestValue
        C[i]=C[i]+C[i-1]
    end
    #C[i] now contains the amount of values equal or less than the value i

    for j in length(A):-1:1
        B[Int(C[chartodigit(A[j][position])])] = A[j]
        C[chartodigit(A[j][position])]-=1
    end
    return B
end



function chartodigit(character)
    #Dette er en hjelpefunksjon for å få omgjort en char til tall
    #Den konverterer 'a' til 1, 'b' til 2 osv.
    #Eksempel: chartodigit("hei"[2]) gir 5 siden 'e' er den femte bokstaven i alfabetet.

    return character - '`'
end

using Test
@testset "Basic tests" begin
    @test countingsortletters(["aa", "bb", "cc"], 1) == ["aa", "bb", "cc"]
    @test countingsortletters(["cc", "bb", "aa"], 2) == ["aa", "bb", "cc"]
    @test countingsortletters(["ac", "bb", "ca"], 2) == ["ca", "bb", "ac"]
    @test countingsortletters(["ccc", "cba", "ca", "ab", "abc"], 2) == ["ca", "cba", "ab", "abc", "ccc"]
end

println("\nFungerte alt? Prøv å kjør koden i inginious!")
println("Husk at disse testene ikke alltid sjekker alle edge-cases")
println("---------------------------------------------------------\n\n")

#FUnctionality of the following function: Sort strings based on length
function countingsortlength(A)
    B=[]
    for i in 1:length(A)
        push!(B,"")
    end

    C=[]
    #Find longest string
    longest_string = 0
    for i in 1:length(A)
        if length(A[i])>longest_string
            longest_string=length(A[i])
        end
    end

    #Offset so that empty string is 1
    longest_string+=1

    for i in 1:longest_string
        push!(C,0)
    end

    for i in 1:length(A)
        #We have to use +1 offset on C because empty string has length 0
        C[length(A[i])+1]+=1
    end
    for j in 2:longest_string
        C[j]+=C[j-1]
    end
    for i in length(A):-1:1
        #We have to use +1 offset on C because empty string has length 0
        B[C[length(A[i])+1]]=A[i]
        C[length(A[i])+1]-=1
    end
    return B
end

test = countingsortlength(["bbbb", "", "aaaa", "ccc"])

using Test
@testset "Basic tests" begin
    @test countingsortlength(["ccc", "bb", "a"]) == ["a", "bb", "ccc"]
    @test countingsortlength(["aaa", "bb", "c"]) == ["c", "bb", "aaa"]
    @test countingsortlength(["bb", "a", ""]) == ["", "a", "bb"] # Testen her sjekker om du kan sortere også med emtpy string
    @test countingsortlength(["bbbb", "aa", "aaaa", "ccc"]) == ["aa", "ccc", "bbbb", "aaaa"] # Fra oppgaven
end

println("\nFungerte alt? Prøv å kjør koden i inginious!")
println("Husk at disse testene ikke alltid sjekker alle edge-cases")
println("---------------------------------------------------------\n\n")


function flexradix(A,maxlength)
    #First, lets sort based on length
    B = countingsortlength(A)

    #Next, lets sort on letter based on position
    #Have to go from maxlength to 1 to get most significant character (first charater) last
    for i in maxlength:-1:1
        #Determine the part of A to run counting sort letters on

        longer = []
        shorter = []
        for index in 1:length(B)
            if i> length(B[index])
                push!(shorter,B[index])
            else
                push!(longer,B[index])
            end
        end
        longer = countingsortletters(longer,i)
        B = vcat(shorter, longer)
    end
    return B
end

test3 = flexradix(["kobra", "aggie", "agg", "kort", "hyblen"], 6)

printstyled("\n\n\n---------------\nKjører tester!!\n---------------\n"; color = :magenta)

using Test
@testset "Basic tests" begin
    @test flexradix(["d", "c", "b", "a"], 1) == ["a", "b", "c", "d"]
    @test flexradix(["d", "c", "b", ""], 1) == ["", "b", "c", "d"]
    @test flexradix(["jeg", "elsker", "deg"], 6) == ["deg", "elsker", "jeg"]
    @test flexradix(["denne", "oppgaven", "mangler", "emojies"], 8) == ["denne", "emojies", "mangler", "oppgaven"]
    @test flexradix(["kobra", "aggie", "agg", "kort", "hyblen"], 6) == ["agg", "aggie", "hyblen", "kobra", "kort"] # Fra oppgaven
end

println("\nFungerte alt? Prøv å kjør koden i inginious!")
println("Husk at disse testene ikke alltid sjekker alle edge-cases")
println("---------------------------------------------------------\n\n")
