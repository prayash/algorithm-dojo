/**
 Given a string s of '(' , ')' and lowercase English characters.
 Your task is to remove the minimum number of parentheses ( '(' or ')', in any positions ) so that
 the resulting parentheses string is valid and return any valid string.

 Formally, a parentheses string is valid if and only if:
 It is the empty string, contains only lowercase characters, or
 It can be written as AB (A concatenated with B), where A and B are valid strings, or
 It can be written as (A), where A is a valid string.

 Input: s = "lee(t(c)o)de)"
 Output: "lee(t(c)o)de"
 Explanation: "lee(t(co)de)" , "lee(t(c)ode)" would also be accepted.
 */

class Solution {
    /**
     We'll maintain a stack in order to keep tracking of opening and closing parens.
     The stack should be empty by the end of our string traversal, otherwise there's an imbalance.
     We'll mark indices where these imbalances occur, and remove the characters from the final string.
     - Complexity: O(n) time and space for taking 2 full passes through the string.
     */
    func minRemoveToMakeValid(_ s: String) -> String {
        let s = Array(s)
        var indicesToRemove = Set<Int>()
        var stack = [Int]()
        var result = [Character]()

        for i in 0..<s.count {
            if s[i] == "(" {
                stack.append(i)
            } else if s[i] == ")" {
                // An imbalance because we've seen a closing paren without a matching opening
                // We'll mark this as the index to remove in the final string
                if stack.isEmpty {
                    indicesToRemove.insert(i)
                } else {
                    // A balanced closing paren, pop it from the stack
                    stack.popLast()
                }
            }
        }

        // Put remaining indices of the stack into the set
        while !stack.isEmpty {
            if let index = stack.popLast() {
                indicesToRemove.insert(index)
            }
        }

        for i in 0..<s.count {
            if !indicesToRemove.contains(i) {
                result.append(s[i])
            }
        }

        return String(result)
    }
}

extension String {
    subscript(i: Int) -> Character {
        return self[index(startIndex, offsetBy: i)]
    }
}

print(Solution().minRemoveToMakeValid("lee(t(c)o)de)"))
