/**
 Given s1, s2, s3, find whether s3 is formed by the interleaving of s1 and s2.

 Input: s1 = "aabcc", s2 = "dbbca", s3 = "aadbbcbcac"
 Output: true

 Input: s1 = "aabcc", s2 = "dbbca", s3 = "aadbbbaccc"
 Output: false
 */

class Solution {
    typealias S = String

    private func isInterleave(_ s1: S, _ i: Int, _ s2: S, _ j: Int, _ res: S, _ s3: S) -> Bool {
        if res == s3 && i == s1.count && j == s2.count {
            return true
        }

        var answer = false

        if i < s1.count {
            answer = answer || isInterleave(s1, i + 1, s2, j, res + String(Array(s1)[i]), s3)
        }

        if j < s2.count {
            answer = answer || isInterleave(s1, i, s2, j + 1, res + String(Array(s2)[j]), s3)
        }

        return answer
    }

    func isInterleave(_ s1: String, _ s2: String, _ s3: String) -> Bool {
        return isInterleave(s1, 0, s2, 0, "", s3)
    }
}

var a = "hlo"
var b = "elw"
var c = "hellow"
print(Solution().isInterleave(a, b, c))
