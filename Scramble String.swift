class Solution {
    var records: [String: Bool] = [:]
    
    func isScramble(_ s1: String, _ s2: String) -> Bool {
        return isSubStringScramble(Substring(s1), Substring(s2))
    }
    
    func isSubStringScramble(_ s1: Substring, _ s2: Substring) -> Bool {
        let sIndex = String(s1 + ":" + s2)
        if let b = records[sIndex] {
            return b
        }
        
        if (s1 == s2) {
            records[sIndex] = true
            return true
        }
        
        var count: [Int] = Array(repeating: 0, count: 26)
        
        for c in s1 {
            count[Int(c.asciiValue! - Character("a").asciiValue!)] += 1
        }
        
        for c in s2 {
            count[Int(c.asciiValue! - Character("a").asciiValue!)] -= 1
        }
        
        for i in count {
            if i != 0 {
                records[sIndex] = false
                return false
            }
        }
        
        var i1 = s1.index(after: s1.startIndex)
        var i2 = s2.index(after: s2.startIndex)
        
        var j2 = s2.index(before: s2.endIndex)
        
        for i in 1..<s1.count {
            if isSubStringScramble(s1[s1.startIndex..<i1], s2[s2.startIndex..<i2])
            && isSubStringScramble(s1[i1...],  s2[i2...]) {
                records[sIndex] = true
                return true
            }
            
            if isSubStringScramble(s1[s1.startIndex..<i1], s2[j2..<s2.endIndex])
            && isSubStringScramble(s1[i1..<s1.endIndex],  s2[s2.startIndex..<j2]) {
                records[sIndex] = true
                return true
            }

            i1 = s1.index(after: i1)
            i2 = s2.index(after: i2)
            j2 = s2.index(before: j2)
        }
        
        records[sIndex] = false
        return false
    }
}