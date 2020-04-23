class Solution {
    func isMatch(_ str: String, _ pattern: String) -> Bool {
        var map: [Character: String] = [:]
        return helper(&map, str, 0, 0, pattern)
    }

    func helper(_ m: inout [Character: String], _ str: String, _ i: Int, _ j: Int, _ pattern: String) -> Bool {
        if i == str.count && j == pattern.count {
            return true
        }

        if i == str.count || j == pattern.count {
            return false
        }

        let char = pattern[pattern.index(pattern.startIndex, offsetBy: j)]

        if let patternString = m[char] {
            let idx = str.index(str.startIndex, offsetBy: i)

            if (i + patternString.count > str.count) || !(String(str[idx...]) == patternString) {
                return false
            }

            return helper(&m, str, i + patternString.count, j + 1, pattern)
        }

        for k in i..<str.count {
            let beginIdx = str.index(str.startIndex, offsetBy: i)
            let endIdx = str.index(str.startIndex, offsetBy: k + 1)
            m[char] = String(str[beginIdx..<endIdx])

            if helper(&m, str, k + 1, j + 1, pattern) {
                return true
            }

            m[char] = nil
        }

        return false
    }
}

print(Solution().isMatch("abab", "redblueredblue"))

//extension String {
//    subscript(i: Int) -> Character {
//        return self[index(startIndex, offsetBy: i)]
//    }
//}
