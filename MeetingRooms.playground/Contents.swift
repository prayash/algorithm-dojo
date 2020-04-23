/**
 Given an array of meeting time intervals consisting of start and end times
 [[s1,e1],[s2,e2],...] (si < ei), determine if a person could attend all meetings.

 Example 1:

 Input: [[0,30],[5,10],[15,20]]
 Output: false
 */

class Solution {
    // Brute force (On ^ 2) time
    func canAttendMeetingsNaive(_ intervals: [[Int]]) -> Bool {
        for i in 0..<intervals.count {
            for j in i + 1..<intervals.count {
                // If the next meeting starts BEFORE this one ends
                if max(intervals[i][0], intervals[j][0]) < min(intervals[i][1], intervals[j][1]) {
                    return false
                }
            }
        }

        return true
    }

    // O(n log n)
    func canAttendMeetings(_ intervals: [[Int]]) -> Bool {
        let sorted = intervals.sorted { $0[0] < $1[0] }

        for i in 0..<sorted.count - 1 {
            if sorted[i + 1][0] < sorted[i][1] {
                return false
            }
        }

        return true
    }
}

print(Solution().canAttendMeetings([[0,30],[5,10],[15,20]]))
