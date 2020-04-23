/**
 A message containing letters from A-Z is being encoded to numbers using the following mapping:

 'A' -> 1
 'B' -> 2
 ...
 'Z' -> 26
 Given a non-empty string containing only digits, determine the total number of ways to decode it.

 Input: "12"
 Output: 2
 Explanation: It could be decoded as "AB" (1 2) or "L" (12).

 Input: "226"
 Output: 3
 Explanation: It could be decoded as "BZ" (2 26), "VF" (22 6), or "BBF" (2 2 6).
 */

class Solution {
    /**
     DP approach here is to do a single pass through the entire string, storing a list
     of the number of ways to decode a string of length n. The algorithm works like the fibonacci
     sequence but with two conditions. We need to be mindful of whether at each point we're on a
     single digit number of a double digit number (because A...Z is 1...26).
     - Complexity: O(n) time and O(n) space
     */
    func numDecodings(_ s: String) -> Int {
        guard s.count > 0 else {
            return 0
        }

        var dp = [Int].init(repeating: 0, count: s.count + 1)

        dp[0] = 1
        dp[1] = s.first! == "0" ? 0 : 1

        for i in 2...s.count {
            let endOfRange = s.index(s.startIndex, offsetBy: i)

            let oneDigit = Int(
                s[s.index(s.startIndex, offsetBy: i - 1)..<endOfRange]
            )!

            let twoDigits = Int(
                s[s.index(s.startIndex, offsetBy: i - 2)..<endOfRange]
            )!

            if oneDigit >= 1 && oneDigit <= 9{
                dp[i] += dp[i - 1]
            }

            if twoDigits >= 10 && twoDigits <= 26 {
                dp[i] += dp[i - 2]
            }
        }

        print(dp)

        return dp[s.count]
    }
}

extension String {
    subscript(i: Int) -> String.Element {
        return self[index(startIndex, offsetBy: i)]
    }
}

print(Solution().numDecodings("12"))
print(Solution().numDecodings("226"))
