/**
 Write a function mergeRanges() that takes an array of multiple meeting time ranges
 and returns an array of condensed ranges.
 */

class Meeting: CustomStringConvertible {
    var startTime: Int
    var endTime: Int

    init(startTime: Int, endTime: Int) {
        // Number of 30 min blocks past 9:00 am
        self.startTime = startTime
        self.endTime = endTime
    }

    var description: String {
        return "(\(startTime), \(endTime))"
    }
}

class Solution {
    /**
     O(n log n) time and O(n) space.
     */
    func mergeMeetingTimes(_ meetings: [Meeting]) -> [Meeting] {
        let sorted = meetings.sorted {( $0.startTime < $01.startTime )}
        var merged = [sorted[0]]

        for i in 1..<sorted.count {
            let current = sorted[i]
            let lastMerged = merged[merged.count - 1]

            if current.startTime <= lastMerged.endTime {
                // There is overlap, overwrite the last record with the later endTime value
                lastMerged.endTime = max(lastMerged.endTime, current.endTime)
            } else {
                // It doesn't overlap, append to result
                merged.append(current)
            }
        }

        return merged
    }
}

let meetings = [
    Meeting(startTime: 0,  endTime: 1),
    Meeting(startTime: 3,  endTime: 5),
    Meeting(startTime: 4,  endTime: 8),
    Meeting(startTime: 10, endTime: 12),
    Meeting(startTime: 9,  endTime: 10)
]

print(Solution().mergeMeetingTimes(meetings))
