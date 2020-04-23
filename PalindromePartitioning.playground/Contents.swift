/**
 Given a string s, partition s such that every substring of the partition is a palindrome.
 Return all possible palindrome partitioning of s.

 Example:

 Input: "aab"
 Output:
 [
   ["aa","b"],
   ["a","a","b"]
 ]
 */

class Solution {
    /**
     All backtracking problems are composed of 3 steps: Choose, Explore, Unchoose.

     For each problem, we need to know:
     1. Choose: For this problem, we choose each substring.
     2. Explore: We do the same thing to the remaining string.
     3. Unchoose: Do the opposite operation of choose.

     Helpers are typically used in backtracking problems, to accept more parameters.
     We'll typically use the following params in the helper:

     1. The object we're working on, for example the input string `s`.
     2. A start index or an end index which indicates which part of the object we're working on.
     For this problem we use substring to indicate the start index.
     3. A step result, to remember current choice and to undo that same choice. We'll use a list of strings.
     4. A final result to remember the output and add to it.

     The components of our solution are:
     1. Base case: The base case defines when to add step into result, and when to return.
     2. For-loop: Usually, we'll need to iterate through the input String `s`, so we can choose all options.
     3. Choose: If the substring of s is a palindrome, we add it into step, which means we choose the substring.
     4. We want to do the same thing to the remaining substring, so recursively invoke the helper.
     5. We remove the chosen substring in order to try other options (thus the name backtracking).

     - Complexity: O(n!) time
     */
    func partition(_ s: String) -> [[String]] {
        guard s.count > 0 else {
            return []
        }

        var output = [[String]]()
        var candidate = [String]()

        backtrack(s, &output, &candidate)
        return output
    }

    func backtrack(_ s: String, _ output: inout [[String]], _ candidate: inout [String]) {
        if s.count == 0 {
            output.append(candidate)
            return
        }

        for i in 1...s.count {
            let temp = s.substring(0, i)

            if isPalindrome(temp) {
                candidate.append(temp)
                backtrack(s.substring(i, s.count), &output, &candidate)
                candidate.removeLast()
            }
        }

        return
    }

    private func isPalindrome(_ s: String) -> Bool {
        func helper(_ s: [Character], _ start: Int, _ end: Int) -> Bool {
            guard start < end else {
                return true
            }

            return s[start] == s[end] && helper(s, start + 1, end - 1)
        }

        return helper(Array(s), 0, s.count - 1)
    }
}

extension String {
    func substring(_ start: Int, _ end: Int) -> String {
        return String(self[index(startIndex, offsetBy: start)..<index(startIndex, offsetBy: end)])
    }
}

print(Solution().partition("aab"))
