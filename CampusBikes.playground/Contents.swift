/**
 On a campus represented as a 2D grid, there are N workers and M bikes, with N LToE to M. Each
 worker and bike is a 2D coordinate on this grid.

 Our goal is to assign a bike to each worker. Among the available bikes and workers, we
 choose the (worker, bike) pair with the shortest Manhattan distance between each other, and
 assign the bike to that worker. (If there are multiple (worker, bike) pairs with the same
 shortest Manhattan distance, we choose the pair with the smallest worker index; if there
 are multiple ways to do that, we choose the pair with the smallest bike index). We repeat
 this process until there are no available workers.

 The Manhattan distance between two points p1 and p2 is:
 Manhattan(p1, p2) = |p1.x - p2.x| + |p1.y - p2.y|.

 Return a vector answer of length N, where ans[i] is the index (0-indexed) of the bike
 that the i-th worker is assigned to.
 */

class Solution {
    /**
     Bucket sort.
     - Complexity: O(n * m) time and space.
     */
    func assignBikes(_ workers: [[Int]], _ bikes: [[Int]]) -> [Int] {
        var ans = Array(repeating: -1, count: workers.count)
        var distances = [[[Int]]].init(repeating: [], count: 2001)
        var bikesTaken = [Bool].init(repeating: false, count: bikes.count)

        for (workerIdx, w) in workers.enumerated() {
            for (bikeIdx, b) in bikes.enumerated() {
                // Calculate Manhattan distance
                let dist = abs(w[0] - b[0]) + abs(w[1] - b[1])

                // distances[i] is a tuple of worker and bike index
                distances[dist].append([workerIdx, bikeIdx])
            }
        }

        for dist in distances {
            for pair in dist {
                let workerIdx = pair[0]
                let bikeIdx = pair[1]

                // If the bike isn't assigned and the worker hasn't found a bikey yet
                if !bikesTaken[bikeIdx] && ans[workerIdx] == -1 {
                    bikesTaken[bikeIdx].toggle()

                    ans[workerIdx] = bikeIdx
                }
            }
        }

        return ans
    }
}

var workers = [[0, 0], [2, 1]]
var bikes = [[1, 2], [3, 3]]
print(Solution().assignBikes(workers, bikes))
