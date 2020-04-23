/**
 Given an array of integers A sorted in non-decreasing order, return an array of the squares of each number, also in sorted non-decreasing order.

     Input: [-4, -1, 0, 3, 10]
     Output: [0, 1, 9, 16, 100]
 */

class Solution {
    func sortedSquares(_ A: [Int]) -> [Int] {
        var result = Array(repeating: 0, count: A.count)

        var i = 0
        var j = A.count - 1

        for p in (0..<A.count).reversed() {
            if abs(A[i]) > abs(A[j]) {
                result[p] = A[i] * A[i]
                i += 1
            } else {
                result[p] = A[j] * A[j]
                j -= 1
            }
        }

        return result
    }
}

var input = [-4, -1, 0, 3, 10]
print(Solution().sortedSquares(input))
