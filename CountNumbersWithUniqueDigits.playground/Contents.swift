/**
 Given a non-negative integer n, count all numbers with unique digits, x, where 0 ≤ x < 10^n.

 Example:

 Input: 2
 Output: 91
 Explanation: The answer should be the total numbers in the range of 0 ≤ x < 100,
              excluding 11,22,33,44,55,66,77,88,99
 */

class Solution {
    /**
     A variation of a permutation + subset problem. Start from 0 every recursion and count through the path.
     */
    func countNumbersWithUniqueDigits(_ n: Int) -> Int {
        var used = [Bool].init(repeating: false, count: 10)
        return count(n, 0, &used)
    }

    private func count(_ n: Int, _ digit: Int, _ used: inout [Bool]) -> Int {
        if digit == n {
            return 1
        }

        var total = 1
        for i in (digit == 0 ? 1 : 0)...9 {
            if !used[i] {
                used[i] = true
                total += count(n, digit + 1, &used)
                used[i] = false
            }
        }

        return total
    }
}

print(Solution().countNumbersWithUniqueDigits(1))
