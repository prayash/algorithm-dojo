/**
 Given a 2D matrix matrix, find the sum of the elements inside the rectangle defined by its
 upper left corner (row1, col1) and lower right corner (row2, col2).

     Given matrix = [
       [3, 0, 1, 4, 2],
       [5, 6, 3, 2, 1],
       [1, 2, 0, 1, 5],
       [4, 1, 0, 1, 7],
       [1, 0, 3, 0, 5]
     ]

     sumRegion(2, 1, 4, 3) -> 8
     sumRegion(1, 1, 2, 2) -> 11
     sumRegion(1, 2, 2, 4) -> 12
 */

class NumMatrix {
    var dp: [[Int]] = []

    init(_ matrix: [[Int]]) {
        guard matrix.count > 0 else { return }

        dp = [[Int]].init(repeating: [Int].init(repeating: 0, count: matrix[0].count + 1), count: matrix.count)

        for i in 0..<matrix.count {
            for j in 0..<matrix[0].count {
                dp[i][j + 1] = dp[i][j] + matrix[i][j]
            }
        }

        print(dp)
    }

    /**
     We've stored a DP table filled with the sums at each corner. For calculating the range sum
     we simply iterate through the two rows and calculating the different between x2 and x2.
     - Complexity: O(m) time to work thru the rows. O(mn) for pre-computation. O(mn) space for dp.
     */
    func sumRegion(_ row1: Int, _ col1: Int, _ row2: Int, _ col2: Int) -> Int {
        var sum = 0

        for i in row1...row2 {
            sum += dp[i][col2 + 1] - dp[i][col1]
        }

        return sum
    }
}

/**
 * Your NumMatrix object will be instantiated and called as such:
 * let obj = NumMatrix(matrix)
 * let ret_1: Int = obj.sumRegion(row1, col1, row2, col2)
 */

let nm = NumMatrix([
  [3, 0, 1, 4, 2],
  [5, 6, 3, 2, 1],
  [1, 2, 0, 1, 5],
  [4, 1, 0, 1, 7],
  [1, 0, 3, 0, 5]
])

print(nm.sumRegion(2, 1, 4, 3))
