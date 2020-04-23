/**
 Given a collection of intervals, merge all overlapping intervals.

 Input: [[1,3],[2,6],[8,10],[15,18]]
 Output: [[1,6],[8,10],[15,18]]
 Explanation: Since intervals [1,3] and [2,6] overlaps, merge them into [1,6].
 */

class Solution {
    /**
     O(n log n) solution due to the sorting, and enumerating over the list once.
     O(n) space, because we're holding the merged values (worst-case there will be no overlap).
     Could be O(1) space if we were allowed to sort in-place.
     */
    func merge(_ intervals: [[Int]]) -> [[Int]] {
        var merged: [[Int]] = []

        // Sort the intervals by start so we can test for overlaps sequentially
        let sorted = intervals.sorted { $0[0] < $1[0] }

        // Iterate the intervals
        for interval in sorted {
            if !merged.isEmpty && interval[0] <= merged.last![1] {
                // If the current interval overlaps with the last
                // rewrite the last interval with the
                // higher end value, the start value must be <= current
                // due to the prior sort
                merged[merged.count - 1][1] = max(merged.last![1], interval[1])
            } else {
                // No overlap (or no last), append current interval
                merged.append(interval)
            }
        }

        return merged
    }

    func findGaps(_ intervals: [[Int]]) -> [[Int]] {
        // Sort the intervals by start so we can test for overlaps sequentially
        let sorted = intervals.sorted { $0[0] < $1[0] }

        var gaps: [[Int]] = []
        var i = 0, j = 1

        while i < sorted.count && j < sorted.count {
            // If it's greater than the previous val + 1 as spacer
            if sorted[j][0] > sorted[i][1] + 1 {
                gaps.append([sorted[i][1] + 1, sorted[j][0] - 1])
            }

            i += 1
            j += 1
        }

        return gaps
    }
}

var input = [[1, 4], [4, 5]]
print(Solution().merge(input))

input = [[8, 10], [15, 18], [25, 28]]
print(Solution().findGaps(input))

input = [[4, 5], [1, 3], [18, 23], [6, 12]]
print(Solution().findGaps(input))
