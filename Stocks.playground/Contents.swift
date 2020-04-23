/**
 Say you have an array for which the ith element is the price of a given stock on day i.

 If you were only permitted to complete at most one transaction (i.e., buy one and sell
 one share of the stock), design an algorithm to find the maximum profit.

 Note that you cannot sell a stock before you buy one.
 */

class Solution {
    // Brute force: O(n ^ 2) 🤮
    func maxProfitNaive(_ prices: [Int]) -> Int {
        var profit = 0

        for i in 0..<prices.count {
            let buyingPrice = prices[i]

            for j in i + 1..<prices.count {
                let sellingPrice = prices[j]
                let potentialProfit = sellingPrice - buyingPrice

                profit = max(potentialProfit, profit)
            }
        }

        return profit
    }

    // Greedy approach 😎
    func maxProfit(_ prices: [Int]) -> Int {
        var minPrice = Int.max
        var maxProfit = 0

        for i in 0..<prices.count {
            let currPrice = prices[i]

            // Evaluate profit
            let potential = currPrice - minPrice

            // Update the max value if potential is higher
            maxProfit = max(maxProfit, potential)

            // Ensure minPrice is the lowest we've seen so far
            minPrice = min(minPrice, currPrice)
        }

        return maxProfit
    }
}

var prices = [7, 1, 5, 3, 6, 4]
print(Solution().maxProfit(prices))
