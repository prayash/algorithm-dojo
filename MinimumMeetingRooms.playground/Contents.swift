/**
 Given an array of meeting time intervals consisting of start and end times,
 find the minimum number of conference rooms required.

 Input: [[0, 30], [5, 10], [15, 20]]
 Output: 2:

 Input: [[7,10],[2,4]]
 Output: 1
 */

class Solution {
    /**
     O(n log n): All we are doing is sorting the start & end arrays individually
     and each of them would contain n elements considering there are n intervals.
     */
    func minMeetingRooms(_ intervals: [[Int]]) -> Int {
        guard intervals.count > 1 else { return intervals.count }

        var minRooms: Int = 0

        // Separate out the start and end times and sort them in increasing order
        let startTimes: [Int] = intervals.flatMap { [$0[0]] }.sorted()
        let endTimes: [Int] = intervals.flatMap { [$0[1]] }.sorted()

        // Consider two pointers, start and end, startPointer iterates over all the meetings
        // and endPointer helps track if a meeting has ended

        var endPointer: Int = 0
        for startPointer in 0..<intervals.count {
            // If endTime is bigger than a startTime, we know a meeting has ended!
            if startTimes[startPointer] < endTimes[endPointer] {
                minRooms += 1
            } else {
                endPointer += 1
            }
        }

        return minRooms
    }
}

var intervals = [[0, 30], [5, 10], [15, 20]]
print(Solution().minMeetingRooms(intervals))

intervals = [[7, 10], [2, 4]]
print(Solution().minMeetingRooms(intervals))

intervals = [[5, 8], [6, 8]]
print(Solution().minMeetingRooms(intervals))

intervals = [[13, 15], [1, 13],[6, 9]]
print(Solution().minMeetingRooms(intervals))
