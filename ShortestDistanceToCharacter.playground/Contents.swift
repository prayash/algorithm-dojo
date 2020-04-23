/**
 Given a string S and a character C, return an array of integers representing the shortest distance
 from the character C in the string.

 Example 1:

 Input: S = "loveleetcode", C = 'e'
 Output: [3, 2, 1, 0, 1, 0, 0, 1, 2, 2, 1, 0]
 */

class Solution {
    func shortestToChar(_ S: String, _ C: Character) -> [Int] {
        var lPtr = -1
        var rPtr = 0
        var occurences = [Int]()
        let S = Array(S)
        var result = [Int].init(repeating: 0, count: S.count)

        for i in 0..<S.count {
            if S[i] == C {
                occurences.append(i)
            }
        }

        for i in 0..<S.count {
            if lPtr != -1 {
                result[i] = min(abs(occurences[lPtr] - i), abs(occurences[rPtr] - i))
            } else {
                result[i] = abs(occurences[rPtr] - i)
                lPtr = 0
            }

            if i > occurences[rPtr] {
                rPtr += 1
                lPtr += 1
            }

            print(occurences)
            print(result, lPtr, rPtr)
        }

        return []
    }
}

print(Solution().shortestToChar("loveleetcode", "e"))
