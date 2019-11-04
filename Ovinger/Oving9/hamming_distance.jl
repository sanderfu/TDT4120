function hammingdistance(s1, s2)
    #Comment: Cant see how this relates to the spanning trees, so excuse my brute force on this one
    differences = 0
    for i in 1:length(s1) #assumes both strings same length OK with assignment
        if s1[i]!=s2[i]
            differences+=1
        end
    end
    return differences
end
