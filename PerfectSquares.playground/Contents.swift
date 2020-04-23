import Foundation

/**
 Given a positive integer n, find the least number of perfect square numbers
 (for example, 1, 4, 9, 16, ...) which sum to n.

 Example 1:

 Input: n = 12
 Output: 3
 Explanation: 12 = 4 + 4 + 4.
 Example 2:

 Input: n = 13
 Output: 2
 Explanation: 13 = 4 + 9.
 */

class Solution {
    func numSquares(_ n: Int) -> Int {
        var sqNums = [Int]()
        let sqRoot = Int(Double(n).squareRoot())
        for i in 1..<sqRoot + 1 {
            sqNums.append(Int(pow(Double(i), Double(2))))
        }

        func minSquares(_ k: Int) -> Int {
            if sqNums.contains(k) {
                return 1
            }

            var minNum = Int(Int.max)
            for sq in sqNums {
                if k < sq {
                    break
                }

                minNum = min(minNum, minSquares(k - sq) + 1)
            }

            return minNum
        }

        return minSquares(n)
    }

    func numSquaresBFS(_ n: Int) -> Int {
        // Prepare a list of sq numbers below n
        var sqNums = [Int]()
        let sqRoot = Int(Double(n).squareRoot())
        for i in 1..<sqRoot + 1 {
            sqNums.append(Int(pow(Double(i), Double(2))))
        }

        // Maintain a BFS queue
        var bfsQueue = Set<Int>()
        bfsQueue.insert(n)

        var level = 0
        while !bfsQueue.isEmpty {
            level += 1

            // We create a new queue of type Set in order to eliminate
            // redundancy of remainders within the same level!
            var nextQueue = Set<Int>()
            for remainder in bfsQueue {
                for sq in sqNums {
                    // Once we get perfect match, we return the depth we traversed in the tree
                    if remainder == sq {
                        return level
                    } else if remainder < sq {
                        // If the remainder < any of our sq choices, we can't subtract anymore.
                        break
                    } else {
                        nextQueue.insert(remainder - sq)
                    }
                }
            }

            print(nextQueue)
            bfsQueue = nextQueue
        }

        return level
    }
}

print(Solution().numSquaresBFS(12))
