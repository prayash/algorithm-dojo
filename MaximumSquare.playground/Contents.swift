/**
 Given a 2D binary matrix filled with 0's and 1's, find the largest square
 containing only 1's and return its area.

 Input:

 1 0 1 0 0
 1 0 1 1 1
 1 1 1 1 1
 1 0 0 1 0

 Output: 4
 */

class Solution {
    /**
     Brute force: O(mn ^ 2) time 🤮
     We use a variable to track the maximum area we've seen, and another to store
     the size of the current.
     */
    func maximalSquare(_ matrix: [[String]]) -> Int {
        guard matrix.count > 0 else { return 0 }

        var maxSquareLength: Int = 0
        let rows = matrix.count

        //  Starting from the left uppermost point in the matrix, we search for a 1
        for i in 0..<rows {
            let columns = matrix[i].count

            for j in 0..<columns {
                // Whenever a 1 is found, we try to find out the largest square
                // that can be formed including that 1.
                if matrix[i][j] == "1" {
                    var squareLength: Int = 1
                    var flag: Bool = true

                    // We move diagonally (right and downwards), i.e. we increment the row index
                    // and column index temporarily and then check whether all the elements of
                    // that row and column are 1 or not.
                    while squareLength + i < rows && squareLength + j < columns && flag {
                        for x in j...squareLength + j {
                            if matrix[i + squareLength][x] == "0" {
                                flag = false
                                break
                            }
                        }

                        for x in i...squareLength + i {
                            if matrix[x][j + squareLength] == "0" {
                                flag = false
                                break
                            }
                        }

                        if flag {
                            squareLength += 1
                        }

                        maxSquareLength = max(maxSquareLength, squareLength)
                    }
                }
            }
        }

        return maxSquareLength * maxSquareLength
    }

    /**
     DP solution: O(m * n) 👍
     We initialize another matrix (dp) with the same dimensions as the original one initialized with all 0’s.
     dp(i, j) represents the side length of the maximum square whose bottom right corner is
     the cell with index (i, j) in the original matrix.
     */
    func maximalSquareDP(_ matrix: [[String]]) -> Int {
        guard matrix.count > 0 else { return 0 }

        let rows = matrix.count
        let columns = matrix[0].count
        var maxSquareLength = 0

        /**
         Starting from index (0,0), for every 1 found in the original matrix, we update the value of
         the current element as dp[i, j] = min(dp[i − 1, j],dp[i − 1, j − 1], dp[i, j − 1]) + 1.
         At each index, the min value in the top, topLeft, and left values in the dp matrix show
         us the max length of a square. The DP matrix is one size bigger so we can store zeroes for outer bounds,
         indicating that a square isn't possible with respect to the original matrix.
         */
        var dp = [[Int]](repeatElement([Int](repeatElement(0, count: columns + 1)), count: rows + 1))

        for i in 1...rows {
            for j in 1...columns {
                guard matrix[i - 1][j - 1] == "1" else { continue }

                let left = dp[i][j - 1]
                let top = dp[i - 1][j]
                let topLeft = dp[i - 1][j - 1]

                dp[i][j] = min(min(left, topLeft), top) + 1
                maxSquareLength = max(maxSquareLength, dp[i][j])
            }
        }

        return maxSquareLength * maxSquareLength
    }
}

var matrix = [
    ["1", "0", "1", "0", "0"],
    ["1", "0", "1", "1", "1"],
    ["1", "1", "1", "1", "1"],
    ["1", "0", "0", "1", "0"]
]

print(Solution().maximalSquare(matrix))

matrix = [
    ["0", "1", "1", "1", "0"],
    ["1", "1", "1", "1", "1"],
    ["0", "1", "1", "1", "1"],
    ["0", "1", "1", "1", "1"],
    ["0", "0", "1", "1", "1"]
]

print(Solution().maximalSquareDP(matrix))
