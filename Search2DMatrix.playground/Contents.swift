/**
 Write an efficient algorithm that searches for a value in an m x n matrix. This matrix
 has the following properties:

 Integers in each row are sorted in ascending from left to right.
 Integers in each column are sorted in ascending from top to bottom.

 Consider the following matrix:
 [
   [1,   4,  7, 11, 15],
   [2,   5,  8, 12, 19],
   [3,   6,  9, 16, 22],
   [10, 13, 14, 17, 24],
   [18, 21, 23, 26, 30]
 ]

 Given target = 5, return true.
 Given target = 20, return false.
 */

class Solution {
    /**
     Iterate through the rows of the matrix and run a binary search routine each time.
     - Complexity: O(m * log(n)) where m is the number of rows and n is number of columns.
     */
    func searchMatrix(_ matrix: [[Int]], _ target: Int) -> Bool {
        for row in 0..<matrix.count {
            var i = 0
            var j = matrix[row].count

            while i < j {
                let mid = i + (j - i) / 2

                if matrix[row][mid] == target {
                    return true
                }

                if matrix[row][mid] < target {
                    i = mid + 1
                } else if matrix[row][mid] > target {
                    j = mid
                }
            }
        }

        return false
    }

    /**
     Search space reduction using binary search on the entire matrix. We can take advantage
     of the fact that the matrix is sorted row-wise and column-wise.
     - Complexity: O(m + n)
     */
    func searchMatrixOptimized(_ matrix: [[Int]], _ target: Int) -> Bool {
        var i = matrix.count - 1
        var j = 0

        while i >= 0 && j < matrix[0].count {
            if matrix[i][j] > target {
                i -= 1
            } else if matrix[i][j] < target {
                j += 1
            } else if matrix[i][j] == target {
                return true
            }
        }

        return false
    }
}

let m = [
  [1, 4, 7, 11, 15],
  [2, 5, 8, 12, 19],
  [3, 6, 9, 16, 22],
  [10, 13, 14, 17, 24],
  [18, 21, 23, 26, 30]
]

print(Solution().searchMatrix(m, 5))
print(Solution().searchMatrix(m, 20))
