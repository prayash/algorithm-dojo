/**
 Given a matrix of m x n elements (m rows, n columns), return all elements of the matrix in spiral order.

 Example 1:

     Input:
     [[ 1, 2, 3 ],
      [ 4, 5, 6 ],
      [ 7, 8, 9 ]]

     Output: [1,2,3,6,9,8,7,4,5]

 */
class Solution {
    /**
     Draw a spiral path, looping clockwise whenever we go out of bounds or into a cell
     that was previously visited.
     - Complexity: O(n) time and space.
     */
    func spiralOrder(_ matrix: [[Int]]) -> [Int] {
        var res = [Int]()
        guard matrix.count > 0 else {
            return res
        }

        let n = matrix.count
        let m = matrix[0].count
        var rowA = 0, rowB = n
        var colA = 0, colB = m

        while res.count < n * m {
            for c in stride(from: colA, to: colB, by: 1) {
                res.append(matrix[rowA][c])
            }

            for r in stride(from: rowA + 1, to: rowB, by: 1) {
                res.append(matrix[r][colB - 1])
            }

            if rowA < rowB - 1 && colA < colB - 1 {
                for c in stride(from: colB - 2, to: colA, by: -1) {
                    res.append(matrix[rowB - 1][c])
                }

                for r in stride(from: rowB - 1, to: rowA, by: -1) {
                    res.append(matrix[r][colA])
                }
            }

            rowA += 1
            rowB -= 1
            colA += 1
            colB -= 1
        }

        return res
    }
}

let matrix = [
 [ 1, 2, 3 ],
 [ 4, 5, 6 ],
 [ 7, 8, 9 ]
]
print(Solution().spiralOrder(matrix))
