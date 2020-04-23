/**
 Given a string S of lowercase letters, a duplicate removal consists of choosing two adjacent
 and equal letters, and removing them.

 We repeatedly make duplicate removals on S until we no longer can.

 Return the final string after all such duplicate removals have been made. It is guaranteed
 the answer is unique.

 Input: "abbaca"
 Output: "ca"
 For example, in "abbaca" we could remove "bb" since the letters are adjacent and equal, and
 this is the only possible move.  The result of this move is that the string is "aaca", of which
 only "aa" is possible, so the final string is "ca".
 */

class Solution {
    func removeDuplicates(_ S: String) -> String {
        var stack: [Character] = []

        for char in S {
            if let lastItem = stack.last, lastItem == char {
                stack.popLast()
            } else {
                stack.append(char)
            }
        }

        return String(stack)
    }
}

var input = "lelllcooodeeez"
print(Solution().removeDuplicates(input))
