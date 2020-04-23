/**
 Given two strings `str1` and `str2` of the same length, determine whether you can transform `str1`
 into `str2` by doing zero or more conversions.

 In one conversion you can convert all occurrences of one character in `str1` to any other
 lowercase English character.

 Return true if and only if you can transform `str1` into `str2`.

 Input: str1 = "aabcc", str2 = "ccdee"
 Output: true
 Explanation: Convert 'c' to 'e' then 'b' to 'd' then 'a' to 'c'. Note that the order of
 conversions matter.

 Input: str1 = "leetcode", str2 = "codeleet"
 Output: false
 Explanation: There is no way to transform str1 to str2.
 */

class Solution {
    /**
     Model the problem as a graph. Edges represent mapping relationships. The out-degree of
     a node can only be smaller or equal to 1, otherwise we should return false immediately.
     */
    func canConvert(_ str1: String, _ str2: String) -> Bool {
        if str1 == str2 {
            return true
        }

        var hashMap: [Character: Character] = [:]

        for i in 0..<str1.count {
            let charOne = str1[i]
            let charTwo = str2[i]

            // We've found an existing node, but its outdegree is different
            // than what we saw previously (the same char points to two different chars)
            if let existingChar = hashMap[charOne], existingChar != charTwo {
                return false
            }

            // Store the mapping
            hashMap[charOne] = charTwo
        }

        // If the value count is 26, that implies the key count is 26 too, so we have one to one mappings.
        // If str1 is not the same as str2, a cycle must exist, but there is no unused character to
        // break the cycle, so we return false.
        return Set<Character>(hashMap.values).count < 26
    }
}

extension String {
    subscript(i: Int) -> String.Element {
        return self[index(startIndex, offsetBy: i)]
    }
}

//print(Solution().canConvert("aabcc", "ccdee"))
//print(Solution().canConvert("leetcode", "codeleet"))
//print(Solution().canConvert("abcdefghijklmnopqrstuvwxyz", "bcdefghijklmnopqrstuvwxyza"))
print(Solution().canConvert("abcdefghijklmnopqrstuvwxyz", "bcdefghijklmnopqrstuvwxyzq"))
