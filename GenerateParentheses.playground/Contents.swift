/**
 Given n pairs of parentheses, write a function to generate all combinations of well-formed parentheses.

 For example, given n = 3, a solution set is:

 [
   "((()))",
   "(()())",
   "(())()",
   "()(())",
   "()()()"
 ]
 */

class Solution {
    /**
     Use backtracking to explore all options.
     - Complexity: `O(b ^ d)` where `b` is the branching factor and `d` is the maximum depth of recursion.
     Backtracking is characterized by a number of decisions `b` that can be made at each level of recursion.
     If we visualize the recursion tree, this is the number of children each internal node has. We can also
     think of `b` as standing for "base", which can help us remember that `b` is the base of the exponential.
     If we can make `b` decisions at each level of recursion, and we expand the recursion tree to `d` levels,
     then we get b ^ d nodes. Since backtracking is exhaustive and must visit all nodes, such is the runtime.
     */
    func generateParenthesis(_ n: Int) -> [String] {
        var result = [String]()

        func backtrack(_ current: String, _ open: Int, _ close: Int) {
            if current.count == n * 2 {
                result.append(current)
                return
            }

            if open < n {
                backtrack(current + "(", open + 1, close)
            }

            if close < open {
                backtrack(current + ")", open, close + 1)
            }
        }

        backtrack("", 0, 0)
        return result
    }
}

print(Solution().generateParenthesis(2))
