/**
 Given an encoded string, return its decoded string.
 The encoding rule is: k[encoded_string], where the encoded_string inside the square brackets is
 being repeated exactly k times. Note that k is guaranteed to be a positive integer.

 You may assume that the input string is always valid; No extra white spaces, square brackets are
 well-formed, etc.

 Furthermore, you may assume that the original data does not contain any digits and that digits are
 only for those repeat numbers, k. For example, there won't be input like 3a or 2[4].

     s = "3[a]2[bc]", return "aaabcbc".
     s = "3[a2[c]]", return "accaccacc".
     s = "2[abc]3[cd]ef", return "abcabccdcdcdef".
 */

class Solution {
    /**
     Maintain two stacks to keep track of counts and opening/closing brackets.
     For Character number checking: https://stackoverflow.com/a/54830712/2272112
     */
    func decodeString(_ s: String) -> String {
        var countStack: [Int] = []
        var bracketStack: [String] = []
        var res = ""
        var index = 0

        while index < s.count {
            if s[index].isNumber {
                var count = 0

                // Account for multi-digit counts
                while s[index].isNumber {
                    count = 10 * count + Int(String(s[index]))!
                    index += 1
                }

                countStack.append(count)
            } else if s[index] == "[" {
                bracketStack.append(res)
                res = ""
                index += 1
            } else if s[index] == "]" {
                // Once the bracket closes, we can do the string expansion
                if var str = bracketStack.popLast(), let count = countStack.popLast() {
                    for _ in 0..<count {
                        str.append(res)
                    }

                    res = str
                    index += 1
                }
            } else {
                // Build a continuous stream of characters unless we hit any delimiters
                res += String(s[index])
                index += 1
            }
        }

        return res
    }
}

extension String {
  subscript (i: Int) -> Character {
    return self[index(startIndex, offsetBy: i)]
  }
}

print(Solution().decodeString("3[a]2[bc]"))
print(Solution().decodeString("2[abc]3[cd]ef"))
