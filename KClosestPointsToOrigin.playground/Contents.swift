/**
 We have a list of points on the plane. Find the K closest points to the origin (0, 0).
 (Here, the distance between two points on a plane is the Euclidean distance.)
 You may return the answer in any order. The answer is guaranteed to be unique (except
 for the order that it is in.)

 https://leetcode.com/problems/k-closest-points-to-origin/discuss/220235/Java-Three-solutions-to-this-classical-K-th-problem.

     Input: points = [[1, 3], [-2, 2]], K = 1
     Output: [[-2, 2]]
     Explanation:
     The distance between (1, 3) and the origin is sqrt(10).
     The distance between (-2, 2) and the origin is sqrt(8).
     Since sqrt(8) < sqrt(10), (-2, 2) is closer to the origin.
     We only want the closest K = 1 points from the origin, so the answer is just [[-2,2]].
*/
class Solution {
    /**
     We can maintain a max-heap with size K. Then for each point, we add it to the heap.
     Once the size of the heap is greater than K, we are supposed to extract one from the max heap
     to ensure the size of the heap is always K. Thus, the max heap is always maintain top K
     smallest elements from the first one to current one. Once the size of the heap is over
     its maximum capacity, it will exclude the maximum element in it, since it can not be
     the proper candidate anymore.

     - Complexity: O(n log k) where n is number of points and k is output size.
     */
    func kClosest(_ points: [[Int]], _ K: Int) -> [[Int]] {
        var maxHeap = Heap<[Int]> {
            // sqrt(x ^ 2 + y ^ 2) (Euclidean distance)
            return $0[0] * $0[0] + $0[1] * $0[1] < $1[0] * $1[0] + $1[1] * $1[1]
        }

        for p in points {
            maxHeap.insert(p)

            if maxHeap.count > K {
                maxHeap.remove()
            }
        }

        var result: [[Int]] = []
        for _ in 0...K - 1 {
            result.append(maxHeap.remove()!)
        }

        return result
    }
}

print(Solution().kClosest([[1, 3], [-2, 2]], 1))
print(Solution().kClosest([[3, 3], [5, -1], [-2, 4]], 2))
