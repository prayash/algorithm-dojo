/**
 Given a collection of intervals, find the minimum number of intervals you need to remove to make
 the rest of the intervals non-overlapping.

 Example 1:
 Input: [[1,2],[2,3],[3,4],[1,3]]
 Output: 1
 Explanation: [1,3] can be removed and the rest of intervals are non-overlapping.

 Example 2:
 Input: [[1,2],[1,2],[1,2]]
 Output: 2
 Explanation: You need to remove two [1,2] to make the rest of intervals non-overlapping.

 Example 3:
 Input: [[1,2],[2,3]]
 Output: 0
 Explanation: You don't need to remove any of the intervals since they're already non-overlapping.
 */

class Solution {

    func eraseOverlapIntervals(_ intervals: [[Int]]) -> Int {
        guard intervals.count > 0 else { return 0 }

        let intervals = intervals.sorted { $0[1] < $1[1] }
        var prevEnd = intervals[0][1]
        var count = 0

        for i in 1..<intervals.count {
            // If there is an overlap between the current start time and the last end time
            if intervals[i][0] < prevEnd {
                count += 1
            } else {
                prevEnd = intervals[i][1]
            }
        }

        return count
    }
}

print(Solution().eraseOverlapIntervals([[1,2], [2,3], [3,4], [1,3]]))
print(Solution().eraseOverlapIntervals([[1,2], [1,2], [1,2]]))
print(Solution().eraseOverlapIntervals([[1,2], [2,3]]))
print(Solution().eraseOverlapIntervals([[1,100], [11,22], [1,11], [2,12]]))

// [1, 2] [1, 3] [2, 3] [3, 4]
