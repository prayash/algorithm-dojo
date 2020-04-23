/**
 Given two sparse matrices A and B, return the result of AB.
 You may assume that A's column number is equal to B's row number.

 Input:

     A = [[ 1, 0, 0],
          [-1, 0, 3]]

     B = [[ 7, 0, 0 ],
          [ 0, 0, 0 ],
          [ 0, 0, 1 ]]

 Output:

          |  1 0 0 |   | 7 0 0 |   |  7 0 0 |
     AB = | -1 0 3 | x | 0 0 0 | = | -7 0 3 |
                       | 0 0 1 |
 */

class Solution {
    /**
     Naive way to calculate the multiplication of two matrices `A` and `B` is to take all
     values from the first row of `A`, take all values from first column of `B`, multiply the
     corresponding values and sum them up. The final sum is the value for the location of `[0][0]`
     in the resulting matrix. To get `[0][1]`, do the same with the second column of `B`.
     */
    func multiplyMatricesBruteForce(_ A: [[Int]], _ B: [[Int]]) -> [[Int]] {
        let rows = A.count
        let cols = A[0].count
        let nB = B[0].count

        // Initialize the result matrix to 0.
        var C = [[Int]].init(repeating: [Int].init(repeating: 0, count: nB), count: rows)

        for i in 0..<rows {
            for j in 0..<nB {
                C[i][j] = 0

                for k in 0..<cols {
                    C[i][j] += A[i][k] * B[k][j]
                }
            }
        }

        return C
    }

    func multiplyMatrices(_ A: [[Int]], _ B: [[Int]]) -> [[Int]] {
        let rows = A.count
        let cols = A[0].count
        let nB = B[0].count

        // Initialize the result matrix to 0.
        var C = [[Int]].init(repeating: [Int].init(repeating: 0, count: nB), count: rows)

        for i in 0..<rows {
            for k in 0..<cols {

                // Only if A[i][k] is not 0, do we want to proceed with multiplying the row
                if A[i][k] != 0 {
                    for j in 0..<nB {
                        C[i][j] += A[i][k] * B[k][j]
                    }
                }
            }
        }

        return C
    }
}

let A = [
    [1, 0, 0],
    [-1, 0, 3]
]

let B = [
    [7, 0, 0],
    [0, 0, 0],
    [0, 0, 1]
]

print(Solution().multiplyMatricesBruteForce(A, B))
print(Solution().multiplyMatrices(A, B))
