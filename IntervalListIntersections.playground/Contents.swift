/**
 Given two lists of closed intervals, each list of intervals is pairwise disjoint and in sorted order.
 Return the intersection of these two interval lists.
 */

class Solution {
    func intervalIntersection(_ A: [[Int]], _ B: [[Int]]) -> [[Int]] {
        var intersections: [[Int]] = []

        var i = 0, j = 0
        while i < A.count && j < B.count {
            let start = max(A[i][0], B[j][0])
            let end = min(A[i][1], B[j][1])

            if start <= end {
                intersections.append([start, end])
            }

            if A[i][1] < B[j][1] {
                i += 1
            } else {
                j += 1
            }
        }

        return intersections
    }
}

var A = [[0, 2], [5, 10], [13, 23], [24, 25]]
var B = [[1, 5], [8, 12], [15, 24], [25, 26]]
print(Solution().intervalIntersection(A, B))
