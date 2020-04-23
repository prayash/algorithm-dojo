/**
 Given two strings S and T, return if they are equal when both are typed into empty text editors.
 # means a backspace character.

 Example 1:

 Input: S = "ab#c", T = "ad#c"
 Output: true
 Explanation: Both S and T become "ac".
 Example 2:

 Input: S = "ab##", T = "c#d#"
 Output: true
 Explanation: Both S and T become "".
 */

class Solution {
    func backspaceCompare(_ S: String, _ T: String) -> Bool {
        var i = S.count - 1
        var j = T.count - 1
        var skipS = 0
        var skipT = 0

        while i >= 0 || j >= 0 {
            while i >= 0 {
                if S[i] == "#" {
                    skipS += 1
                    i -= 1
                } else if skipS > 0 {
                    skipS -= 1
                    i -= 1
                } else {
                    break
                }
            }

            while j >= 0 {
                if T[j] == "#" {
                    skipT += 1
                    j -= 1
                } else if skipT > 0 {
                    skipT -= 1
                    j -= 1
                } else {
                    break
                }
            }

            let left = i < 0 ? "*" : S[i]
            let right = j < 0 ? "*" : T[j]

            if left != right {
                return false
            }

            i -= 1
            j -= 1
        }

        return true
    }
}

extension String {
    subscript(i: Int) -> Character {
        return self[index(startIndex, offsetBy: i)]
    }
}

print(Solution().backspaceCompare("ab#c", "ad#c"))
