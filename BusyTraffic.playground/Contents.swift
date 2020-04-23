/**
 Given a list of cars traveling from point start to end with speed in the format [start, end, speed].
 You need to return the list of smallest intervals (segments) and the average speed of vehicles in
 each of those intervals.

 Used for road color coding as per traffic prediction used in google maps or lately uber.
 */

class Solution {
    struct Event: CustomStringConvertible {
        enum `Type` { case open, close }

        var type: Type
        var x: Int
        var speed: Int

        var description: String { return "\(type) - [x: \(x), speed: \(speed)]" }
    }

    /**
     Split by start points and end points.
     - Complexity: O(n log n)
     */
    func busyTraffic(_ cars: [[Int]]) -> [[Int]] {
        var events = [Event]()
        cars.forEach {
            events.append(Event(type: .open, x: $0[0], speed: $0[2]))
            events.append(Event(type: .close, x: $0[1], speed: $0[2]))
        }

        events.sort { $0.x < $1.x }
        print(events)

        var result = [[Int]]()
        var prevX = events.count > 0 ? events[0].x : 0
        var sum = 0
        var count = 0

        events.forEach { event in
            if event.x != prevX {
                result.append([prevX, event.x, sum / count])
                prevX = event.x
            }

            if event.type == .open {
                sum += event.speed
                count += 1
            } else {
                sum -= event.speed
                count -= 1
            }
        }

        return result
    }
}

// [[0, 3, 90], [3, 14, 85], [14, 15, 80]]
//print(Solution().busyTraffic([[0, 14, 90], [3, 15, 80]]))

// [[5, 10, 20], [10, 15, 25], [15, 20, 30]]
print(Solution().busyTraffic([[5, 15, 20], [10, 20, 30]]))

// [[5, 7, 20], [7, 10, 15], [10, 15, 20], [15, 20, 20], [20, 25, 10]]
//print(Solution().busyTraffic([[5, 15, 20], [10, 20, 30], [7, 25, 10]]))
