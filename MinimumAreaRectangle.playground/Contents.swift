/**
 Given a set of points in the xy-plane, determine the minimum area of a rectangle
 formed from these points, with sides parallel to the x and y axes.
 If there isn't any rectangle, return 0.

     Example 1:
     Input: [[1,1],[1,3],[3,1],[3,3],[2,2]]
     Output: 4

     Example 2:
     Input: [[1,1],[1,3],[3,1],[3,3],[4,1],[4,3]]
     Output: 2

     Note:
     1 <= points.length <= 500
     0 <= points[i][0] <= 40000
     0 <= points[i][1] <= 40000
     All points are distinct.
 */

class Solution {
    /**
     Calculate the minimum area using diagonal points. Put em all in a hash table, and
     for each pair of points, if the associated rectangle are 4 distinct points all in
     the set, then we have a candidate rectangle.
     - Complexity: O(n ^ 2) where n is the number of points. O(n) space.
     */
    func minAreaRect(_ points: [[Int]]) -> Int {
        var map: [Int: Set<Int>] = [:]

        for p in points {
            map[p[0], default: Set<Int>()].insert(p[1])
        }

        var minArea = Int.max
        for i in 0..<points.count - 1 {
            for j in i + 1..<points.count {
                let x1 = points[i][0]
                let x2 = points[j][0]
                let y1 = points[i][1]
                let y2 = points[j][1]

                // We only want to calculate diagonals
                if x1 == x2 || y1 == y2 {
                    continue
                }

                // Find other two diagonal points
                if map[x1]!.contains(y2) && map[x2]!.contains(y1) {
                    minArea = min(minArea, abs(x1 - x2) * abs(y1 - y2))
                }
            }
        }

        return minArea == Int.max ? 0 : minArea
    }
}

print(Solution().minAreaRect([[1,1], [1,3], [3,1], [3,3], [2,2]]))
print(Solution().minAreaRect([[1,1], [1,3], [3,1], [3,3], [4,1], [4,3]]))
