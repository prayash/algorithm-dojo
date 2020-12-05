/// You are given coins of different denominations and a total amount of money amount. Write a
/// function to compute the fewest number of coins that you need to make up that amount. If that
/// amount of money cannot be made up by any combination of the coins, return -1.
///
/// Input: coins = [1, 2, 5], amount = 11
/// Output: 3
/// Explanation: 11 = 5 + 5 + 1

class Solution {
    /// Bottom-up using an auxiliary dp table.
    /// - Complexity: `O(A * n)` time where A is the amount and n is denominations available.
    /// `O(A)` space for dp table.
    func coinChange(_ coins: [Int], _ amount: Int) -> Int {
        let maximum = amount + 1
        var dp: [Int] = [Int].init(repeating: maximum, count: amount + 1)

        // The answer to making change with minimum coins for 0 will always be 0
        dp[0] = 0

        // Solve every subproblem from 1 to amount
        for i in 1...amount {
            coins.forEach { coin in
                // If it is less than or equal to the sub problem amount
                if coin <= i {
                    dp[i] = min(dp[i], dp[i - coin] + 1)
                }
            }
        }

        return dp[amount] > amount ? -1 : dp[amount]
    }
}

print(Solution().coinChange([1, 2, 5], 11))
